import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../cuisine/models/chef.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen(
      {super.key, required this.chef, required this.currentUserId});
  final Chef chef;
  final String currentUserId;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  late IO.Socket socket;
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    initSocket();
    loadChatHistory();
  }

  void initSocket() {
    socket = IO.io('http://10.0.2.2:2004', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.onConnect((_) {
      setState(() {
        isConnected = true;
      });
      socket.emit('join', widget.currentUserId);
    });

    socket.on('message', (data) {
      setState(() {
        _messages.add({
          'message': data['message'],
          'isMe': data['senderId'] == widget.currentUserId,
        });
      });
    });

    socket.onDisconnect((_) {
      setState(() {
        isConnected = false;
      });
    });
  }

  Future<void> loadChatHistory() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://10.0.2.2:2004/chat/history/${widget.currentUserId}/${widget.chef.id}'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _messages.clear();
          _messages.addAll(data
              .map((msg) => {
                    'message': msg['message'],
                    'isMe': msg['senderId'] == widget.currentUserId,
                  })
              .toList());
        });
      }
    } catch (e) {
      print('Error loading chat history: $e');
    }
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty && isConnected) {
      socket.emit('message', {
        'senderId': widget.currentUserId,
        'receiverId': widget.chef.id,
        'message': _controller.text,
      });

      setState(() {
        _messages.add({
          'message': _controller.text,
          'isMe': true,
        });
        _controller.clear();
      });
    }
  }

  @override
  void dispose() {
    socket.disconnect();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDF7F2),
      appBar: AppBar(
        title: Text(
          widget.chef.username,
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Color(0xFFFDF7F2),
        foregroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
        leading: const BackButton(),
        actions: [
          IconButton(
            icon: Icon(
              isConnected ? Icons.wifi : Icons.wifi_off,
              color: isConnected ? Colors.green : Colors.red,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/no_message.png', height: 100),
                        const SizedBox(height: 10),
                        Text(
                          'No Messages',
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    reverse: true,
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      return Align(
                        alignment: message['isMe']
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 8,
                          ),
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: message['isMe']
                                ? Color(0xFF1E451B)
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            message['message'],
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color:
                                  message['isMe'] ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 55,
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF1E451B)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Type Message',
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 14,
                        ),
                        labelStyle: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 4, right: 10, bottom: 4, top: 4),
                    decoration: BoxDecoration(
                      color: Color(0xFF1E451B),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: Transform.rotate(
                        angle: -3.14 / 4,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 9.0,
                            left: 7,
                            top: 2,
                            right: 2,
                          ),
                          child: Icon(
                            const IconData(0xe571, fontFamily: 'MaterialIcons'),
                            size: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onPressed: _sendMessage,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

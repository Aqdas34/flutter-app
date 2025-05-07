import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:only_shef/main.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:only_shef/pages/send_offer/screens/send_offer_screen.dart';
import 'package:only_shef/pages/send_offer/models/offer.dart';
import 'package:only_shef/common/colors/colors.dart';

import '../../cuisine/models/chef.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    Key? key,
    required this.chef,
    required this.currentUserId,
    this.initialOffer,
  }) : super(key: key);
  final Chef chef;
  final String currentUserId;
  final Offer? initialOffer;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  late IO.Socket socket;
  bool isConnected = false;
  bool isOfferSent = false;
  bool isOfferCancelled = false;

  @override
  void initState() {
    super.initState();
    print('Initial offer: ${widget.initialOffer?.toJson()}');
    initSocket();
    loadChatHistory();
    if (widget.initialOffer != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _sendOfferDetails(widget.initialOffer!);
      });
      if (_messages.isEmpty) {
        final offer = widget.initialOffer!;
        final offerMessage = '''
Offer Details:
Date: ${offer.date.toString().split(' ')[0]}
Time: ${offer.time}
Cuisine: ${offer.selectedCuisines.join(', ')}
Number of Persons: ${offer.numberOfPersons}
Total Amount: \$${(offer.selectedCuisines.length * offer.numberOfPersons * 50).toStringAsFixed(2)}
Additional Comments: ${offer.comments}
''';
        _messages.add({
          'message': offerMessage,
          'isMe': true,
          'isOffer': true,
          'offerStatus': 'sent',
        });
      }
    }
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
          'isOffer': data['isOffer'] ?? false,
          'offerStatus': data['offerStatus'],
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
                    'isOffer': msg['isOffer'] ?? false,
                    'offerStatus': msg['offerStatus'],
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

  void _sendOfferDetails(Offer offer) {
    if (isConnected) {
      print('Sending offer details: ${offer.toJson()}');
      final offerMessage = '''
Offer Details:
Date: ${offer.date.toString().split(' ')[0]}
Time: ${offer.time}
Cuisine: ${offer.selectedCuisines.join(', ')}
Number of Persons: ${offer.numberOfPersons}
Total Amount: \$${(offer.selectedCuisines.length * offer.numberOfPersons * 50).toStringAsFixed(2)}
Additional Comments: ${offer.comments}
''';

      socket.emit('message', {
        'senderId': widget.currentUserId,
        'receiverId': widget.chef.id,
        'message': offerMessage,
        'isOffer': true,
        'offerStatus': 'sent',
      });

      setState(() {
        _messages.add({
          'message': offerMessage,
          'isMe': true,
          'isOffer': true,
          'offerStatus': 'sent',
        });
        isOfferSent = true;
        print(
            'Offer message added to _messages. Current messages: ${_messages.length}');
        print('Messages: \\n$_messages');
      });
    }
  }

  void _cancelOffer() {
    if (isConnected && isOfferSent && !isOfferCancelled) {
      socket.emit('message', {
        'senderId': widget.currentUserId,
        'receiverId': widget.chef.id,
        'message': 'Offer has been cancelled',
        'isOffer': true,
        'offerStatus': 'cancelled',
      });

      setState(() {
        // Update the last offer message's status
        for (int i = _messages.length - 1; i >= 0; i--) {
          if (_messages[i]['isOffer'] == true) {
            _messages[i]['offerStatus'] = 'cancelled';
            break;
          }
        }
        isOfferCancelled = true;
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
      resizeToAvoidBottomInset: true,
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
                      return message['isOffer'] == true
                          ? Align(
                              alignment: message['isMe'] == true
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(right: 16),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.65,
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    margin: EdgeInsets.symmetric(vertical: 4),
                                    decoration: BoxDecoration(
                                      color: secondryColor,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Builder(
                                      builder: (context) {
                                        // Parse offer details from message string
                                        final lines =
                                            message['message'].split('\n');
                                        String date = '';
                                        String time = '';
                                        String cuisine = '';
                                        String budget = '';
                                        for (var line in lines) {
                                          if (line.trim().startsWith('Date:')) {
                                            date = line
                                                .replaceFirst('Date:', '')
                                                .trim();
                                          } else if (line
                                              .trim()
                                              .startsWith('Time:')) {
                                            time = line
                                                .replaceFirst('Time:', '')
                                                .trim();
                                          } else if (line
                                              .trim()
                                              .startsWith('Cuisine:')) {
                                            cuisine = line
                                                .replaceFirst('Cuisine:', '')
                                                .trim();
                                          } else if (line
                                              .trim()
                                              .startsWith('Total Amount:')) {
                                            budget = line
                                                .replaceFirst(
                                                    'Total Amount:', '')
                                                .replaceAll(' 24', '')
                                                .trim();
                                          }
                                        }
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Center(
                                              child: Text(
                                                'Offer Details',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.bold,
                                                  color: primaryColor,
                                                ),
                                              ),
                                            ),
                                            // SizedBox(height: 10),
                                            SizedBox(height: 12),
                                            Center(
                                              child: Text(
                                                cuisine,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: primaryColor,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 18),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.calendar_month,
                                                  color: primaryColor,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  date,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 15,
                                                    color: primaryColor,
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Text(
                                                  "At " + time,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 15,
                                                    color: primaryColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Icon(
                                                    Icons.person_2,
                                                    color: primaryColor,
                                                    size: 20,
                                                  ),
                                                  Text(
                                                    '${widget.initialOffer?.numberOfPersons} Person',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      color: primaryColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    '$budget',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: primaryColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            if (message['isMe'] == true &&
                                                message['offerStatus'] !=
                                                    'cancelled')
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          'Offer Sent',
                                                          style: GoogleFonts
                                                              .poppins(
                                                            color: primaryColor,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        ElevatedButton(
                                                          onPressed:
                                                              _cancelOffer,
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                Colors.red,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                            ),
                                                            elevation: 0,
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        18,
                                                                    vertical:
                                                                        8),
                                                          ),
                                                          child: Text(
                                                            'Cancel Offer',
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            if (message['offerStatus'] ==
                                                'cancelled')
                                              Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: Text(
                                                    'Offer Cancelled',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Align(
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
                                    color: message['isMe']
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
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
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 14),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 4),
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
                                const IconData(0xe571,
                                    fontFamily: 'MaterialIcons'),
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
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  height: screen_height * 0.065,
                  child: ElevatedButton(
                    onPressed: isOfferSent
                        ? (isOfferCancelled ? null : _cancelOffer)
                        : () async {
                            final result = await Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SendOfferScreen(
                                  chefId: widget.chef.id,
                                  selectedDate: DateTime.now(),
                                  chef: widget.chef,
                                ),
                              ),
                            );
                            if (result != null && result is Offer) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatScreen(
                                    chef: widget.chef,
                                    currentUserId: widget.currentUserId,
                                    initialOffer: result,
                                  ),
                                ),
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isOfferSent
                          ? (isOfferCancelled ? Colors.grey : Colors.red)
                          : Color(0xFF1E451B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      isOfferSent
                          ? (isOfferCancelled
                              ? 'Offer Cancelled'
                              : 'Cancel Offer')
                          : 'Send Offer',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

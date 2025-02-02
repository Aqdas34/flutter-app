import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add(_controller.text);
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDF7F2),
      appBar: AppBar(
        title: Text(
          'chef_ibad',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Color(0xFFFDF7F2),
        foregroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
        leading: const BackButton(),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
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
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.green.shade200,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              _messages[index],
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.black,
                              ),
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
                        angle: -3.14 / 4, // 270 degrees (3π/2)
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
                    // child: IconButton(
                    //   icon: Image.asset('assets/send_message.png', height: 24, width: 24,fit: BoxFit.cover,),
                    //   onPressed: _sendMessage,
                    // ),
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

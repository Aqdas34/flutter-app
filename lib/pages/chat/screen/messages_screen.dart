import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:only_shef/pages/chat/widgets/message_widget.dart';
import 'package:only_shef/widgets/custom_menu_button.dart';

import '../../../common/colors/colors.dart';
import '../data/dummy_data.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ThreeGreenBarsMenu(),
                Text(
                  'Messages',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox()
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFF5F5F3),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: primaryColor),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: Color(0xFF9F9F9F),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          maintainHintHeight: true,
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Color(0xFF9F9F9F),
                          ),
                          border: InputBorder.none,
                        ),
                        style: GoogleFonts.poppins(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      MessageItemWidget(
                        profilePicture: messages[index]['profilePicture'],
                        name: messages[index]['name'],
                        time: messages[index]['time'],
                        message: messages[index]['message'],
                        isUnread: messages[index]['isUnread'],
                        numberofMessagesPending:
                            messages[index]['numberofMessagesPending'] > 10
                                ? '10+'
                                : messages[index]['numberofMessagesPending']
                                    .toString(),
                      ),
                      if (index < messages.length - 1)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Divider(
                            thickness: 1,
                            indent: MediaQuery.of(context).size.width * 0.05,
                            endIndent: MediaQuery.of(context).size.width * 0.05,
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

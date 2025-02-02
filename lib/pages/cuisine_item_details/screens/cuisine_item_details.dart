import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:only_shef/pages/cuisine_item_details/widgets/Tags_Widget.dart';
import 'package:only_shef/pages/cuisine_item_details/widgets/hexagon_icon.dart';

import '../../chat/screen/chat_screen.dart';

class CuisineItemDetails extends StatelessWidget {
  const CuisineItemDetails({super.key});

  final String chefName = "Alex Bhatti";
  final String chuisineName = "Chicken Biryani";
  final bool isChefAvaiblable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFDF7F2),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //  SafeArea(
            //    child:
            Container(
              height: 283,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: Colors.green,
                image: DecorationImage(
                  image: NetworkImage("https://i.ibb.co/C3vh2Yvw/image-6.png"),
                  fit: BoxFit.cover,
                ),
              ),
              //    ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: Text(
                chuisineName,
                style: GoogleFonts.poppins(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            SizedBox(height: 20),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              alignment: Alignment.centerLeft,
              child: Text("Cuisines",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  )),
            ),

            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: TagsWidget(value: "Pakistani"),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              alignment: Alignment.centerLeft,
              child: Text(
                "Event Type",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Wrap(
                    spacing: 10, // Add spacing between tags
                    children: [
                      TagsWidget(value: "Wedding"),
                      TagsWidget(value: "Naming"),
                      TagsWidget(value: "Gathering"),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 28,
            ),
            Container(
              height: 66,
              margin: EdgeInsets.symmetric(horizontal: 7),
              padding: EdgeInsets.only(left: 20, right: 15),
              decoration: BoxDecoration(
                color: Color(0xFFE1E1D7),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Use an Image for the icon
                  ClipPath(
                    clipper: HexagonClipper(),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            isChefAvaiblable
                                ? Colors.teal.shade700
                                : Colors.red.shade700, // Darker red
                            isChefAvaiblable
                                ? Colors.green
                                : Colors.red, // Base red
                            Colors.white38, // Shiny effect
                          ],
                          stops: [0.0, 0.7, 1.0],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      height: 40,
                      width: 40,
                      child: Center(
                        child: Icon(
                          Icons.remove, // The minus icon
                          color: Colors.white54,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16), // Spacing between the icon and the text
                  Expanded(
                    child: Text(
                      isChefAvaiblable
                          ? 'Congratulations, the Chef is available. Chef Kasie is usually fully booked.'
                          : 'Sadly, The Chef is all Booked , You can hire him Later',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.black.withAlpha((0.6 * 255).toInt()),
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 28,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Get in touch with chef $chefName and discuss the details of your event and the requirements you have, and you will get a quote that fits your budget",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ),
            SizedBox(
              height: 28,
            ),
            Container(
              height: 1,
              margin: EdgeInsets.symmetric(horizontal: 15),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xff1E451B),
              ),
            ),
            SizedBox(
              height: 28,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 7),
              height: 205,
              padding: EdgeInsets.all(15),
              width: double.infinity,
              decoration: BoxDecoration(color: Color(0xffE1E1D7)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "This Service includes",
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons
                            .kitchen_rounded, // Use kitchen icon for "All Ingredients"
                        size: 35,
                        color: Color.fromARGB(255, 153, 115, 26),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "All Ingredients",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF846518)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons
                            .airplanemode_active_rounded, // Use airplane icon for "Chef's travel and insurance costs"
                        size: 35,
                        color: Color.fromARGB(255, 153, 115, 26),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Chef's travel and insurance costs",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF846518)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons
                            .cleaning_services_rounded, // Use cleaning services icon for "Serving and Cleanup"
                        size: 35,
                        color: Color.fromARGB(255, 153, 115, 26),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Serving and Cleanup",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF846518)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "RS 10,000.00",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Material(
                      color: Color(0xff1E451B),
                      borderRadius: BorderRadius.circular(6),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(6),
                        onTap: () {},
                        child: InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatScreen())),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Text(
                              "Message Chef",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

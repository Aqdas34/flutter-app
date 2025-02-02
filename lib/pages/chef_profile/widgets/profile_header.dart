import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../chat/screen/chat_screen.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String username;
  final String bio;
  final int rating;
  final String image;
  final List<String> tags;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.username,
    required this.bio,
    required this.rating,
    required this.image,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none, // Allows profile image to overflow
          alignment: Alignment.center,
          children: [
            // Container(
            //   height: 206,
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //     color: Colors.black,
            //   ),
            // ),
            Image.asset(
              "assets/chef_background.png",
              height: 206, // Increased height for better positioning
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: -50, // Moves profile picture into the white section
              child: Container(
                padding: EdgeInsets.all(10), // White border padding
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  radius: 80, // Slightly larger size
                  backgroundImage: AssetImage(image),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 40), // Adjusted spacing after profile image
        Text(
          name,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(username,
            style: GoogleFonts.poppins(
              color: Colors.grey,
              fontSize: 10,
            )),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            bio,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 12,
            ),
          ),
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Rating:  ",
              style: GoogleFonts.poppins(
                fontSize: 13,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                rating,
                (index) => Icon(Icons.star, color: Colors.amber, size: 13),
              ),
            ),
          ],
        ),

        SizedBox(height: 10),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          children: tags.map((tag) {
            return Chip(
              avatar: Icon(Icons.tag, color: Colors.black, size: 15),
              label: Text(
                tag,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                ),
              ),
              backgroundColor: Colors.grey.shade200,
            );
          }).toList(),
        ),
        // SizedBox(height: 2),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1E451B),
          
                minimumSize: Size(double.infinity, 40),
                // Wider button like the reference
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                "Message",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

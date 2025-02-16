import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../chat/screen/chat_screen.dart';
import '../../cuisine/models/chef.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String username;
  final String bio;
  final int rating;
  final String image;
  final List<String> tags;
  final Chef chef;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.username,
    required this.bio,
    required this.rating,
    required this.image,
    required this.tags,
    required this.chef,
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
            Image.network(
              "https://example.com/chef_background.png",
              height: 206, // Increased height for better positioning
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return Container(
                    height: 206,
                    width: double.infinity,
                    color: Colors.grey.shade200,
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    ),
                  );
                }
              },
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Container(
                  height: 206,
                  width: double.infinity,
                  color: Colors.grey.shade200,
                  child: Center(
                    child: Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 50,
                    ),
                  ),
                );
              },
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 206, // Same height as the image
                width: double.infinity,
                color: Colors.black
                    .withOpacity(0.5), // Placeholder color with opacity
              ),
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
                  backgroundImage: NetworkImage(chef.profileImage),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 40), // Adjusted spacing after profile image
        Text(
          chef.name,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(chef.username,
            style: GoogleFonts.poppins(
              color: Colors.grey,
              fontSize: 10,
            )),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            chef.bio,
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
                chef.rating.floor(),
                (index) => Icon(Icons.star, color: Colors.amber, size: 13),
              ),
            ),
          ],
        ),

        SizedBox(height: 10),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          children: chef.specialties.take(3).map((tag) {
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
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    chef: chef,
                  ),
                ),
              );
            },
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
      ],
    );
  }
}

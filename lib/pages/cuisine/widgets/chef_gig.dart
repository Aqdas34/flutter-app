import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:only_shef/pages/cuisine/widgets/chef_profile.dart';
import 'package:only_shef/pages/cuisine/widgets/gig_arrow.dart';

class ChefGig extends StatelessWidget {
  ChefGig({super.key});

  final List<String> hashtags = ["#Pakistani", "#Cuisine", "#Chef"];

  @override
  Widget build(BuildContext context) {
    int rating = 3;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      height: 263,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.cyan,
        borderRadius: BorderRadius.circular(40),
        // image: DecorationImage(
        //   image: AssetImage('assets/pakistani1.png'),
        //   fit: BoxFit.cover,
        // ),
      ),
      child: Stack(
        children: [
          Positioned(left: 15, top: 15, child: ChefProfile()),
          Positioned(right: 15, top: 15, child: GigArrow()),
          Positioned(
            bottom: 85,
            left: 35,
            child: Row(
              children: [
                Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
                SizedBox(width: 5),
                Text(
                  "14.5k",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                SizedBox(width: 15),
                Icon(
                  Icons.message_outlined,
                  color: Colors.white,
                ),
                SizedBox(width: 5),
                Text(
                  "14.5k",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 62,
            left: 35,
            child: Row(
              children: [
                for (int i = 0; i < 5; i++)
                  Icon(
                    i < rating ? Icons.star : Icons.star_outline,
                    color: Colors.white,
                    size: 22,
                  ),
              ],
            ),
          ),
          Positioned(
            bottom: 27,
            left: 35,
            right: 35, // Add this line to set the right margin
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        "I am Pakistani Cuisine chef specializing in authentic dishes bringing the taste of Pakistan to every bite.",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 11,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

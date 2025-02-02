import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:only_shef/pages/cuisine/screens/cuisine_screen.dart';
import 'package:only_shef/pages/home/widgets/cuisine_custom_card.dart';
import 'package:only_shef/widgets/custom_menu_button.dart';

import 'package:only_shef/widgets/custome_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFDF7F2),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ThreeGreenBarsMenu(),
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage('assets/chef_image.jpg'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "What cuisine chef\nwould you like 2 Select?",
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1E451B),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: GoogleFonts.poppins(),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          prefixIcon: Icon(Icons.search, color: Colors.black54),
                          hintText: "Search food, chefs",
                          hintStyle: GoogleFonts.poppins(color: Colors.black54),
                          labelStyle: GoogleFonts.poppins(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(45),
                            borderSide:
                                BorderSide(width: 1, color: Color(0xFF1E451B)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: Color(0xFF1E451B), width: 1)),
                      // backgroundColor: Color(0xFF1E451B),
                      child:
                          Icon(Icons.notifications, color: Color(0xFF1E451B)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: GridView.count(
                    padding: EdgeInsets.only(
                        top: 5, bottom: 80), // Ensure no padding
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      CustomCuisineCard(
                        cuisineName: "Pakistani",
                        backColor: Color(0xFF1B4149),
                        imageLink: 'assets/turkey.png',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CuisineScreen(
                                    imagePath: 'assets/pakistani1.png',
                                    cuisineName: 'Pakistani Cuisine')),
                          );
                        },
                      ),
                      CustomCuisineCard(
                        backColor: Color(0xFF81C0FF),
                        imageLink: 'assets/chinese_logo.png',
                        cuisineName: "Chinese",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CuisineScreen(
                                    imagePath: 'assets/chinese1.png',
                                    cuisineName: 'Chinese Cuisine')),
                          );
                        },
                      ),
                      CustomCuisineCard(
                        backColor: Color(0xFFCA4943),
                        imageLink: 'assets/mexican_logo.png',
                        cuisineName: "Mexican",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CuisineScreen(
                                    imagePath: 'assets/mexican1.png',
                                    cuisineName: 'Mexican Cuisine')),
                          );
                        },
                      ),
                      CustomCuisineCard(
                        backColor: Color(0xFF8186D9),
                        imageLink: 'assets/fastfood_logo.png',
                        cuisineName: "Fast Food",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CuisineScreen(
                                    imagePath: 'assets/fastfood1.png',
                                    cuisineName: 'Fast Foods')),
                          );
                        },
                      ),
                      CustomCuisineCard(
                        cuisineName: "Desserts",
                        backColor: Color(0xFF77B255),
                        imageLink:
                            'assets/deserts_logo.png', // Make sure to add the correct image path
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CuisineScreen(
                                    imagePath: 'assets/desert1.png',
                                    cuisineName:
                                        'Dessets')), // Update with your screen
                          );
                        },
                      ),
                      CustomCuisineCard(
                        cuisineName: "Others",
                        backColor: Color(0xFFB769D3),
                        imageLink:
                            'assets/others_logo.png', // Make sure to add the correct image path
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CuisineScreen(
                                    imagePath: 'assets/desert1.png',
                                    cuisineName:
                                        'Other Cuisine')), // Update with your screen
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 15,
            left: 50,
            right: 50,
            child: CustomNavigationBar(),
          )
        ],
      ),
    );
  }
}

// class CuisineCard extends StatelessWidget {
//   final String title;
//   final Color color;
//   final IconData icon;
//   final VoidCallback onTap; // Added onTap property

//   const CuisineCard({
//     required this.title,
//     required this.color,
//     required this.icon,
//     required this.onTap, // Marked as required
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap, // Handle tap event
//       child: Container(
//         decoration: BoxDecoration(
//           color: color.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Stack(
//           children: [
//             Center(
//               child: Icon(icon, size: 48, color: color),
//             ),
//             Positioned(
//               bottom: 8,
//               left: 8,
//               child: Text(
//                 title,
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: 8,
//               right: 8,
//               child: CircleAvatar(
//                 backgroundColor: color,
//                 child: Icon(Icons.edit, size: 16, color: Colors.white),
//                 radius: 12,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

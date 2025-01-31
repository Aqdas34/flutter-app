import 'package:flutter/material.dart';
import 'package:only_shef/pages/chinese_cusine/screen/chinese_cusine_screen.dart';
import 'package:only_shef/pages/esserdesserts_cusine/screen/desserts_cusine_screen.dart';
// import 'package:only_shef/esserdesserts_cusine/screen/desserts_cusine_Screen.dart';
import 'package:only_shef/pages/fast_food_cusine/screen/fast_food_cusine_screen.dart';
import 'package:only_shef/pages/mexican_cusine/screen/mexican_cusine_screen.dart';
import 'package:only_shef/pages/home/widgets/cuisine_card.dart';
import 'package:only_shef/pages/pakistan_cusine/screen/pakistani_cusine_screen.dart';
import 'package:only_shef/pancakes_cusine/screen/pancakes_cusine_screen.dart';
// import 'package:only_shef/pancakes_cusine/screen/pancakes_cusine_screen.dart';
import 'package:only_shef/utils/custome_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          CircleAvatar(
            backgroundImage: NetworkImage('https://via.placeholder.com/150'),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "What cuisine chef would you like 2 Select?",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          prefixIcon: Icon(Icons.search, color: Colors.black54),
                          hintText: "Search food, chefs",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Icon(Icons.notifications, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      CuisineCard(
                        color: Colors.teal,
                        imagePath: 'assets/pakistani.png',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PakistaniCuisineScreen()),
                          );
                        },
                      ),
                      CuisineCard(
                        color: Colors.blue,
                        imagePath: 'assets/chinese.png',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChineseCuisineScreen()),
                          );
                        },
                      ),
                      CuisineCard(
                        color: Colors.red,
                        imagePath: 'assets/mexican.png',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MexicanCuisineScreen()),
                          );
                        },
                      ),
                      CuisineCard(
                        color: Colors.deepPurple,
                        imagePath: 'assets/fastfood.png',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FastFoodScreen()),
                          );
                        },
                      ),
                      CuisineCard(
                        color: Colors.orange,
                        imagePath:
                            'assets/desserts.png', // Make sure to add the correct image path
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DessertsScreen()), // Update with your screen
                          );
                        },
                      ),
                      CuisineCard(
                        color: Colors.pink,
                        imagePath:
                            'assets/cakes.png', // Make sure to add the correct image path
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PancakesScreen()), // Update with your screen
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

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:only_shef/pages/cuisine/screens/cuisine_screen.dart';
import 'package:only_shef/pages/home/widgets/cuisine_custom_card.dart';
import 'package:only_shef/widgets/custom_menu_button.dart';

import 'package:only_shef/widgets/custome_nav_bar.dart';
import 'package:provider/provider.dart';

import '../../../provider/user_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, dynamic>> _cuisines = [
    {
      'name': 'Pakistani',
      'color': Color(0xFF1B4149),
      'image': 'assets/turkey.png',
      'cuisineImage': 'assets/pakistani1.png',
    },
    {
      'name': 'Chineese',
      'color': Color(0xFF81C0FF),
      'image': 'assets/chinese_logo.png',
      'cuisineImage': 'assets/chinese1.png',
    },
    {
      'name': 'Mexican',
      'color': Color(0xFFCA4943),
      'image': 'assets/mexican_logo.png',
      'cuisineImage': 'assets/mexican1.png',
    },
    {
      'name': 'Fast Food',
      'color': Color(0xFF8186D9),
      'image': 'assets/fastfood_logo.png',
      'cuisineImage': 'assets/fastfood1.png',
    },
    {
      'name': 'Desserts',
      'color': Color(0xFF77B255),
      'image': 'assets/deserts_logo.png',
      'cuisineImage': 'assets/desert1.png',
    },
    {
      'name': 'Others',
      'color': Color(0xFFB769D3),
      'image': 'assets/others_logo.png',
      'cuisineImage': 'assets/desert1.png',
    },
  ];

  List<Map<String, dynamic>> _filteredCuisines = [];

  @override
  void initState() {
    super.initState();
    _filteredCuisines = _cuisines;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredCuisines = _cuisines;
      } else {
        _filteredCuisines = _cuisines.where((cuisine) {
          return cuisine['name'].toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;

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
                      backgroundImage: NetworkImage(user.profileImage),
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
                        controller: _searchController,
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
                    padding: EdgeInsets.only(top: 5, bottom: 80),
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: _filteredCuisines.map((cuisine) {
                      return CustomCuisineCard(
                        cuisineName: cuisine['name'],
                        backColor: cuisine['color'],
                        imageLink: cuisine['image'],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CuisineScreen(
                                    imagePath: cuisine['cuisineImage'],
                                    cuisineName: '${cuisine['name']} Cuisine')),
                          );
                        },
                      );
                    }).toList(),
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

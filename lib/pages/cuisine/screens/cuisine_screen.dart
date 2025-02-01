import 'package:flutter/material.dart';
import 'package:flutter_circular_text/circular_text/model.dart';
import 'package:flutter_circular_text/circular_text/widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:only_shef/pages/cuisine/widgets/chef_gig.dart';
import 'package:only_shef/pages/cuisine/widgets/cuisine_widget.dart';
import 'package:only_shef/widgets/custom_menu_button.dart';
import 'package:only_shef/widgets/custome_nav_bar.dart';

class CuisineScreen extends StatefulWidget {
  const CuisineScreen({super.key});

  @override
  State<CuisineScreen> createState() => _CuisineScreenState();
}

class _CuisineScreenState extends State<CuisineScreen> {
  int _selectedType = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFDF7F2),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                    // color: Colors.yellow,
                    ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 70,
                      left: 30,
                      child: InkWell(
                        child: ThreeGreenBarsMenu(),
                        onTap: () {
                          Scaffold.of(context).openDrawer();
                        },
                      ),
                    ),
                    Positioned(
                      right: -30,
                      top: 50,
                      child: Image(
                        image: AssetImage(
                          'assets/pakistani1.png',
                        ),
                        width: 180,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 26,
                      right: -80,
                      child: CircularText(
                        radius: 137,
                        position: CircularTextPosition.inside,
                        children: [
                          TextItem(
                            text: Text(
                              'Pakistani Cuisine',
                              style: GoogleFonts.poppins(
                                fontSize: 31,
                                color: Color.fromARGB(40, 30, 69, 27),
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            space: 10,
                            startAngleAlignment: StartAngleAlignment.center,
                            startAngle: -190,
                            direction: CircularTextDirection.clockwise,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                        top: 160,
                        left: 25,
                        child: Text(
                          "Pakistani\nCuisine",
                          style: GoogleFonts.poppins(
                            fontSize: 28,
                            color: Color.fromARGB(
                              255,
                              30,
                              69,
                              27,
                            ),
                            fontWeight: FontWeight.w800,
                          ),
                        )),
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _selectedType = 0;
                      });
                    },
                    child: Text(
                      "Chefs",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Color.fromARGB(255, 30, 69, 27),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(width: 30),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _selectedType = 1;
                      });
                    },
                    child: Text(
                      "Cuisines",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Color.fromARGB(255, 30, 69, 27),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 6,
                    width: 90,
                    decoration: BoxDecoration(
                      color: _selectedType == 1
                          ? Color.fromARGB(55, 30, 69, 27)
                          : Color(0xFF1E451B),
                    ),
                  ),
                  Container(
                    height: 6,
                    width: 90,
                    decoration: BoxDecoration(
                      color: _selectedType == 0
                          ? Color.fromARGB(55, 30, 69, 27)
                          : Color(0xFF1E451B),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Expanded(
                // Wrap SingleChildScrollView with Expanded
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: _selectedType == 0
                      ? Column(
                          children: [
                            ChefGig(),
                            ChefGig(),
                          ],
                        )
                      : Column(
                          children: [
                            SingleCuisineWidget(
                              rating: 4,
                              cuisineName: "Chicken Biryani",
                              imageUrl: "assets/cakes.png",
                              totalOrders: 500,
                              location: "Lahore",
                              cuisineType: "Pakistani",
                            ),
                            SingleCuisineWidget(
                              rating: 4,
                              cuisineName: "Chicken Biryani",
                              imageUrl: "assets/cakes.png",
                              totalOrders: 500,
                              location: "Lahore",
                              cuisineType: "Pakistani",
                            ),
                            SingleCuisineWidget(
                              rating: 4,
                              cuisineName: "Chicken Biryani",
                              imageUrl: "assets/cakes.png",
                              totalOrders: 500,
                              location: "Lahore",
                              cuisineType: "Pakistani",
                            ),
                            SingleCuisineWidget(
                              rating: 4,
                              cuisineName: "Chicken Biryani",
                              imageUrl: "assets/cakes.png",
                              totalOrders: 500,
                              location: "Lahore",
                              cuisineType: "Pakistani",
                            ),
                            SingleCuisineWidget(
                              rating: 4,
                              cuisineName: "Chicken Pallow",
                              imageUrl: "assets/cakes.png",
                              totalOrders: 500,
                              location: "Lahore",
                              cuisineType: "Pakistani",
                            ),
                            SingleCuisineWidget(
                              rating: 4,
                              cuisineName: "Chicken Biryani",
                              imageUrl: "assets/cakes.png",
                              totalOrders: 500,
                              location: "Lahore",
                              cuisineType: "Pakistani",
                            ),
                          ],
                        ),
                ),
              ),
              // Expanded(
              //   child: Stack(
              //     children: [
              //       Positioned(
              //         bottom: 15,
              //         left: 50,
              //         right: 50,
              //         child: CustomNavigationBar(),
              //       )
              //     ],
              //   ),
              // ),
            ],
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

import 'dart:ui';

import 'package:calendar_cc/calendar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:only_shef/common/colors/colors.dart';
import 'package:only_shef/pages/chef_appointments/widgets/apointments.dart';
import 'package:only_shef/widgets/snack_bar_util.dart';
import 'package:provider/provider.dart';

import '../../../provider/user_provider.dart';

class ChefAppointments extends StatefulWidget {
  ChefAppointments({super.key});

  @override
  State<ChefAppointments> createState() => _ChefAppointmentsState();
}

class _ChefAppointmentsState extends State<ChefAppointments> {
  final List<String> _list = [
    "MultiCuisine",
    "Pakistani",
    "Italian",
    "Chinese",
    "Fast Food",
    "Mexican",
    "Others"
  ];

  int currentlySelected = 0;
  DateTime? selectedDate;
  bool isDateSelected = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: EdgeInsets.only(top: 70, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: 10,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: primaryColor,
                  child: Icon(
                    Icons.notifications_on_outlined,
                    color: Colors.white,
                  ),
                ),
                CircleAvatar(
                  radius: 28,
                  backgroundColor: primaryColor,
                  backgroundImage: NetworkImage(user.profileImage),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 305,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Upcomming Appointments",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 255,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 2,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return SizedBox(
                              height: 255, child: AppointmentWidget());
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Hire Your Chef",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Row(
                  children: [
                    Text(
                      isDateSelected
                          ? selectedDate!.day.toString() +
                              ("  ") +
                              getMonthName(selectedDate!.month)
                          : "Select Date",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        DateTime? date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 30)),
                          builder: (BuildContext context, Widget? child) {
                            return Theme(
                              data: ThemeData.light().copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: primaryColor,
                                  onPrimary: Colors.white,
                                  onSurface: Colors.black,
                                ),
                                dialogBackgroundColor: Colors.white,
                                textTheme: TextTheme(
                                  displayLarge: GoogleFonts.poppins(),
                                  displayMedium: GoogleFonts.poppins(),
                                  displaySmall: GoogleFonts.poppins(),
                                  headlineLarge: GoogleFonts.poppins(),
                                  headlineMedium: GoogleFonts.poppins(),
                                  headlineSmall: GoogleFonts.poppins(),
                                  titleLarge: GoogleFonts.poppins(),
                                  titleMedium: GoogleFonts.poppins(),
                                  titleSmall: GoogleFonts.poppins(),
                                  bodyLarge: GoogleFonts.poppins(),
                                  bodyMedium: GoogleFonts.poppins(),
                                  bodySmall: GoogleFonts.poppins(),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (date != null) {
                          // showSuccess(context, "Date Selected: $date");
                          setState(() {
                            isDateSelected = true;
                            selectedDate = date;
                          });
                        }
                      },
                      icon: Icon(
                        Icons.calendar_today_outlined,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                // Calendar(
                //   initialDate: DateTime.now(),
                //   onDateSelected: (date) {
                //     showSuccess(context, "Date Selected: $date");
                //   },
                // ),
              ],
            ),
            SizedBox(
              height: 34,
              // color: secondryColor,
              child: ListView.builder(
                // shrinkWrap: true,
                itemCount: _list.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 30,
                    child: Container(
                      padding: EdgeInsets.only(right: 15),
                      decoration: BoxDecoration(
                        color: index == currentlySelected
                            ? primaryColor
                            : const Color.fromARGB(255, 209, 200, 200),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      margin: EdgeInsets.only(right: 10),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: () {
                          setState(() {
                            currentlySelected = index;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 7),
                            SizedBox(
                              // onPressed: () {
                              //   setState(() {
                              //     currentlySelected = index;
                              //   });
                              // },
                              child: Image.asset(
                                index == 0
                                    ? "assets/images/chef.png"
                                    : "assets/images/cooking.png",
                                color: index == currentlySelected
                                    ? Colors.white
                                    : primaryColor,
                                height: 18,
                              ),
                            ),
                            SizedBox(width: 6), // Adjust the width as needed
                            Text(
                              _list[index],
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: index == currentlySelected
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 230,
              child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    height: 50,
                    width: 180,
                    margin: EdgeInsets.only(right: 15),
                    padding: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      color: secondryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Image.asset("assets/images/newchef.png"),
                        ),
                        Positioned(
                          bottom: 5,
                          left: 5,
                          child: ClipRRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Container(
                                padding: EdgeInsets.all(12),
                                width: 170,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: Colors.white
                                      .withOpacity(0.2), // Transparent color
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: Colors.white
                                        .withOpacity(0.3), // Border effect
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Ayesha Ali",
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "Pakistani Chef",
                                      style: GoogleFonts.poppins(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: primaryColor,
                            child: Icon(
                              Icons.arrow_outward_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 10,
                          child: SizedBox(
                            height: 35,
                            width: 35,
                            child: Image.asset(
                              'assets/images/available_icon.png',
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getMonthName(int month) {
    const List<String> months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    if (month < 1 || month > 12) {
      throw ArgumentError("Month must be between 1 and 12");
    }
    return months[month - 1];
  }
}

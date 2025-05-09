import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:only_shef/widgets/chef_nav_bar.dart';

class ChefAppointmentsScreen extends StatefulWidget {
  const ChefAppointmentsScreen({super.key});

  @override
  State<ChefAppointmentsScreen> createState() => _ChefAppointmentsScreenState();
}

class _ChefAppointmentsScreenState extends State<ChefAppointmentsScreen> {
  int _currentIndex = 1; // Appointments index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFDF7F2),
      appBar: AppBar(
        backgroundColor: Color(0xFF1E451B),
        title: Text(
          'Appointments',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today,
              size: 80,
              color: Color(0xFF1E451B).withOpacity(0.5),
            ),
            SizedBox(height: 16),
            Text(
              'No Appointments Yet',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF333333),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Your upcoming appointments will appear here',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Color(0xFF707070),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ChefNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/chef-home');
              break;
            case 1:
              // Already on appointments screen
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/chef-messages');
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/chef-profile');
              break;
          }
        },
      ),
    );
  }
}

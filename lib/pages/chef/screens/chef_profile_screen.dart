import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:only_shef/widgets/chef_nav_bar.dart';
import 'package:provider/provider.dart';
import '../../../provider/user_provider.dart';

class ChefProfileScreen extends StatefulWidget {
  const ChefProfileScreen({super.key});

  @override
  State<ChefProfileScreen> createState() => _ChefProfileScreenState();
}

class _ChefProfileScreenState extends State<ChefProfileScreen> {
  int _currentIndex = 3; // Profile index

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;

    return Scaffold(
      backgroundColor: Color(0xffFDF7F2),
      appBar: AppBar(
        backgroundColor: Color(0xFF1E451B),
        title: Text(
          'Profile Settings',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(user.profileImage),
                  ),
                  SizedBox(height: 16),
                  Text(
                    user.name,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    user.email,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Color(0xFF707070),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Settings Options
            Text(
              'Settings',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            SizedBox(height: 16),
            _buildMenuOption(
              icon: Icons.edit,
              title: 'Edit Profile',
              onTap: () {
                Navigator.pushNamed(context, '/profile-settings');
              },
            ),
            _buildMenuOption(
              icon: Icons.notifications,
              title: 'Notifications',
              onTap: () {
                // Navigate to notifications settings
              },
            ),
            _buildMenuOption(
              icon: Icons.security,
              title: 'Privacy & Security',
              onTap: () {
                // Navigate to privacy settings
              },
            ),
            _buildMenuOption(
              icon: Icons.help,
              title: 'Help & Support',
              onTap: () {
                // Navigate to help center
              },
            ),
            _buildMenuOption(
              icon: Icons.info,
              title: 'About',
              onTap: () {
                // Navigate to about page
              },
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Handle logout
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Logout',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
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
              Navigator.pushReplacementNamed(context, '/chef-appointments');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/chef-messages');
              break;
            case 3:
              // Already on profile screen
              break;
          }
        },
      ),
    );
  }

  Widget _buildMenuOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        margin: EdgeInsets.only(bottom: 12),
        child: Row(
          children: [
            Icon(icon, color: Color(0xFF1E451B)),
            SizedBox(width: 16),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Color(0xFF333333),
              ),
            ),
            Spacer(),
            Icon(Icons.chevron_right, color: Color(0xFF707070)),
          ],
        ),
      ),
    );
  }
}

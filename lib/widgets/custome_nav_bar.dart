import 'package:flutter/material.dart';
import 'package:only_shef/pages/chat/screen/messages_screen.dart';
import 'package:only_shef/pages/home/screen/home_screen.dart';
import 'package:only_shef/pages/settings/screens/profile_setting_screen.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int _selectedIndex = 0; // Tracks the selected navigation item

  // List of icons and corresponding screens
  final List<Map<String, dynamic>> _navItems = [
    {'icon': Icons.home, 'screen': HomeScreen()},
    {'icon': Icons.settings, 'screen': ProfileSettingScreen()},
    {'icon': Icons.message, 'screen': MessagesScreen()},
    {'icon': Icons.person, 'screen': HomeScreen()},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Color(0xFF1E451B), // Dark green background
        borderRadius: BorderRadius.circular(50),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          _navItems.length,
          (index) => _buildNavItem(index),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index) {
    bool isSelected = index == _selectedIndex;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index; // Update the selected index
        });

        // Navigate to the corresponding screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => _navItems[index]['screen'],
          ),
        );
      },
      child: Container(
        height: 55,
        width: 55,
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white
              : Color(0xFF355B34), // White when selected, light green otherwise
          shape: BoxShape.circle,
          border: Border.all(
              color: Color(0xFF355B34), width: 2), // Light green border
        ),
        child: Icon(
          _navItems[index]['icon'],
          color: isSelected
              ? Colors.green[900]
              : Colors.white, // Green when selected, white otherwise
          size: 35,
        ),
      ),
    );
  }
}

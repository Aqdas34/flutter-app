import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildSectionHeader(String title) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: Color(0xFF707070)),
      ),
    ),
  );
}

Widget buildSettingsCard(List<Widget> children) {
  return Card(
    color: Color(0xFFF0F0F0),
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Column(children: children),
  );
}

Widget buildSwitchTile({
  required IconData icon,
  required String title,
  String? subtitle,
  required bool value,
  required Function(bool) onChanged,
}) {
  return SwitchListTile(
    secondary: Icon(icon, color: Colors.green),
    title: Text(title),
    subtitle: subtitle != null ? Text(subtitle) : null,
    value: value,
    onChanged: onChanged,
    activeColor: Colors.green,
  );
}

Widget buildNavigationTile({
  required IconData icon,
  required String title,
  required VoidCallback onTap,
}) {
  return ListTile(
    leading: Icon(icon, color: Colors.green),
    title: Text(title),
    trailing: Icon(Icons.arrow_forward_ios, size: 16),
    onTap: onTap,
  );
}

Widget buildLogoutButton(BuildContext context) {
  return ListTile(
    leading: Icon(Icons.logout, color: Colors.red),
    title: Text("Logout", style: TextStyle(color: Colors.red)),
    onTap: () {
      showLogoutDialog(context);
    },
  );
}

void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text("Confirm Logout",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 14)),
        content: Text("Are you sure you want to logout?",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(fontSize: 12),),
        actions: [
          TextButton(
            style: TextButton.styleFrom(backgroundColor: Color(0xFFDDDDDD)),
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel",style: GoogleFonts.poppins(color: Color(0xFF117BE8)),),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context);
              // Add your logout logic here
            },
            child: Text("Logout"),
          ),
        ],
      );
    },
  );
}

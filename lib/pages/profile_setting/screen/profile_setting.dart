import 'package:flutter/material.dart';
import 'package:only_shef/common/colors/colors.dart';
import 'package:only_shef/pages/profile_setting/widgets/helper_widgets.dart';
import 'package:provider/provider.dart';
import 'package:only_shef/pages/about/screens/terms_conditions_screen.dart';
import 'package:only_shef/pages/about/screens/about_us_screen.dart';
import 'package:only_shef/pages/about/screens/support_screen.dart';
import 'package:only_shef/pages/profile_setting/screens/edit_profile_screen.dart';
import 'package:only_shef/pages/profile_setting/screens/verification_screen.dart';

import '../../../provider/user_provider.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  _ProfileSettingsScreenState createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  bool isProfileSwitched = false;
  bool isPushNotificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    user.profileImage), // Replace with network image if needed
              ),
              SizedBox(height: 10),
              Text(
                user.name,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333)),
              ),
              Text(
                user.email,
                style: TextStyle(color: Color(0xFF707070), fontSize: 10),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfileScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(93, 35),
                  backgroundColor: Color(0xFF1E451B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  "Edit Profile",
                  style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(height: 20),
              buildSectionHeader("Inventories"),
              buildSettingsCard([
                buildSwitchTile(
                  icon: Icons.swap_horiz,
                  title: "Switch Profiles",
                  subtitle: "User Profile",
                  value: isProfileSwitched,
                  onChanged: (value) {
                    setState(() => isProfileSwitched = value);
                    if (value) {
                      Navigator.pushNamed(context, '/document-capture');
                    }
                  },
                ),
                Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Divider()),
                buildNavigationTile(
                  icon: Icons.support,
                  title: "Support",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SupportScreen(),
                      ),
                    );
                  },
                ),
              ]),

              buildSectionHeader("Settings"),
              buildSettingsCard([
                buildSwitchTile(
                  icon: Icons.notifications,
                  title: "Push Notifications",
                  value: isPushNotificationsEnabled,
                  onChanged: (value) {
                    setState(() => isPushNotificationsEnabled = value);
                  },
                ),
                Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Divider()),
                buildNavigationTile(
                  icon: Icons.info_outline,
                  title: "About Us",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AboutUsScreen(),
                      ),
                    );
                  },
                ),
                Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Divider()),
                buildNavigationTile(
                  icon: Icons.policy,
                  title: "Terms and Conditions",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TermsConditionsScreen(),
                      ),
                    );
                  },
                ),
                Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Divider()),
                buildLogoutButton(context),
              ]),
              // SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

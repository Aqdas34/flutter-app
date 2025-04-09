import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:only_shef/pages/auth/login/screen/login_screen.dart';
import 'package:only_shef/pages/auth/service/register_service.dart';
import 'package:only_shef/services/api_service.dart';
import 'package:only_shef/widgets/snack_bar_util.dart';

import '../../../../common/colors/colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _termsAccepted = false;
  bool _isLoading = false;

  final AuthService _authService = AuthService();

  void _register() async {
    if (_usernameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      // _showError("All fields are required.");
      showError(context, "All fields are required.");
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      // _showError("Passwords do not match.");
      showError(context, "Passwords do not match.");
      return;
    }

    if (!_termsAccepted) {
      showError(context, "You must accept the terms and conditions.");
      // _showError("You must accept the terms and conditions.");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    await _authService.signUpUser(
      name: _usernameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      context: context,
    );

    setState(() {
      _isLoading = false;
    });

    // if (mounted) {
    //   if (response != null && response.statusCode == 200) {
    //     // _showSuccess("Registration successful.");
    //     showSuccess(context, "Registration successful.");
    //     // Navigate to the Login screen if still mounted
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(builder: (context) => LoginScreen()),
    //     );
    //   } else {
    //     showError(context, "Registration failed. Please try again.");
    //     // _showError("Registration failed. Please try again.");
    //   }
    // }
    //  if (response != null && response.statusCode == 200) {
    //   // Handle success, maybe navigate to another screen
    //   _showSuccess("Registration successful.");

    // } else {
    //   _showError("Registration failed. Please try again.");
    // }
  }

//   void _showError(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text(message),
//       backgroundColor: Colors.red,
//     ));
//   }
//  void _showSuccess(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text(message),
//       backgroundColor: Colors.green,
//     ));
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor, // Light background color
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            // Logo Section
            Image.asset(
              'assets/logo.png', // Replace with your logo image path
              height: 230,
            ),

            // Title
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Let’s Get Started",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 1),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Create your own account",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Color(0xFF355B34),
                ),
              ),
            ),
            const SizedBox(height: 15),
            // Name Input
            SizedBox(
              height: 55, // Adjust the height as needed
              child: TextFormField(
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: "eg. Junaid Rafiq",
                  labelStyle:
                      GoogleFonts.poppins(fontSize: 14, color: primaryColor),
                  hintStyle: GoogleFonts.poppins(
                      fontSize: 14, color: Color(0xFFBABABA)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: primaryColor, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: primaryColor, width: 2),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            // Email Input
            SizedBox(
              height: 55, // Adjust the height as needed
              child: TextFormField(
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                  labelStyle:
                      GoogleFonts.poppins(fontSize: 14, color: primaryColor),
                  hintStyle: GoogleFonts.poppins(
                      fontSize: 14, color: Color(0xFFBABABA)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: secondryColor, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: primaryColor, width: 2),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            // Password Input
            SizedBox(
              height: 55, // Adjust the height as needed
              child: TextFormField(
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  labelStyle:
                      GoogleFonts.poppins(fontSize: 14, color: primaryColor),
                  hintStyle: GoogleFonts.poppins(
                      fontSize: 14, color: Color(0xFFBABABA)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: primaryColor, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: primaryColor, width: 2),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            // Confirm Password Input
            SizedBox(
              height: 55, // Adjust the height as needed
              child: TextFormField(
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Confirm Password",
                  labelStyle:
                      GoogleFonts.poppins(fontSize: 14, color: primaryColor),
                  hintStyle: GoogleFonts.poppins(
                      fontSize: 14, color: Color(0xFFBABABA)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: primaryColor, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: primaryColor, width: 2),
                  ),
                ),
              ),
            ),

            // Terms and Conditions
            Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.zero,
                  child: Checkbox(
                    value: _termsAccepted,
                    onChanged: (value) {
                      setState(() {
                        _termsAccepted = value!;
                      });
                      // Handle checkbox logic
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    activeColor:
                        primaryColor, // Set the active color to primaryColor
                  ),
                ),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "I agree to the ",
                          style: GoogleFonts.poppins(color: Colors.black54),
                        ),
                        TextSpan(
                          text: "Terms and Conditions",
                          style: GoogleFonts.poppins(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationThickness:
                                0.7, // Adjust thickness as needed
                            decorationStyle: TextDecorationStyle.solid,
                            decorationColor: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            // Signup Button
            ElevatedButton(
              onPressed: _isLoading ? null : _register,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor, // Dark green color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
                minimumSize: Size(MediaQuery.of(context).size.width * 0.9,
                    50), // Set width to 80% of screen width
              ),
              child: const Text(
                "SignUp",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

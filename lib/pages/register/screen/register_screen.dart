import 'package:flutter/material.dart';
import 'package:only_shef/pages/login/screen/login_screen.dart';
import 'package:only_shef/services/api_service.dart';
import 'package:only_shef/utils/snack_bar_util.dart';

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

  final ApiService _apiService = ApiService();

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

    // Call the API to register the user
    final response = await _apiService.registerUser(
      _usernameController.text,
      _emailController.text,
      _passwordController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      if (response != null && response.statusCode == 200) {
        // _showSuccess("Registration successful.");
        showSuccess(context, "Registration successful.");
        // Navigate to the Login screen if still mounted
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } else {
        showError(context, "Registration failed. Please try again.");
        // _showError("Registration failed. Please try again.");
      }
    }
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
      backgroundColor: const Color(0xFFFEF8F4), // Light background color
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 60),
            // Logo Section
            Column(
              children: [
                Image.asset(
                  'assets/logo.png', // Replace with your logo image path
                  height: 200,
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Title
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Let’s Get Started",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            const SizedBox(height: 5),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Create your own account",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Name Input
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: "eg. Junaid Rafiq",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black26),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Email Input
            TextFormField(
              controller: _emailController,
              // initialValue: "creativejunaid007@gmail.com",
              decoration: InputDecoration(
                hintText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black26),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Password Input
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black26),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Confirm Password Input
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Confirm Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black26),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Terms and Conditions
            Row(
              children: [
                Checkbox(
                  value: _termsAccepted,
                  onChanged: (value) {
                    setState(() {
                      _termsAccepted = value!;
                    });
                    // Handle checkbox logic
                  },
                ),
                const Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "I agree to the ",
                          style: TextStyle(color: Colors.black54),
                        ),
                        TextSpan(
                          text: "Terms and Conditions",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            // Signup Button
            ElevatedButton(
              onPressed: _isLoading ? null : _register,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50), // Dark green color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 120),
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

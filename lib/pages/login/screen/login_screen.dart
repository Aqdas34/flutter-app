import 'package:flutter/material.dart';
import 'package:only_shef/pages/home/screen/home_screen.dart';
import 'package:only_shef/services/api_service.dart';
import 'package:only_shef/widgets/snack_bar_util.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _login() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      showError(context, "All fields are required.");
      return;
    }

    ApiService _apiService = ApiService();
    
    final response = await _apiService.loginUser(
      _emailController.text,
      _passwordController.text,
    );
    if (mounted) {
      if (response != null && response.statusCode == 200) {
        // _showSuccess("Registration successful.");
        showSuccess(context, "Login successful.");
        // Navigate to the Login screen if still mounted
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        showError(context, "Login Failed.");
        // _showError("Registration failed. Please try again.");
      }
    }



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEF8F4), // Light background color
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image of the chef cooking
              Image.asset(
                'assets/login_image.png', // Replace with your cooking image
                height: 250,
              ),
              const SizedBox(height: 30),
              // Email Input Field
              TextFormField(
                controller: _emailController,
                // initialValue: 'creativejunaid007@gmail.com',
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black26),
                  ),
                  prefixIcon: const Icon(Icons.email, color: Colors.black45),
                ),
              ),
              const SizedBox(height: 20),
              // Password Input Field
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black26),
                  ),
                  prefixIcon: const Icon(Icons.lock, color: Colors.black45),
                ),
              ),
              const SizedBox(height: 10),
              // Forget Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Forget password?",
                    style: TextStyle(color: Colors.black45),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Login Button
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50), // Dark green color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 120),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),
              // Signup Section
              Row(
                
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(color: Colors.black45),
                  ),
                  GestureDetector(
                    onTap: (){},
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

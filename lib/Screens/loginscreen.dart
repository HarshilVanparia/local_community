import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:local_community/Names/imagenames.dart';
import 'package:local_community/Names/stringnames.dart';
import 'package:local_community/Screens/homescreen.dart';
import 'package:local_community/Screens/registerscreen.dart';
import 'package:local_community/Screens/widgetsscreen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscured = true;
  // Tracks the visibility state of the password
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // checking if user already logged in or not
  void _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  Future<void> _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      var response = await http.post(
        Uri.parse('http://192.168.171.196:3000/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'upassword': password}),
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);

        if (responseData.containsKey('uname') &&
            responseData.containsKey('email') &&
            responseData.containsKey('address') &&
            responseData.containsKey('photo_path')) {
          String uname = responseData['uname'];
          String email = responseData['email'];
          String address = responseData['address'];
          String photoPath = responseData['photo_path'];

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('uname', uname);
          await prefs.setString('email', email);
          await prefs.setString('address', address);
          await prefs.setString('photo_path', photoPath);
          await prefs.setBool('isLoggedIn', true);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Login successful'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );

          Future.delayed(Duration(seconds: 2), () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Unexpected response format. Please try again.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed. Please check your credentials.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error occurred during login. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                // Center the main content
                child: Container(
                  margin: EdgeInsets.symmetric(
                      vertical: 75, horizontal: 35), // left and right margin
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        wing,
                        width: 150,
                        height: 150,
                        alignment: Alignment.center,
                      ),
                      SizedBox(height: 10), // Space between image and text
                      Text(
                        "Welcome! To",
                        style: TextStyle(
                          fontSize: 32,
                          color: AppColors.txtColor,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        AppTitles.appTitle,
                        style: TextStyle(
                          fontSize: 32,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                          height: 18), // Space before the first input field
                      CustomTextField(
                        controller: _emailController,
                        hintText: "Email",
                        borderColor: AppColors.txtColor,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) =>
                            value!.isEmpty ? "Please enter your email" : null,
                      ),
                      SizedBox(height: 18), // Space between input fields
                      CustomTextField(
                        controller: _passwordController,
                        hintText: "Password",
                        borderColor: AppColors.txtColor,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _isObscured,
                        suffixIcon: _isObscured
                            ? Icons.visibility_off
                            : Icons.visibility, // Change icon based on state
                        onSuffixIconPressed: () {
                          setState(() {
                            _isObscured =
                                !_isObscured; // Toggle the visibility state
                          });
                        },
                        validator: (value) => value!.isEmpty
                            ? "Please enter your password"
                            : null,
                      ),
                      SizedBox(height: 22), // Space before the submit button
                      ElevatedButton(
                        onPressed: _login,
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: AppColors.backgroundColor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.primaryColor),
                          minimumSize: MaterialStateProperty.all(Size(450, 55)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 75,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20), // Add some vertical padding
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don’t have an account?",
                      style: TextStyle(fontSize: 18, color: AppColors.txtColor),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

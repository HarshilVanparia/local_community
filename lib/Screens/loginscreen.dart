import 'package:flutter/material.dart';
import 'package:local_community/Module/loginrequestdata.dart';
import 'package:local_community/Names/imagenames.dart';
import 'package:local_community/Names/stringnames.dart';
import 'package:local_community/Screens/registerscreen.dart';
import 'package:local_community/Screens/widgetsscreen.dart';

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
                        onPressed: () {
                          LoginRequest loginRequest = LoginRequest(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                        },
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

import 'package:flutter/material.dart';
import 'package:local_community/Names/imagenames.dart';
import 'package:local_community/Names/stringnames.dart';
import 'package:local_community/Screens/homescreen.dart';
import 'package:local_community/Screens/registerscreen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                // Center the main content
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: 35), // left and right margin
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        wing,
                        width: 175,
                        height: 175,
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
                      TextField(
                        style: TextStyle(color: AppColors.txtColor),
                        decoration: InputDecoration(
                          hintText: "Email",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(70),
                            borderSide: BorderSide(color: AppColors.txtColor),
                          ),
                          hintStyle: TextStyle(color: AppColors.txtColor),
                          contentPadding: EdgeInsets.symmetric(horizontal: 14),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 18), // Space between input fields
                      TextField(
                        style: TextStyle(color: AppColors.txtColor),
                        decoration: InputDecoration(
                          hintText: "Password",
                          suffixIcon: Icon(
                            Icons.visibility_off,
                            color: AppColors.txtColor,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(70),
                            borderSide: BorderSide(color: AppColors.txtColor),
                          ),
                          hintStyle: TextStyle(color: AppColors.txtColor),
                          contentPadding: EdgeInsets.symmetric(horizontal: 14),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true, // Hide the password text
                      ),
                      SizedBox(height: 22), // Space before the submit button
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to the home screen
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

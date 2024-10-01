import 'package:flutter/material.dart';
import 'package:local_community/Names/imagenames.dart';
import 'package:local_community/Names/stringnames.dart';
import 'package:local_community/Screens/loginscreen.dart';
import 'package:local_community/Screens/registerscreen.dart';

class LetsGetStartedScreen extends StatefulWidget {
  const LetsGetStartedScreen({super.key});

  @override
  State<LetsGetStartedScreen> createState() => _LetsGetStartedScreenState();
}

class _LetsGetStartedScreenState extends State<LetsGetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Center(
                // This will center the logo and text vertically
                child: Column(
                  mainAxisSize:
                      MainAxisSize.min, // Shrinks the column to fit content
                  children: [
                    Image.asset(
                      wing, // Image asset
                      width: 150,
                      height: 150,
                      alignment: Alignment.center,
                    ),
                    SizedBox(height: 4), // Space between image and text
                    Text(
                      AppTitles.appTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.txtColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterScreen(),
                      ));
                },
                child: Text(
                  "Let's Get Started",
                  style: TextStyle(
                    fontSize: 24,
                    color: AppColors.backgroundColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15), // Button padding
                  shape: RoundedRectangleBorder(
                    // Rounded button shape
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10), // Space between button and text link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Have an account?",
                  style: TextStyle(
                    color: AppColors.txtColor,
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ));
                  },
                  child: Text(
                    "Log in",
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20), // Add bottom padding
          ],
        ),
      ),
    );
  }
}

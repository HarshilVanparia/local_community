import 'package:flutter/material.dart';
import 'package:local_community/Names/imagenames.dart';
import 'package:local_community/Names/stringnames.dart';
import 'package:local_community/Screens/getstartedscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _textVisible = false; // to control when text appears

  @override
  void initState() {
    super.initState();
    // Set up the animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    // Define animation (Tween from smaller size to larger size)
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    // Start the animation and show the text after the animation completes
    _controller.forward().then((_) {
      setState(() {
        _textVisible = true;
      });
    });

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              LetsGetStartedScreen(), // Navigate to HomePage after 2 seconds
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor, // App background color
      body: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // The animated logo moves from the top to the center
                Transform.translate(
                  offset: Offset(0,
                      -300 * (1 - _animation.value)), // Move from top to center
                  child: SizedBox(
                    height: 220, // logo size
                    width: 220,
                    child: Image.asset(logo), // logo asset
                  ),
                ),
                SizedBox(height: 5), // Space between logo and text
                AnimatedOpacity(
                  opacity: _textVisible ? 1.0 : 0.0,
                  duration: const Duration(seconds: 1),
                  child: Text(
                    'Welcome To \n Local Community',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.txtColor,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

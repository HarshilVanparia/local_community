import 'dart:math';

import 'package:flutter/material.dart';
import 'package:local_community/Names/imagenames.dart';
import 'package:local_community/Screens/homescreen.dart';
import 'package:local_community/Screens/loginscreen.dart';

class Bottomnav extends StatefulWidget {
  const Bottomnav({super.key});

  @override
  State<Bottomnav> createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isMenuOpen = false;
  final List<Map<String, String>> items = [
    {'title': 'Electronics', 'icon': category1},
    {'title': 'IOT', 'icon': category2},
    {'title': 'Circuit', 'icon': category3},
  ];
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  void toggleMenu() {
    if (mounted) {
      setState(() {
        isMenuOpen = !isMenuOpen;
        isMenuOpen ? _controller.forward() : _controller.reverse();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Future_Product_title(),
                  SizedBox(height: 8),
                  Products(),
                  SizedBox(height: 8),
                  Categories_Title(),
                  Categories_List(items: items),
                  SizedBox(height: 8),
                  Community_Posts_Title(),
                  SizedBox(height: 8),
                  Community_Post(),
                  SizedBox(height: 18),
                ],
              ),
            ),
            // Buttons positioned in a half-circle
            if (isMenuOpen)
              Positioned.fill(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    for (var i = 0; i < 6; i++) _buildCircularMenuButton(i),
                  ],
                ),
              ),
            // Central Floating Action Button to Toggle Menu
            Positioned(
              bottom: 20, // Centralize at the bottom
              left: MediaQuery.of(context).size.width / 2 - 30,
              child: FloatingActionButton(
                onPressed: toggleMenu,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    isMenuOpen ? Icons.close : Icons.menu,
                    size: 28,
                    key: ValueKey<bool>(isMenuOpen),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to create circular menu buttons in a semi-circle
  Widget _buildCircularMenuButton(int index) {
    // Number of buttons in the half-circle
    final numberOfButtons = 6;
    final double radius = 120; // Radius of the half-circle

    // Calculate the angle in radians
    double angle = pi / (numberOfButtons - 1) * index;

    // Calculate the x and y positions using trigonometry
    double x = cos(angle) * radius;
    double y = sin(angle) * radius;

    // Positioned widget to place each button
    return Positioned(
      bottom: 80 + y,
      left: MediaQuery.of(context).size.width / 2 - 30 + x,
      child: CircularMenuButton(
        icon: _getIconForButton(index),
        onPressed: () {
          if (mounted) {
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            } else if (index == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            } else if (index == 4) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            } else if (index == 5) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            }
          }
        },
      ),
    );
  }

  // Define icons for each button
  IconData _getIconForButton(int index) {
    switch (index) {
      case 0:
        return Icons.build;
      case 1:
        return Icons.dashboard;
      case 2:
        return Icons.gamepad;
      case 3:
        return Icons.settings;
      case 4:
        return Icons.home;
      case 5:
        return Icons.person;
      default:
        return Icons.home;
    }
  }
}

class CircularMenuButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  CircularMenuButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: Icon(icon),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:local_community/Names/imagenames.dart';
import 'package:local_community/Names/stringnames.dart';
import 'package:local_community/Screens/homescreen.dart';
import 'package:local_community/Screens/loginscreen.dart';

class Categoriesscreen extends StatefulWidget {
  final String categoryTitle;
  final String iconPath;
  const Categoriesscreen({
    Key? key,
    required this.categoryTitle,
    required this.iconPath,
  }) : super(key: key);

  @override
  State<Categoriesscreen> createState() => _CategoriesscreenState();
}

class _CategoriesscreenState extends State<Categoriesscreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isMenuOpen = false;

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

  final List<Map<String, String>> items = [
    {'title': 'Electronics', 'icon': category1},
    {'title': 'IOT', 'icon': category2},
    {'title': 'Circuit', 'icon': category3},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: EdgeInsets.fromLTRB(35, 8, 35, 8),
          child: Row(
            children: [
              Image.asset(
                logo,
                width: 50,
                height: 50,
              ),
              SizedBox(width: 8),
              Text(
                AppTitles.appTitle,
                style: TextStyle(color: AppColors.txtColor),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // Scrollable content
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 8),
                  Categories_Title(),
                  Categories_List(items: items),
                  SizedBox(height: 8),
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

class Categories_List extends StatelessWidget {
  const Categories_List({
    super.key,
    required this.items,
  });

  final List<Map<String, String>> items;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: CircleAvatar(
                        radius: 30, // radius as required
                        backgroundColor: AppColors.primaryColor,
                        child: ClipOval(
                          child: Image.asset(
                            iot,
                            fit: BoxFit.cover,
                            width: 38, 
                            height: 38,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ));
  }
}

class Categories_Title extends StatelessWidget {
  const Categories_Title({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Categories Title start
      margin: EdgeInsets.symmetric(horizontal: 35.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Categories",
            style: TextStyle(
                color: AppColors.txtColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

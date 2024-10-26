import 'package:flutter/material.dart';
import 'package:local_community/Names/imagenames.dart';
import 'package:local_community/Names/stringnames.dart';
import 'package:local_community/Screens/allproductsscreen.dart';

import 'package:local_community/Screens/categoriesscreen.dart';
import 'package:local_community/Screens/communitypostscreen.dart';

import 'package:local_community/Screens/widgetsscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomSscreenState();
}

class _HomSscreenState extends State<HomeScreen> {
  // categories details
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
          margin: EdgeInsets.symmetric(vertical: 8.0),
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
                  // Future Products Section
                  _buildSectionHeader('Future Products', onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AllProductsScreen()));
                  }),
                  SizedBox(height: 8),
                  Products(),
                  SizedBox(height: 8),

                  // Categories Section
                  _buildSectionHeader('Categories', onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Categoriesscreen()));
                  }),
                  SizedBox(height: 8),
                  Categories_List(items: items),
                  SizedBox(height: 8),

                  // Community Posts Section
                  _buildSectionHeader('Community Posts', onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CommunityPostScreen()));
                  }),
                  SizedBox(height: 8),
                  // Community Posts Details
                  Community_Posts(
                    userName: postTitle.puser,
                    userAvatar: user,
                    postImage: post,
                    postContent: postTitle.postContent,
                    tags: [
                      {"text": "#ESP32"},
                      {"text": "#Iot"},
                      {"text": "#Circuit"},
                      {"text": "#Android"},
                      {"text": "#AndroidStudio"},
                      {"text": "#ESP32Module"},
                    ],
                    commentContent: postTitle.postcomments,
                  ),
                  SizedBox(height: 120),
                ],
              ),
            ),
            // BottomNavigation
            FloatingCircularMenu()
          ],
        ),
      ),
    );
  }
}

// Section Header Widget with Explore Button
Widget _buildSectionHeader(String title, {required Function() onTap}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ElevatedButton.icon(
          onPressed: onTap,
          label: Text(
            AppTitles.explore,
            style: TextStyle(color: AppColors.backgroundColor),
            textAlign: TextAlign.center,
          ),
          icon: Icon(
            Icons.arrow_forward_ios,
            color: AppColors.backgroundColor,
            size: 12,
          ),
          iconAlignment: IconAlignment.end,
          style: ElevatedButton.styleFrom(
            backgroundColor: (AppColors.primaryColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            elevation: 5,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          ),
        ),
      ],
    ),
  );
}

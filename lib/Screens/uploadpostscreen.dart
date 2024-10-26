import 'package:flutter/material.dart';
import 'package:local_community/Names/imagenames.dart';
import 'package:local_community/Names/stringnames.dart';
import 'package:local_community/Screens/communitypostscreen.dart';
import 'package:local_community/Screens/widgetsscreen.dart';

class UploadPostScreen extends StatefulWidget {
  const UploadPostScreen({super.key});

  @override
  State<UploadPostScreen> createState() => _UploadPostScreenState();
}

class _UploadPostScreenState extends State<UploadPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: EdgeInsets.fromLTRB(5, 8, 5, 8),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CommunityPostScreen()));
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: AppColors.txtColor,
                ),
              ),
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
                  SizedBox(height: 8),
                  UploadPost(),
                  SizedBox(height: 18),
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

class UploadPost extends StatefulWidget {
  const UploadPost({super.key});

  @override
  State<UploadPost> createState() => _UploadPostState();
}

class _UploadPostState extends State<UploadPost> {
  // List of items in the dropdown
  final List<String> items = ['Iot', '3D Printing', 'Circuit', 'Art'];

  // Variable to hold the selected value
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 32,
          ),
          Text(
            "Upload Post",
            style: TextStyle(
                color: AppColors.txtColor,
                fontSize: 24,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: AppColors.txtColor),
                color: AppColors.txtColor,
                borderRadius: BorderRadius.circular(6)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  postTitle.ptitle,
                  style: TextStyle(
                      color: AppColors.backgroundColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2, color: AppColors.backgroundColor),
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.circular(6)),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter ' + postTitle.ptitle,
                      hintStyle: TextStyle(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  postTitle.ptag,
                  style: TextStyle(
                      color: AppColors.backgroundColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2, color: AppColors.backgroundColor),
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.circular(6)),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter ' + postTitle.ptitle,
                      hintStyle: TextStyle(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  postTitle.pdescript,
                  style: TextStyle(
                      color: AppColors.backgroundColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2, color: AppColors.backgroundColor),
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.circular(6)),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter ' + postTitle.pdescript,
                      hintStyle: TextStyle(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  postTitle.pdescript,
                  style: TextStyle(
                      color: AppColors.backgroundColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 50, horizontal: 68),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2, color: AppColors.backgroundColor),
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.circular(6)),
                  child: Text(
                    "Choose " + postTitle.pdescript,
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 18,
          ),
          SizedBox(
            height: 18,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CommunityPostScreen()));
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "UPLOAD",
                  style: TextStyle(
                      color: AppColors.backgroundColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}

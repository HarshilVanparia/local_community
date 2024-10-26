import 'package:flutter/material.dart';
import 'package:local_community/Names/imagenames.dart';
import 'package:local_community/Names/stringnames.dart';
import 'package:local_community/Screens/uploadpostscreen.dart';
import 'package:local_community/Screens/widgetsscreen.dart';

class CommunityPostScreen extends StatefulWidget {
  const CommunityPostScreen({super.key});

  @override
  State<CommunityPostScreen> createState() => _CommunityPostScreenState();
}

class _CommunityPostScreenState extends State<CommunityPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: EdgeInsets.fromLTRB(5, 8, 5, 8),
          child: Row(
            children: [
              // IconButton(
              //   onPressed: () {
              //     Navigator.pushReplacement(context,
              //         MaterialPageRoute(builder: (context) => HomeScreen()));
              //   },
              //   icon: Icon(
              //     Icons.arrow_back,
              //     color: AppColors.txtColor,
              //   ),
              // ),
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
                  Community_Posts_Title(),
                  SizedBox(height: 8),
                  // Community_Posts_1
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
                  SizedBox(height: 20),
                  // Community_Posts_2
                  Community_Posts(
                    userName: postTitle.puser,
                    userAvatar: user,
                    postImage: post2,
                    postContent:
                        "When i’m building apk it keep showing error that my minSdkVersion : 19 cannot be smaller than version if i update to 16 still giving me error.",
                    tags: [
                      {"text": "#minSdkVersion"},
                      {"text": "#JAVA"},
                      {"text": "#SDK"},
                      {"text": "#Version"},
                      {"text": "#AndroidStudio"},
                      {"text": "#minSDKversion16"},
                    ],
                    commentContent: postTitle.postcomments,
                  ),
                  SizedBox(height: 16),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 14),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UploadPostScreen(),
                            ));
                      },
                      child: Text(
                        "UPLOAD YOUR POST",
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColors.backgroundColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        minimumSize: Size(double.infinity, 20),
                        // Button padding
                        shape: RoundedRectangleBorder(
                          // Rounded button shape
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 120,
                  ),
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

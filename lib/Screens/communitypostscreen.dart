import 'package:flutter/material.dart';
import 'package:local_community/Names/imagenames.dart';
import 'package:local_community/Names/stringnames.dart';
import 'package:local_community/Screens/allproductsscreen.dart';
import 'package:local_community/Screens/categoriesscreen.dart';
import 'package:local_community/Screens/homescreen.dart';
import 'package:local_community/Screens/profilescreen.dart';
import 'package:local_community/Screens/uploadpostscreen.dart';

class CommunityPostScreen extends StatefulWidget {
  const CommunityPostScreen({super.key});

  @override
  State<CommunityPostScreen> createState() => _CommunityPostScreenState();
}

class _CommunityPostScreenState extends State<CommunityPostScreen>
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
                  Post1(),
                  SizedBox(height: 8),
                  Post2(),
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
                    height: 150,
                  ),
                ],
              ),
            ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // Buttons positioned in a half-circle
                Positioned(
                  left: MediaQuery.of(context).size.width / 2 - 120,
                  bottom: 150,
                  child: Visibility(
                    visible: isMenuOpen,
                    child: CircularMenuButton(
                      icon: Icons.category,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Categoriesscreen()),
                        );
                      },
                    ),
                  ),
                ),
                // Button 2 (top right of the main button)
                Positioned(
                  left: MediaQuery.of(context).size.width / 2 + 60,
                  bottom: 150,
                  child: Visibility(
                    visible: isMenuOpen,
                    child: CircularMenuButton(
                      icon: Icons.propane_rounded,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllProductsScreen()),
                        );
                      },
                    ),
                  ),
                ),
                // Button 3 (middle left of the main button)
                Positioned(
                  left: MediaQuery.of(context).size.width / 2 - 160,
                  bottom: 80,
                  child: Visibility(
                    visible: isMenuOpen,
                    child: CircularMenuButton(
                      icon: Icons.person,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileScreen()),
                        );
                      },
                    ),
                  ),
                ),
                // Button 4 (middle right of the main button)
                Positioned(
                  left: MediaQuery.of(context).size.width / 2 + 100,
                  bottom: 80,
                  child: Visibility(
                    visible: isMenuOpen,
                    child: CircularMenuButton(
                      icon: Icons.post_add,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CommunityPostScreen()),
                        );
                      },
                    ),
                  ),
                ),
                // Button 5 (directly above the main button)
                Positioned(
                  left: MediaQuery.of(context).size.width / 2 - 30,
                  bottom: 160,
                  child: Visibility(
                    visible: isMenuOpen,
                    child: CircularMenuButton(
                      icon: Icons.home,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      },
                    ),
                  ),
                ),
                // Main Bottom-Center Button
                Positioned(
                  bottom: 40, // Adjust for positioning
                  child: FloatingActionButton(
                    onPressed: toggleMenu,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Icon(
                        isMenuOpen ? Icons.close : Icons.home,
                        size: 28,
                        key: ValueKey<bool>(isMenuOpen),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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

class Post1 extends StatelessWidget {
  const Post1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Community Post Start
      margin: EdgeInsets.symmetric(horizontal: 22.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.all(
            color: AppColors.txtColor, width: 1, style: BorderStyle.solid),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                SizedBox(
                    width: 32,
                    height: 32,
                    child: CircleAvatar(backgroundImage: AssetImage(user))),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "kachra seth",
                  style: TextStyle(
                    color: AppColors.txtColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: AppColors.txtColor,
            height: 350,
            child: Image.asset(
              width: double.infinity,
              height: 250,
              post,
              fit: BoxFit.contain,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "I’m facing problem when ever click on button then it should on LED light of ESP32 with Bluetooth but its not working if anyone have solution please comment down. appreciate any help thanks in advance.",
                  style: TextStyle(color: AppColors.txtColor),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 2, color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(6),
                        color: AppColors.primaryColor,
                      ),
                      child: Text(
                        "#Iot",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, wordSpacing: 1),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 2, color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(6),
                        color: AppColors.primaryColor,
                      ),
                      child: Text(
                        "#Circuit",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, wordSpacing: 1),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 2, color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(6),
                        color: AppColors.primaryColor,
                      ),
                      child: Text(
                        "#ESP32",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, wordSpacing: 1),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4)),
                      hintText: AppTitles.comment,
                      hintStyle: TextStyle(
                          color: AppColors.graybox,
                          fontWeight: FontWeight.bold)),
                  style: TextStyle(color: AppColors.graybox),
                ),
              ),
              Container(
                height: 150,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                color: AppColors.commentbox,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(
                    "Step:1 Try running the flutter build web command in your project and inspect the build folder. Assuming a pubspec.yaml with following asset configurations.\nStep: 2 Ensure the files as shown above are available in your server where this folder is hosted. Also verify if the server has any configurations to be made specifically for image files or types of images files.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: 16,
                        wordSpacing: 1,
                        color: AppColors.txtColor),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Post2 extends StatelessWidget {
  const Post2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Community Post Start
      margin: EdgeInsets.symmetric(horizontal: 22.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.all(
            color: AppColors.txtColor, width: 1, style: BorderStyle.solid),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                SizedBox(
                    width: 32,
                    height: 32,
                    child: CircleAvatar(backgroundImage: AssetImage(user))),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "nanubhai",
                  style: TextStyle(
                    color: AppColors.txtColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: AppColors.txtColor,
            height: 350,
            child: Image.asset(
              width: double.infinity,
              height: 250,
              post2,
              fit: BoxFit.fill,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "When i’m building apk it keep showing error that my minSdkVersion : 19 cannot be smaller than version if i update to 16 still giving me error.",
                  style: TextStyle(color: AppColors.txtColor),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 2, color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(6),
                        color: AppColors.primaryColor,
                      ),
                      child: Text(
                        "#Java",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, wordSpacing: 1),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 2, color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(6),
                        color: AppColors.primaryColor,
                      ),
                      child: Text(
                        "#minSdkVersion",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, wordSpacing: 1),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 2, color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(6),
                        color: AppColors.primaryColor,
                      ),
                      child: Text(
                        "#Android",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, wordSpacing: 1),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4)),
                      hintText: AppTitles.comment,
                      hintStyle: TextStyle(
                          color: AppColors.graybox,
                          fontWeight: FontWeight.bold)),
                  style: TextStyle(color: AppColors.graybox),
                ),
              ),
              Container(
                height: 150,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                color: AppColors.commentbox,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(
                    "The error indicates that the library androidx.core:core:1.13.0 requires a minimum SDK version of 19, but your project is currently set to a minimum SDK version of 16. You have a few options to resolve this: Open your build.gradle file android {...defaultConfig {...minSdkVersion 19...}...}",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: 16,
                        wordSpacing: 1,
                        color: AppColors.txtColor),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Community_Posts_Title extends StatelessWidget {
  const Community_Posts_Title({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Community Posts Title start
      margin: EdgeInsets.symmetric(horizontal: 22.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Community Posts",
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

import 'package:flutter/material.dart';
import 'package:local_community/Names/imagenames.dart';
import 'package:local_community/Names/stringnames.dart';
import 'package:local_community/Screens/allproductsscreen.dart';
import 'package:local_community/Screens/categoriesscreen.dart';
import 'package:local_community/Screens/communitypostscreen.dart';
import 'package:local_community/Screens/homescreen.dart';
import 'package:local_community/Screens/profilescreen.dart';

class UploadPostScreen extends StatefulWidget {
  const UploadPostScreen({super.key});

  @override
  State<UploadPostScreen> createState() => _UploadPostScreenState();
}

class _UploadPostScreenState extends State<UploadPostScreen>
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
          margin: EdgeInsets.fromLTRB(35, 8, 35, 8),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
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
            height: 10,
          ),
        ],
      ),
    );
  }
}

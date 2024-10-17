import 'package:flutter/material.dart';
import 'package:local_community/Names/imagenames.dart';
import 'package:local_community/Names/stringnames.dart';
import 'package:local_community/Screens/allproductsscreen.dart';
import 'package:local_community/Screens/categoriesscreen.dart';
import 'package:local_community/Screens/communitypostscreen.dart';
import 'package:local_community/Screens/homescreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
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
              IconButton(
                onPressed: () {
                  // Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => AllProductsScreen()));
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
                  Profile(),
                  SizedBox(height: 16),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 100,
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

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: 125,
                  height: 125,
                  child: CircleAvatar(backgroundImage: AssetImage(goku))),
              SizedBox(
                height: 12,
              ),
              Text(
                "Sun Goku",
                style: TextStyle(
                    color: AppColors.txtColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              Prosonal(),
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
                      "Email",
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
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 2, color: AppColors.backgroundColor),
                          color: AppColors.backgroundColor,
                          borderRadius: BorderRadius.circular(6)),
                      child: Text(
                        "hvanpariya647@rku.ac.in",
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
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Address",
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
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 2, color: AppColors.backgroundColor),
                          color: AppColors.backgroundColor,
                          borderRadius: BorderRadius.circular(6)),
                      child: Text(
                        "Rajkot 360004.",
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
            ],
          ),
          SizedBox(
            height: 16,
          ),
          MyProduct(),
          SizedBox(
            height: 16,
          ),
          FutureProducts(),
          SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: () {
              // Navigator.pushReplacement(context,
              //     MaterialPageRoute(builder: (context) => AllProductsScreen()));
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

class Prosonal extends StatelessWidget {
  const Prosonal({
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
            "Personal Details",
            style: TextStyle(
                color: AppColors.txtColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CommunityPostScreen()));
            },
            label: Text(
              "Edit",
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
}

class FutureProducts extends StatelessWidget {
  const FutureProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Product Start
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        shrinkWrap:
            true, // Important to ensure GridView takes only required height
        crossAxisCount: 2, // Two items per row
        crossAxisSpacing: 8, // Horizontal spacing between cards
        mainAxisSpacing: 10, // Vertical spacing between cards
        childAspectRatio: 0.51, // Controls height/width ratio to match design
        physics: NeverScrollableScrollPhysics(),
        children: [
          ProductCard(
            title: 'M1',
            price: '₹290',
            imageUrl: product1,
          ),
          ProductCard(
            title: 'White Temple',
            price: '₹89',
            imageUrl: product2,
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;

  ProductCard(
      {required this.title, required this.price, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: 12, vertical: 8), // Margin between cards
      decoration: BoxDecoration(
        color: AppColors.backgroundColor, // Background color of the card
        borderRadius: BorderRadius.circular(8), // Rounded corners
        border: Border.all(color: AppColors.primaryColor, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // To make button stick at bottom
        children: [
          // Image with rounded corners
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(6),
              topRight: Radius.circular(6),
            ),
            child: Image.asset(
              imageUrl,
              height: 170, // Adjust the height to your liking
              fit: BoxFit.fill, // Ensures the image covers the available space
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 12.0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.txtColor,
                        ),
                      ),
                      SizedBox(height: 8), // Space between title and price
                      Text(
                        price,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.txtColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 35,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ProductDetailsScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          AppColors.dangerColor, // Color of the button
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(6),
                              bottomRight: Radius.circular(6))),
                      padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                      elevation: 2, // Slight elevation for the button
                    ),
                    child: Icon(
                      Icons.delete,
                      color: AppColors.txtColor,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyProduct extends StatelessWidget {
  const MyProduct({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //Future Product title Start
      margin: EdgeInsets.symmetric(horizontal: 22.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "My Products",
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

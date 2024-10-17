import 'package:flutter/material.dart';
import 'package:local_community/Names/imagenames.dart';
import 'package:local_community/Names/stringnames.dart';
import 'package:local_community/Screens/allproductsscreen.dart';
import 'package:local_community/Screens/communitypostscreen.dart';
import 'package:local_community/Screens/homescreen.dart';
import 'package:local_community/Screens/productsscreen.dart';
import 'package:local_community/Screens/profilescreen.dart';

class Categoriesscreen extends StatefulWidget {
  const Categoriesscreen({super.key});

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
                  Categories_Items(),
                  SizedBox(height: 100),
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

class Categories_Items extends StatelessWidget {
  const Categories_Items({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductsScreen(),
                            ));
                      },
                      child: Container(
                        width: 152,
                        height: 152,
                        decoration: BoxDecoration(
                          border: Border.all(
                            style: BorderStyle.solid,
                            color: AppColors.primaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceEvenly, // for inside icon & text
                          children: [
                            CircleAvatar(
                              radius: 30, // radius as required
                              backgroundColor: AppColors.primaryColor,
                              child: Image.asset(
                                iot,
                                fit: BoxFit
                                    .cover, // Ensures the whole image is visible
                                width: 38, // Adjust based on the size you need
                                height: 38,
                              ),
                            ),
                            Text(
                              categoriesTitles.iot,
                              style: TextStyle(
                                color: AppColors.txtColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductsScreen(),
                            ));
                      },
                      child: Container(
                        width: 152,
                        height: 152,
                        decoration: BoxDecoration(
                          border: Border.all(
                            style: BorderStyle.solid,
                            color: AppColors.primaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              radius: 30, // radius as required
                              backgroundColor: AppColors.primaryColor,
                              child: Image.asset(
                                ele,
                                fit: BoxFit
                                    .cover, // Ensures the whole image is visible
                                width: 38, // Adjust based on the size you need
                                height: 38,
                              ),
                            ),
                            Text(
                              categoriesTitles.ele,
                              style: TextStyle(
                                color: AppColors.txtColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ), // row 1 end
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductsScreen(),
                            ));
                      },
                      child: Container(
                        width: 152,
                        height: 152,
                        decoration: BoxDecoration(
                          border: Border.all(
                            style: BorderStyle.solid,
                            color: AppColors.primaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceEvenly, // for inside icon & text
                          children: [
                            CircleAvatar(
                              radius: 30, // radius as required
                              backgroundColor: AppColors.primaryColor,
                              child: Image.asset(
                                circuit,
                                fit: BoxFit
                                    .cover, // Ensures the whole image is visible
                                width: 38, // Adjust based on the size you need
                                height: 38,
                              ),
                            ),
                            Text(
                              categoriesTitles.circuit,
                              style: TextStyle(
                                color: AppColors.txtColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductsScreen(),
                            ));
                      },
                      child: Container(
                        width: 152,
                        height: 152,
                        decoration: BoxDecoration(
                          border: Border.all(
                            style: BorderStyle.solid,
                            color: AppColors.primaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              radius: 30, // radius as required
                              backgroundColor: AppColors.primaryColor,
                              child: Image.asset(
                                printing,
                                fit: BoxFit
                                    .cover, // Ensures the whole image is visible
                                width: 38, // Adjust based on the size you need
                                height: 38,
                              ),
                            ),
                            Text(
                              categoriesTitles.printing,
                              style: TextStyle(
                                color: AppColors.txtColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ), // row 2 end
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductsScreen(),
                            ));
                      },
                      child: Container(
                        width: 152,
                        height: 152,
                        decoration: BoxDecoration(
                          border: Border.all(
                            style: BorderStyle.solid,
                            color: AppColors.primaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceEvenly, // for inside icon & text
                          children: [
                            CircleAvatar(
                              radius: 30, // radius as required
                              backgroundColor: AppColors.primaryColor,
                              child: Image.asset(
                                csdesign,
                                fit: BoxFit
                                    .cover, // Ensures the whole image is visible
                                width: 38, // Adjust based on the size you need
                                height: 38,
                              ),
                            ),
                            Text(
                              categoriesTitles.design,
                              style: TextStyle(
                                color: AppColors.txtColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductsScreen(),
                            ));
                      },
                      child: Container(
                        width: 152,
                        height: 152,
                        decoration: BoxDecoration(
                          border: Border.all(
                            style: BorderStyle.solid,
                            color: AppColors.primaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              radius: 30, // radius as required
                              backgroundColor: AppColors.primaryColor,
                              child: Image.asset(
                                art,
                                fit: BoxFit
                                    .cover, // Ensures the whole image is visible
                                width: 38, // Adjust based on the size you need
                                height: 38,
                              ),
                            ),
                            Text(
                              categoriesTitles.art,
                              style: TextStyle(
                                color: AppColors.txtColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ), // row 3 end
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductsScreen(),
                            ));
                      },
                      child: Container(
                        width: 152,
                        height: 152,
                        decoration: BoxDecoration(
                          border: Border.all(
                            style: BorderStyle.solid,
                            color: AppColors.primaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceEvenly, // for inside icon & text
                          children: [
                            CircleAvatar(
                              radius: 30, // radius as required
                              backgroundColor: AppColors.primaryColor,
                              child: Image.asset(
                                herb,
                                fit: BoxFit
                                    .cover, // Ensures the whole image is visible
                                width: 38, // Adjust based on the size you need
                                height: 38,
                              ),
                            ),
                            Text(
                              categoriesTitles.herbs,
                              style: TextStyle(
                                color: AppColors.txtColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductsScreen(),
                            ));
                      },
                      child: Container(
                        width: 152,
                        height: 152,
                        decoration: BoxDecoration(
                          border: Border.all(
                            style: BorderStyle.solid,
                            color: AppColors.primaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              radius: 30, // radius as required
                              backgroundColor: AppColors.primaryColor,
                              child: Image.asset(
                                strip,
                                fit: BoxFit
                                    .cover, // Ensures the whole image is visible
                                width: 38, // Adjust based on the size you need
                                height: 38,
                              ),
                            ),
                            Text(
                              categoriesTitles.led,
                              style: TextStyle(
                                color: AppColors.txtColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ), // row 4 end
                SizedBox(
                  height: 18,
                ),
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

import 'package:flutter/material.dart';
import 'package:local_community/Names/imagenames.dart';
import 'package:local_community/Names/stringnames.dart';
import 'package:local_community/Screens/productsscreen.dart';
import 'package:local_community/Screens/widgetsscreen.dart';

class Categoriesscreen extends StatefulWidget {
  const Categoriesscreen({super.key});

  @override
  State<Categoriesscreen> createState() => _CategoriesscreenState();
}

class _CategoriesscreenState extends State<Categoriesscreen> {
 
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 8),
                  // Categories_Title(),

                  // Categories Title Start
                  _buildSectionHeader('Categories'),
                  // Categories Title End

                  SizedBox(height: 8),

                  // Categories Section Start

                  // Row 1 Start
                  _buildCategoryCard(
                    imageAsset1: iot,
                    title1: categoriesTitles.iot,
                    onTap1: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductsScreen(),
                        ),
                      );
                    },
                    imageAsset2: ele,
                    title2: categoriesTitles.ele,
                    onTap2: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductsScreen(),
                        ),
                      );
                    },
                  ),
                  // Row 1 End

                  // Row 2 Start
                  _buildCategoryCard(
                    imageAsset1: circuit,
                    title1: categoriesTitles.circuit,
                    onTap1: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductsScreen(),
                        ),
                      );
                    },
                    imageAsset2: printing,
                    title2: categoriesTitles.printing,
                    onTap2: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductsScreen(),
                        ),
                      );
                    },
                  ),
                  // Row 2 End

                  // Row 3 Start
                  _buildCategoryCard(
                    imageAsset1: csdesign,
                    title1: categoriesTitles.design,
                    onTap1: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductsScreen(),
                        ),
                      );
                    },
                    imageAsset2: art,
                    title2: categoriesTitles.art,
                    onTap2: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductsScreen(),
                        ),
                      );
                    },
                  ),
                  // Row 3 End

                  // Row 4 Start
                  _buildCategoryCard(
                    imageAsset1: herb,
                    title1: categoriesTitles.herbs,
                    onTap1: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductsScreen(),
                        ),
                      );
                    },
                    imageAsset2: strip,
                    title2: categoriesTitles.led,
                    onTap2: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductsScreen(),
                        ),
                      );
                    },
                  ),
                  // Row 4 End

                  // Categories_Items(),
                  SizedBox(height: 100),
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

// Section Header for Categories
Widget _buildSectionHeader(String title) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 35.0, vertical: 8.0),
    child: Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
// Section Header for Categories end

// Section Categories Card
Widget _buildCategoryCard({
  required String imageAsset1,
  required String title1,
  required Function() onTap1,
  required String imageAsset2,
  required String title2,
  required Function() onTap2,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: onTap1,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(
                    style: BorderStyle.solid,
                    color: AppColors.primaryColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly, // for inside icon & text
                  children: [
                    CircleAvatar(
                      radius: 30, // radius as required
                      backgroundColor: AppColors.primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(
                          imageAsset1,
                          fit: BoxFit
                              .cover, // Ensures the whole image is visible
                          width: 50, // Adjust based on the size you need
                          height: 50,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text(
                        title1,
                        style: TextStyle(
                          color: AppColors.txtColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            TextButton(
              onPressed: onTap2,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(
                    style: BorderStyle.solid,
                    color: AppColors.primaryColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly, // for inside icon & text
                  children: [
                    CircleAvatar(
                      radius: 30, // radius as required
                      backgroundColor: AppColors.primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(
                          imageAsset2,
                          fit: BoxFit
                              .cover, // Ensures the whole image is visible
                          width: 50, // Adjust based on the size you need
                          height: 50,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text(
                        title2,
                        style: TextStyle(
                          color: AppColors.txtColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ), // row  end
        SizedBox(
          height: 20,
        ),
      ],
    ),
  );
}

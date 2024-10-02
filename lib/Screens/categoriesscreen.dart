import 'package:flutter/material.dart';
import 'package:local_community/Names/imagenames.dart';
import 'package:local_community/Names/stringnames.dart';
import 'package:local_community/Screens/productsscreen.dart';

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
                  Categories_Items(),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
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

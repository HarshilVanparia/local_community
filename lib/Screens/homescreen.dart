import 'package:flutter/material.dart';
import 'package:local_community/Names/imagenames.dart';
import 'package:local_community/Names/stringnames.dart';
import 'package:local_community/Screens/allproductsscreen.dart';

import 'package:local_community/Screens/categoriesscreen.dart';
import 'package:local_community/Screens/communitypostscreen.dart';

import 'package:local_community/Screens/productdetailsscreen.dart';
import 'package:local_community/Screens/productsscreen.dart';
import 'package:local_community/Screens/profilescreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomSscreenState();
}

class _HomSscreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  // categories details
  final List<Map<String, String>> items = [
    {'title': 'Electronics', 'icon': category1},
    {'title': 'IOT', 'icon': category2},
    {'title': 'Circuit', 'icon': category3},
  ];
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
                  // Future Products Section
                  _buildSectionHeader('Future Products', onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AllProductsScreen()));
                  }),
                  SizedBox(height: 8),
                  Products(),
                  SizedBox(height: 8),

                  // Categories Section
                  _buildSectionHeader('Categories', onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Categoriesscreen()));
                  }),
                  SizedBox(height: 8),
                  Categories_List(items: items),
                  SizedBox(height: 8),

                  // Community Post Section
                  _buildSectionHeader('Community Post', onTap: () {}),
                  SizedBox(height: 8),
                  // Community_Posts_Title(),
                  SizedBox(height: 8),
                  Community_Post(),
                  SizedBox(height: 100),
                ],
              ),
            ),
            // Buttons positioned in a half-circle

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

class Community_Post extends StatelessWidget {
  const Community_Post({
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

// class Community_Posts_Title extends StatelessWidget {
//   const Community_Posts_Title({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // Community Posts Title start
//       margin: EdgeInsets.symmetric(horizontal: 22.0, vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             "Community Posts",
//             style: TextStyle(
//                 color: AppColors.txtColor,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold),
//           ),
//           ElevatedButton.icon(
//             onPressed: () {
//               Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => CommunityPostScreen()));
//             },
//             label: Text(
//               AppTitles.explore,
//               style: TextStyle(color: AppColors.backgroundColor),
//               textAlign: TextAlign.center,
//             ),
//             icon: Icon(
//               Icons.arrow_forward_ios,
//               color: AppColors.backgroundColor,
//               size: 12,
//             ),
//             iconAlignment: IconAlignment.end,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: (AppColors.primaryColor),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(4),
//               ),
//               elevation: 5,
//               padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class Categories_List extends StatelessWidget {
  const Categories_List({
    super.key,
    required this.items,
  });

  final List<Map<String, String>> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true, // Important for proper height
        physics:
            NeverScrollableScrollPhysics(), // Prevent scrolling inside scrollable parent
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            minVerticalPadding: 24,
            leading: CircleAvatar(
              radius: 30, // radius as required
              backgroundColor: AppColors.primaryColor,
              child: ClipOval(
                child: Image.asset(
                  items[index]['icon']!, // Custom icon from the list
                  fit: BoxFit.cover, // Ensures the whole image is visible
                  width: 38, // Adjust based on the size you need
                  height: 38,
                ),
              ),
            ),
            title: Text(
              items[index]['title']!, // Title of item
              style: TextStyle(fontSize: 18, color: AppColors.txtColor),
            ),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductsScreen(),
                  ));
            },
          );
        },
      ),
    );
  }
}

// class Categories_Title extends StatelessWidget {
//   const Categories_Title({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // Categories Title start
//       margin: EdgeInsets.symmetric(horizontal: 22.0, vertical: 4.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             "Categories",
//             style: TextStyle(
//                 color: AppColors.txtColor,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold),
//           ),
//           ElevatedButton.icon(
//             onPressed: () {
//               Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => Categoriesscreen(),
//                   ));
//             },
//             label: Text(
//               AppTitles.explore,
//               style: TextStyle(color: AppColors.backgroundColor),
//               textAlign: TextAlign.center,
//             ),
//             icon: Icon(
//               Icons.arrow_forward_ios,
//               color: AppColors.backgroundColor,
//               size: 12,
//             ),
//             iconAlignment: IconAlignment.end,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: (AppColors.primaryColor),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(4),
//               ),
//               elevation: 5,
//               padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class Future_Product_title extends StatelessWidget {
//   const Future_Product_title({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       //Future Product title Start
//       margin: EdgeInsets.symmetric(horizontal: 22.0, vertical: 4.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             "Future Products",
//             style: TextStyle(
//                 color: AppColors.txtColor,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold),
//           ),
//           ElevatedButton.icon(
//             onPressed: () {
//               Navigator.pushReplacement(context,
//                   MaterialPageRoute(builder: (context) => AllProductsScreen()));
//             },
//             label: Text(
//               AppTitles.explore,
//               style: TextStyle(color: AppColors.backgroundColor),
//               textAlign: TextAlign.center,
//             ),
//             icon: Icon(
//               Icons.arrow_forward_ios,
//               color: AppColors.backgroundColor,
//               size: 12,
//             ),
//             iconAlignment: IconAlignment.end,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: (AppColors.primaryColor),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(4),
//               ),
//               elevation: 5,
//               padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class Products extends StatelessWidget {
  const Products({
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
        childAspectRatio: 0.58, // Controls height/width ratio to match design
        children: [
          ProductCard(
            title: 'HASTHIP',
            price: '₹1,999',
            imageUrl: '${futureProduct1}', // Image of product 1
          ),
          ProductCard(
            title: 'Bitdefender',
            price: '₹3,199',
            imageUrl: '${futureProduct2}', // Image of product 2
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
            child: Container(
              height: 270,
              child: Image.asset(
                imageUrl,
                height: double.infinity, // Adjust the height to your liking
                fit: BoxFit
                    .cover, // Ensures the image covers the available space
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 2.0, 0, 0),
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
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDetailsScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          AppColors.primaryColor, // Color of the button
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(6),
                              bottomRight: Radius.circular(6))),
                      padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                      elevation: 2, // Slight elevation for the button
                    ),
                    child: Text(
                      AppTitles.readmore,
                      style: TextStyle(
                          color: AppColors.backgroundColor,
                          fontWeight: FontWeight.bold),
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

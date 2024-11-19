import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:local_community/Names/imagenames.dart';
import 'package:local_community/Names/stringnames.dart';
import 'package:local_community/Screens/widgetsscreen.dart';
import 'package:http/http.dart' as http;

class Categoriesscreen extends StatefulWidget {
  const Categoriesscreen({super.key});

  @override
  State<Categoriesscreen> createState() => _CategoriesscreenState();
}

class _CategoriesscreenState extends State<Categoriesscreen> {
  List<dynamic> categories = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    final url = Uri.parse(
        'http://192.168.171.243:3000/getCategories'); // Replace with your API URL
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          categories = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print('Error fetching categories: $e');
    }
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSectionHeader("Categories"),
                  SizedBox(height: 8),
                  categories.isEmpty
                      ? Center(child: Text('No categories found'))
                      : Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  2, // This sets the number of items per row
                              crossAxisSpacing: 10, // Space between columns
                              mainAxisSpacing: 10, // Space between rows
                              childAspectRatio:
                                  1, // This ensures the items have a square-like appearance
                            ),
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              final category = categories[index];
                              final photoPath = category['img'];
                              return Column(
                                children: [
                                  TextButton(
                                    onPressed: () {},
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
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceEvenly, // For inside icon & text
                                        children: [
                                          CircleAvatar(
                                            radius: 30, // radius as required
                                            backgroundColor:
                                                AppColors.primaryColor,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Image.network(
                                                'http://192.168.171.243:3000/uploads/$photoPath',
                                                fit: BoxFit.cover,
                                                width: 50,
                                                height: 50,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4.0),
                                            child: Text(
                                              category['title'],
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
                              );
                            },
                          ),
                        ),
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
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
// Section Header for Categories end



// // Section Categories Card
// Widget _buildCategoryCard({
//   required String imageAsset1,
//   required String title1,
//   required Function() onTap1,
//   required String imageAsset2,
//   required String title2,
//   required Function() onTap2,
// }) {
//   return Container(
//     margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
//     child: Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             TextButton(
//               onPressed: onTap1,
//               child: Container(
//                 width: 150,
//                 height: 150,
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     style: BorderStyle.solid,
//                     color: AppColors.primaryColor,
//                     width: 2,
//                   ),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Column(
//                   mainAxisAlignment:
//                       MainAxisAlignment.spaceEvenly, // for inside icon & text
//                   children: [
//                     CircleAvatar(
//                       radius: 30, // radius as required
//                       backgroundColor: AppColors.primaryColor,
//                       child: Padding(
//                         padding: const EdgeInsets.all(12.0),
//                         child: Image.asset(
//                           imageAsset1,
//                           fit: BoxFit
//                               .cover, // Ensures the whole image is visible
//                           width: 50, // Adjust based on the size you need
//                           height: 50,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                       child: Text(
//                         title1,
//                         style: TextStyle(
//                           color: AppColors.txtColor,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             TextButton(
//               onPressed: onTap2,
//               child: Container(
//                 width: 150,
//                 height: 150,
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     style: BorderStyle.solid,
//                     color: AppColors.primaryColor,
//                     width: 2,
//                   ),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Column(
//                   mainAxisAlignment:
//                       MainAxisAlignment.spaceEvenly, // for inside icon & text
//                   children: [
//                     CircleAvatar(
//                       radius: 30, // radius as required
//                       backgroundColor: AppColors.primaryColor,
//                       child: Padding(
//                         padding: const EdgeInsets.all(12.0),
//                         child: Image.asset(
//                           imageAsset2,
//                           fit: BoxFit
//                               .cover, // Ensures the whole image is visible
//                           width: 50, // Adjust based on the size you need
//                           height: 50,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                       child: Text(
//                         title2,
//                         style: TextStyle(
//                           color: AppColors.txtColor,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ), // row  end
//         SizedBox(
//           height: 20,
//         ),
//       ],
//     ),
//   );
// }

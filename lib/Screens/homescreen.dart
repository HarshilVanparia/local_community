import 'package:flutter/material.dart';
import 'package:local_community/Names/imagenames.dart';
import 'package:local_community/Names/stringnames.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomSscreenState();
}

class _HomSscreenState extends State<HomeScreen> {
  // categories details
  final List<Map<String, String>> items = [
    {'title': 'Electronics', 'icon': category1},
    {'title': 'IOT', 'icon': category2},
    {'title': 'Circuit', 'icon': category3},
  ];

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
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(35, 8, 35, 8),
          child: Center(
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 22.0, vertical: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Future Products",
                            style: TextStyle(
                                color: AppColors.txtColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {},
                            label: Text(
                              AppTitles.explore,
                              style:
                                  TextStyle(color: AppColors.backgroundColor),
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
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    // Wrapping GridView in a container with dynamic height
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.count(
                        shrinkWrap:
                            true, // Important to ensure GridView takes only required height
                        crossAxisCount: 2, // Two items per row
                        crossAxisSpacing: 8, // Horizontal spacing between cards
                        mainAxisSpacing: 10, // Vertical spacing between cards
                        childAspectRatio:
                            0.65, // Controls height/width ratio to match design
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
                    ),
                    SizedBox(height: 8),
                    Container(
                      // Categories Title start
                      margin:
                          EdgeInsets.symmetric(horizontal: 22.0, vertical: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Categories",
                            style: TextStyle(
                                color: AppColors.txtColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {},
                            label: Text(
                              AppTitles.explore,
                              style:
                                  TextStyle(color: AppColors.backgroundColor),
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
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                            ),
                          ),
                        ],
                      ),
                    ), // Categories Title end
                    Container(
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
                                  items[index]
                                      ['icon']!, // Custom icon from the list
                                  fit: BoxFit
                                      .cover, // Ensures the whole image is visible
                                  width:
                                      38, // Adjust based on the size you need
                                  height: 38,
                                ),
                              ),
                            ),
                            title: Text(
                              items[index]['title']!, // Title of item
                              style: TextStyle(
                                  fontSize: 18, color: AppColors.txtColor),
                            ),
                          );
                        },
                      ),
                    ), //Categories End
                  ],
                ),
              ],
            ),
          ),
        ),
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
            child: Image.network(
              imageUrl,
              height: 170, // Adjust the height to your liking
              fit: BoxFit.cover, // Ensures the image covers the available space
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
                          fontSize: 12,
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
                SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  height: 36,
                  child: ElevatedButton(
                    onPressed: () {},
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

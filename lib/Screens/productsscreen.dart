import 'package:flutter/material.dart';
import 'package:local_community/Names/imagenames.dart';
import 'package:local_community/Names/stringnames.dart';
import 'package:local_community/Screens/homescreen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
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
                  Future_Product_title(),
                  SizedBox(height: 8),
                  FutureProducts(),
                  SizedBox(height: 18),
                ],
              ),
            ),
          ],
        ),
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
        childAspectRatio: 0.58, // Controls height/width ratio to match design
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

class Future_Product_title extends StatelessWidget {
  const Future_Product_title({
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
            "3D Printing",
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

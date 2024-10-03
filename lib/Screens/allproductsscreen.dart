import 'package:flutter/material.dart';
import 'package:local_community/Names/imagenames.dart';
import 'package:local_community/Names/stringnames.dart';
import 'package:local_community/Screens/productdetailsscreen.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: EdgeInsets.fromLTRB(5, 8, 5, 8),
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
                  DPrinting(),
                  SizedBox(height: 8),
                  DProdcuts(),
                  SizedBox(height: 8),
                  SizedBox(height: 16),
                  IotProdcutTitle(),
                  SizedBox(height: 8),
                  IotProduct(),
                  SizedBox(height: 16),
                  CircuitProdcutTitle(),
                  SizedBox(height: 8),
                  CircuitProduct(),
                  SizedBox(height: 16),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 14),
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => ProductDetailsScreen()));
                      },
                      child: Text(
                        "UPLOAD YOUR OWN PRODUCT",
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
                    height: 28,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CircuitProdcutTitle extends StatelessWidget {
  const CircuitProdcutTitle({
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
            categoriesTitles.iot,
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

class CircuitProduct extends StatelessWidget {
  CircuitProduct({
    super.key,
  });
  // Product data
  final products = [
    {
      'title': 'ESP Module',
      'price': '₹103',
      'imageUrl': esp32, // First product image
    },
    {
      'title': 'ESP32 Wroom32 ',
      'price': '₹349',
      'imageUrl': espwroom, // Second product image
    },
    {
      'title': 'ESP Module',
      'price': '₹103',
      'imageUrl': esp32, // Third product image
    },
    {
      'title': 'ESP32 Wroom32 ',
      'price': '₹349',
      'imageUrl': espwroom, // Fourth product image
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: 320, // Adjust height to show two products
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // Horizontal scrolling
        itemCount: products.length, // Number of products in the list
        itemBuilder: (context, index) {
          final product = products[index];
          return Container(
            width: 190, // Display 2 at a time
            height: 100,
            child: ProductCard(
              title: product['title']!,
              price: product['price']!,
              imageUrl: product['imageUrl']!,
            ),
          );
        },
      ),
    );
  }
}

class IotProdcutTitle extends StatelessWidget {
  const IotProdcutTitle({
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
            categoriesTitles.iot,
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

class IotProduct extends StatelessWidget {
  IotProduct({
    super.key,
  });
  // Product data
  final products = [
    {
      'title': 'HASTHIP',
      'price': '₹1,999',
      'imageUrl': futureProduct1, // First product image
    },
    {
      'title': 'Bitdefender',
      'price': '₹3,199',
      'imageUrl': futureProduct2, // Second product image
    },
    {
      'title': 'HASTHIP',
      'price': '₹1,999',
      'imageUrl': futureProduct1, // Third product image
    },
    {
      'title': 'Bitdefender',
      'price': '₹3,199',
      'imageUrl': futureProduct2, // Fourth product image
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: 320, // Adjust height to show two products
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // Horizontal scrolling
        itemCount: products.length, // Number of products in the list
        itemBuilder: (context, index) {
          final product = products[index];
          return Container(
            width: 190, // Display 2 at a time
            height: 100,
            child: ProductCard(
              title: product['title']!,
              price: product['price']!,
              imageUrl: product['imageUrl']!,
            ),
          );
        },
      ),
    );
  }
}

class DPrinting extends StatelessWidget {
  const DPrinting({
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
            categoriesTitles.printing,
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

class DProdcuts extends StatelessWidget {
  DProdcuts({
    super.key,
  });
  // Product data
  final products = [
    {
      'title': 'M1',
      'price': '₹290',
      'imageUrl': product1, // First product image
    },
    {
      'title': 'White Temple',
      'price': '₹89',
      'imageUrl': product2, // Second product image
    },
    {
      'title': 'M1',
      'price': '₹290',
      'imageUrl': product1, // First product image
    },
    {
      'title': 'White Temple',
      'price': '₹89',
      'imageUrl': product2, // Second product image
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: 320, // Adjust height to show two products
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // Horizontal scrolling
        itemCount: products.length, // Number of products in the list
        itemBuilder: (context, index) {
          final product = products[index];
          return Container(
            width: 190, // Display 2 at a time
            height: 100,
            child: ProductCard(
              title: product['title']!,
              price: product['price']!,
              imageUrl: product['imageUrl']!,
            ),
          );
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;

  ProductCard({
    required this.title,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: 12, vertical: 8), // Margin between cards
      decoration: BoxDecoration(
        color: AppColors.backgroundColor, // Card background color
        borderRadius: BorderRadius.circular(8), // Rounded corners
        border: Border.all(color: AppColors.primaryColor, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Aligns button at bottom
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(6),
              topRight: Radius.circular(6),
            ),
            child: Image.asset(
              imageUrl,
              height: 170, // Adjust the image height
              fit: BoxFit.fill, // Ensures the image covers the available space
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Title
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.txtColor,
                  ),
                ),
                SizedBox(height: 8), // Space between title and price
                // Product Price
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
          // Button
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
                backgroundColor: AppColors.primaryColor, // Button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(6),
                    bottomRight: Radius.circular(6),
                  ),
                ),
                elevation: 2, // Button elevation
              ),
              child: Text(
                AppTitles.readmore,
                style: TextStyle(
                  color: AppColors.backgroundColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

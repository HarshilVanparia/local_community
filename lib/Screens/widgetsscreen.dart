import 'package:flutter/material.dart';
import 'package:local_community/Names/imagenames.dart';
import 'package:local_community/Names/stringnames.dart';

class MyAllWidget extends StatelessWidget {
  const MyAllWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Future Products Section
              _buildSectionHeader('Future Products', onTap: () {}),
              SizedBox(height: 8),
              _buildFutureProducts(),

              SizedBox(height: 24),

              // Categories Section
              _buildSectionHeader('Categories', onTap: () {}),
              SizedBox(height: 8),
              _buildCategories(),

              SizedBox(height: 24),

              // Community Posts Section
              _buildSectionHeader('Community Posts', onTap: () {}),
              SizedBox(height: 8),
              _buildCommunityPosts(),
            ],
          ),
        ),
      ),
    );
  }

  // Section Header Widget with Explore Button
  Widget _buildSectionHeader(String title, {required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ElevatedButton.icon(
          onPressed: () {
            // Navigator.pushReplacement(context,
            //     MaterialPageRoute(builder: (context) => AllProductsScreen()));
          },
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
    );
  }

  // Future Products Grid
  Widget _buildFutureProducts() {
    return SizedBox(
      height: 220,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildProductCard('HASTHIP', '₹1,999', 'assets/futureProduct1.png'),
          _buildProductCard(
              'Bitdefender', '₹3,199', 'assets/futureProduct2.png'),
        ],
      ),
    );
  }

  // Product Card
  Widget _buildProductCard(String title, String price, String imageUrl) {
    return Container(
      width: 160,
      margin: EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.amber, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            child: Image.asset(
              imageUrl,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: Colors.black87)),
                SizedBox(height: 4),
                Text(price, style: TextStyle(color: Colors.black87)),
              ],
            ),
          ),
          Spacer(),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16)),
              ),
            ),
            child: Text(AppTitles.readmore),
          ),
        ],
      ),
    );
  }

  // Categories List
  Widget _buildCategories() {
    return Column(
      children: [
        _buildCategoryItem('Electronics', 'assets/electronics.png'),
        _buildCategoryItem('IOT', 'assets/iot.png'),
        _buildCategoryItem('Circuit', 'assets/circuit.png'),
      ],
    );
  }

  // Category Item
  Widget _buildCategoryItem(String title, String icon) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.amber,
        child: ClipOval(
          child: Image.asset(icon, fit: BoxFit.contain),
        ),
      ),
      title: Text(title, style: TextStyle(color: Colors.white)),
      onTap: () {},
    );
  }

  // Community Posts
  Widget _buildCommunityPosts() {
    return Container(
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

  // Floating Bottom Navigation Bar
  Widget _buildFloatingBottomNavigationBar() {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 8.0,
      color: Colors.black87,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.amber),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.settings, color: Colors.amber),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

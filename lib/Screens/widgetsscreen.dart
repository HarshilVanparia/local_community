import 'package:flutter/material.dart';
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
          _buildProductCard('Bitdefender', '₹3,199', 'assets/futureProduct2.png'),
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
              backgroundColor: Colors.amber,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16)),
              ),
            ),
            child: Text('Read More', style: TextStyle(color: Colors.black87)),
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
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.amber,
                child: Icon(Icons.person, color: Colors.black87),
              ),
              SizedBox(width: 8),
              Text('User789', style: TextStyle(color: Colors.white)),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'I\'m facing problems when I click on the button...',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 4,
            children: [
              Chip(label: Text('#IoT')),
              Chip(label: Text('#Circuit')),
              Chip(label: Text('#Flutter')),
              Chip(label: Text('#ESP32')),
            ],
          ),
          SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              hintText: 'Comment here...',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            ),
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
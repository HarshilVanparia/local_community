import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:local_community/Names/imagenames.dart';
import 'package:local_community/Names/stringnames.dart';
import 'package:local_community/Screens/allproductsscreen.dart';
import 'package:local_community/Screens/categoriesscreen.dart';
import 'package:local_community/Screens/communitypostscreen.dart';
import 'package:local_community/Screens/homescreen.dart';
import 'package:local_community/Screens/productdetailsscreen.dart';
import 'package:local_community/Screens/productsscreen.dart';
import 'package:local_community/Screens/profilescreen.dart';

// FloatingCircularMenu Start
class FloatingCircularMenu extends StatefulWidget {
  const FloatingCircularMenu({Key? key}) : super(key: key);

  @override
  _FloatingCircularMenuState createState() => _FloatingCircularMenuState();
}

class _FloatingCircularMenuState extends State<FloatingCircularMenu>
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
    setState(() {
      isMenuOpen = !isMenuOpen;
      isMenuOpen ? _controller.forward() : _controller.reverse();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        // Buttons positioned in a half-circle
        if (isMenuOpen) ...[
          _buildCircularMenuItem(
            icon: Icons.category,
            label: "Categories",
            leftOffset: -120,
            bottomOffset: 150,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Categoriesscreen()),
              );
            },
          ),
          _buildCircularMenuItem(
            icon: Icons.propane_rounded,
            label: "Products",
            leftOffset: 60,
            bottomOffset: 150,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AllProductsScreen()),
              );
            },
          ),
          _buildCircularMenuItem(
            icon: Icons.person,
            label: "Profile",
            leftOffset: -160,
            bottomOffset: 60,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
          _buildCircularMenuItem(
            icon: Icons.post_add,
            label: "Posts",
            leftOffset: 100,
            bottomOffset: 60,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => CommunityPostScreen()),
              );
            },
          ),
          _buildCircularMenuItem(
            icon: Icons.home,
            label: "Home",
            leftOffset: -30,
            bottomOffset: 160,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
          ),
        ],
        // Main Bottom-Center Button
        Positioned(
          height: 66,
          width: 66,
          bottom: 40,
          child: FloatingActionButton(
            onPressed: toggleMenu,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                isMenuOpen ? Icons.close : Icons.home,
                size: 32,
                key: ValueKey<bool>(isMenuOpen),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // _buildCircularMenuItem Start
  Widget _buildCircularMenuItem({
    required IconData icon,
    required String label,
    required double leftOffset,
    required double bottomOffset,
    required VoidCallback onPressed,
  }) {
    return Positioned(
      left: MediaQuery.of(context).size.width / 2 + leftOffset,
      bottom: bottomOffset,
      child: CircularMenuButton(
        icon: icon,
        label: label,
        onPressed: onPressed,
      ),
    );
  }
  // _buildCircularMenuItem End
}

// CircularMenuButton Start
class CircularMenuButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const CircularMenuButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 70, // Adjust as needed for your design
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20),
          color:
              AppColors.primaryColor, // Or any color for the button background
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: AppColors.backgroundColor,
            ),
            const SizedBox(height: 4),
            OverflowBar(
              spacing: 5,
              overflowSpacing: 5,
              overflowDirection: VerticalDirection.down,
              overflowAlignment: OverflowBarAlignment.center,
              alignment: MainAxisAlignment.spaceAround,
              children: [
                AutoSizeText(
                  label,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize:
                        12, // Set the max size; it will scale down as needed
                    color: AppColors.backgroundColor,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  minFontSize: 10, // Minimum font size to prevent overflow
                  overflow: TextOverflow.clip,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
// CircularMenuButton End

// Section Categories List
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

// Section Community Posts
class Community_Posts extends StatelessWidget {
  // final List<Map<String, dynamic>> tags = [
  //   {"text": "#ESP32"},
  //   {"text": "#Iot"},
  //   {"text": "#Circuit"},
  //   {"text": "#Android"},
  //   {"text": "#AndroidStudio"},
  //   {"text": "#ESP32Module"},
  // ];
  final String userName;
  final String userAvatar;
  final String postImage;
  final String postContent;
  final List<Map<String, dynamic>> tags;
  final String commentContent;

  // Constructor to pass different values to the widget
  Community_Posts({
    required this.userName,
    required this.userAvatar,
    required this.postImage,
    required this.postContent,
    required this.tags,
    required this.commentContent,
  });

  @override
  Widget build(BuildContext context) {
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
                    child:
                        CircleAvatar(backgroundImage: AssetImage(userAvatar))),
                SizedBox(
                  width: 8,
                ),
                Text(
                  userName,
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
              postImage,
              fit: BoxFit.contain,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  postContent,
                  style: TextStyle(color: AppColors.txtColor),
                  textAlign: TextAlign.justify,
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: tags.map((item) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 2, color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(6),
                        color: AppColors.primaryColor,
                      ),
                      child: Text(
                        item['text'], // Text from data
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, wordSpacing: 1),
                      ),
                    );
                  }).toList(),
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
                    commentContent,
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

// Community Post Reusable Widget Start
class Community_Post extends StatelessWidget {
  final List<Map<String, dynamic>> tags = [
    {"text": "#ESP32"},
    {"text": "#Iot"},
    {"text": "#Circuit"},
    {"text": "#Android"},
    {"text": "#AndroidStudio"},
    {"text": "#ESP32Module"},
  ];

  @override
  Widget build(BuildContext context) {
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
                  postTitle.puser,
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
                  postTitle.postContent,
                  style: TextStyle(color: AppColors.txtColor),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: tags.map((item) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 2, color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(6),
                        color: AppColors.primaryColor,
                      ),
                      child: Text(
                        item['text'], // Text from data
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, wordSpacing: 1),
                      ),
                    );
                  }).toList(),
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
                    postTitle.postcomments,
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
// Community Post Reusable Widget Start

// Community Posts Title Start
class Community_Posts_Title extends StatelessWidget {
  const Community_Posts_Title({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Community Posts Title start
      margin: EdgeInsets.symmetric(horizontal: 22.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Community Posts",
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
// Community Post Title End

// Products Section Start
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
// Product End

// Product card Start
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
              height: 180,
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
                      Navigator.push(
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
// Product Card End



// Register Fields Resuable

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final Color borderColor;
  final EdgeInsets contentPadding;
  final bool obscureText;
  final TextEditingController? controller;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;

  CustomTextField({
    required this.hintText,
    required this.borderColor,
    this.keyboardType = TextInputType.text,
    this.contentPadding = const EdgeInsets.fromLTRB(14, 0, 0, 0),
    this.obscureText = false,
    this.controller,
    this.suffixIcon,
    this.onSuffixIconPressed, required String? Function(dynamic value) validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: TextStyle(
        color: borderColor,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(70),
          borderSide: BorderSide(color: borderColor),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(70),
          borderSide: BorderSide(color: borderColor),
        ),
        contentPadding: contentPadding,
        hintStyle: TextStyle(color: borderColor),
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(suffixIcon, color: borderColor),
                onPressed: onSuffixIconPressed,
              )
            : null,
      ),
    );
  }
}
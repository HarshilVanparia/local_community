import 'package:flutter/material.dart';
import 'package:local_community/Names/imagenames.dart';
import 'package:local_community/Names/stringnames.dart';
import 'package:local_community/Screens/allproductsscreen.dart';
import 'package:local_community/Screens/widgetsscreen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: EdgeInsets.fromLTRB(5, 8, 5, 8),
          child: Row(
            children: [
              // IconButton(
              //   onPressed: () {
              //     // Navigator.pushReplacement(
              //     //     context,
              //     //     MaterialPageRoute(
              //     //         builder: (context) => AllProductsScreen()));
              //   },
              //   icon: Icon(
              //     Icons.arrow_back,
              //     color: AppColors.txtColor,
              //   ),
              // ),
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
                  SizedBox(height: 8),
                  SizedBox(
                      width: 125,
                      height: 125,
                      child: CircleAvatar(backgroundImage: AssetImage(goku))),
                  SizedBox(
                    height: 12,
                  ),
                  EditProfile(),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 100,
                  ),
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



class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  // List of items in the dropdown

  // Variable to hold the selected value
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 32,
          ),
          Text(
            "Personal Details",
            style: TextStyle(
                color: AppColors.txtColor,
                fontSize: 24,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: AppColors.txtColor),
                color: AppColors.txtColor,
                borderRadius: BorderRadius.circular(6)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "First Name",
                  style: TextStyle(
                      color: AppColors.backgroundColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2, color: AppColors.backgroundColor),
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.circular(6)),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Harshil",
                      hintStyle: TextStyle(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Last Name",
                  style: TextStyle(
                      color: AppColors.backgroundColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2, color: AppColors.backgroundColor),
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.circular(6)),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Vanparia",
                      hintStyle: TextStyle(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Address",
                  style: TextStyle(
                      color: AppColors.backgroundColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 150,
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2, color: AppColors.backgroundColor),
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.circular(6)),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Rajkot",
                      hintStyle: TextStyle(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Country",
                  style: TextStyle(
                      color: AppColors.backgroundColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2, color: AppColors.backgroundColor),
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.circular(6)),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "India",
                      hintStyle: TextStyle(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "City",
                  style: TextStyle(
                      color: AppColors.backgroundColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2, color: AppColors.backgroundColor),
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.circular(6)),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Rajkot",
                      hintStyle: TextStyle(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Text(
            "Mobile Number",
            style: TextStyle(
                color: AppColors.txtColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: AppColors.txtColor),
                color: AppColors.txtColor,
                borderRadius: BorderRadius.circular(6)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2, color: AppColors.backgroundColor),
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.circular(6)),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '777777777',
                      hintStyle: TextStyle(
                        color: AppColors.txtColor,
                      ),
                    ),
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Text(
            "Email Address",
            style: TextStyle(
                color: AppColors.txtColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: AppColors.txtColor),
                color: AppColors.txtColor,
                borderRadius: BorderRadius.circular(6)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2, color: AppColors.backgroundColor),
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.circular(6)),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'hvanpariya647@rku.ac.in',
                      hintStyle: TextStyle(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 18,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => AllProductsScreen()));
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "SAVE CHANGES",
                  style: TextStyle(
                      color: AppColors.backgroundColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AppColors {
  //defining app color codes
  static const Color backgroundColor = Color(0xFF04061F); // hex color #04061F
  static const Color primaryColor = Color(0xFFF5C468); // hex color #F5C468
  static const Color dangerColor = Color(0xFFFF2525); // hex color #FF2525
  static const Color txtColor = Color(0xFFFFFFFF); // hex color #FFFFFF
  static const Color lineColor =
      Color.fromARGB(130, 245, 196, 104); // hex color #F5C468
  static const Color graybox =
      Color.fromARGB(136, 255, 255, 255); // hex color #FFFFFF
  static const Color commentbox =
      Color.fromARGB(41, 255, 255, 255); // hex color #FFFFFF
}

class AppTitles {
  // defining repeted title of app
  static const String appTitle = "Local Community";
  static const String explore = "Explore";
  static const String readmore = "Read More";
  static const String comment = "Comment here...";
  static const String contact = "CONTACT";
}

class categoriesTitles {
  static const String iot = "Iot";
  static const String ele = "Electroincs";
  static const String circuit = "Circuit";
  static const String printing = "3D Printing";
  static const String design = "Custom Design";
  static const String art = "Art";
  static const String herbs = "Herbs";
  static const String led = "Strip Led";
}

class productTitle {
  static const String ptitle = "Product Title";
  static const String pdetails = "Product Details";
  static const String pspec = "Product Specification:";
  static const String pmodel = "Model Name:";
  static const String pdescript = "Product Description";
  static const String brand = "Brand";

  static const String pname = "Enter product name";
  static const String pcategorytitle = "Product Category";
  static const String pimg = "Product Image";
}

class postTitle {
  static const String puser = "Kachra seth";
  static const String ptitle = "Post Title";
  static const String ptag = "Post Tags";
  static const String pdescript = "Post Details";
  static const String brand = "Brand";
  static const String pimg = "Product Image";
  static const String postContent = "I’m facing problem when ever click on button then it should on LED light of ESP32 with Bluetooth but its not working if anyone have solution please comment down. appreciate any help thanks in advance.";
  static const String postcomments = "Step:1 Try running the flutter build web command in your project and inspect the build folder. Assuming a pubspec.yaml with following asset configurations.\nStep: 2 Ensure the files as shown above are available in your server where this folder is hosted. Also verify if the server has any configurations to be made specifically for image files or types of images files.";
}
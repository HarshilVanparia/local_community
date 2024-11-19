import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:local_community/Names/imagenames.dart';
import 'package:local_community/Names/stringnames.dart';
import 'package:local_community/Screens/allproductsscreen.dart';
import 'package:local_community/Screens/productsscreen.dart';
import 'package:local_community/Screens/widgetsscreen.dart';
import 'package:http/http.dart' as http;

class UploadProductScreen extends StatefulWidget {
  const UploadProductScreen({super.key});

  @override
  State<UploadProductScreen> createState() => _UploadProductScreenState();
}

class _UploadProductScreenState extends State<UploadProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: EdgeInsets.fromLTRB(5, 8, 5, 8),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AllProductsScreen()));
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: AppColors.txtColor,
                ),
              ),
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
                  UploadProduct(),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 28,
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

class UploadProduct extends StatefulWidget {
  const UploadProduct({super.key});

  @override
  State<UploadProduct> createState() => _UploadProductState();
}

class _UploadProductState extends State<UploadProduct> {
  String? selectedCategory;
  String? selectedItem; // For predefined categories
  bool isCustomCategory = false; // Toggle for custom category
  List<dynamic> categories = [];
  final customTitleController = TextEditingController();
  final customImageController = TextEditingController();
  final productTitleController = TextEditingController();
  final productDetailsController = TextEditingController();
  final brandNameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;
  String? customImagePath;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await fetchCategories();
  }

  Future<void> fetchCategories() async {
    const url = 'http://192.168.171.243:3000/getCategories'; // API URL
    try {
      final response = await http.get(Uri.parse(url));
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

  Future<void> submitProduct() async {
    final productTitle = productTitleController.text.trim();
    final productDetails = productDetailsController.text.trim();
    final brandName = brandNameController.text.trim();

    if (productTitle.isEmpty || productDetails.isEmpty || brandName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('All fields (title, details, brand) are required'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select an image for the product'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (isCustomCategory) {
      if (customTitleController.text.isEmpty || customImagePath == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Custom category title and image are required'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final newCategory = {
        'title': customTitleController.text,
        'img': customImagePath,
      };

      try {
        final categoryResponse = await http.post(
          Uri.parse('http://192.168.171.243:3000/addCategory'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(newCategory),
        );

        if (categoryResponse.statusCode == 201) {
          final categoryData = json.decode(categoryResponse.body);
          final customCategoryId = categoryData['categoryId'];
          print('Custom category added: $customCategoryId');

          await submitProductToDatabase(
            productTitle: productTitle,
            productDetails: productDetails,
            brandName: brandName,
            categoryId: customCategoryId,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to add custom category.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error adding custom category: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      if (selectedCategory == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please select a predefined category'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      await submitProductToDatabase(
        productTitle: productTitle,
        productDetails: productDetails,
        brandName: brandName,
        categoryId: int.parse(selectedCategory!),
      );
    }
  }

  Future<void> submitProductToDatabase({
    required String productTitle,
    required String productDetails,
    required String brandName,
    required int categoryId,
  }) async {
    final productData = {
      'product_title': productTitle,
      'pdetails': productDetails,
      'brandName': brandName,
      'categoryId': categoryId,
      'pimg': _imageFile!.path, // Adjust this if you upload image to a server
    };

    try {
      final response = await http.post(
        Uri.parse('http://192.168.171.243:3000/addProduct'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(productData),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Product added successfully'),
            backgroundColor: Colors.green,
          ),
        );

        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ProductsScreen()),
          );
        });
      } else {
        final errorResponse = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add product: ${errorResponse['message']}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        customImagePath = pickedFile.path;
      });
    }
  }

  Widget buildCategorySelector() {
    if (isCustomCategory) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: customTitleController,
            decoration: const InputDecoration(labelText: "Category Title"),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ButtonStyle(
                padding:
                    WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 10)),
                backgroundColor:
                    WidgetStatePropertyAll(AppColors.backgroundColor)),
            onPressed: _pickImage,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.image,
                  color: AppColors.primaryColor,
                ),
                SizedBox(width: 8),
                Text(
                  "Pick Image",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          if (_imageFile != null) Image.file(_imageFile!, height: 150),
        ],
      );
    } else {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: AppColors.backgroundColor),
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.circular(6)),
        child: categories.isEmpty
            ? Text(
                "No data") // Show a loading spinner while fetching categories
            : DropdownButton<String>(
                iconEnabledColor:
                    AppColors.primaryColor, // Customize icon color
                borderRadius: BorderRadius.circular(4),
                hint: Text(
                  "Select Category", // Update this with your category title
                  style: TextStyle(color: AppColors.primaryColor, fontSize: 16),
                ),
                style: TextStyle(color: AppColors.primaryColor),
                isExpanded: true,
                focusColor: AppColors.primaryColor,
                dropdownColor: AppColors.backgroundColor,
                value: selectedItem, // Currently selected item
                onChanged: (String? newValue) {
                  setState(() {
                    selectedItem = newValue; // Update the selected item
                  });
                },
                items: categories.map((category) {
                  // Map the categories to the dropdown items
                  return DropdownMenuItem<String>(
                    value: category[
                        'title'], // Assuming category['title'] holds the name
                    child: Text(category['title']), // Display category title
                  );
                }).toList(),
              ),
      );
    }
  }

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
            "Upload Product",
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
                  productTitle.ptitle,
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
                      hintText: productTitle.pname,
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
                  productTitle.pcategorytitle,
                  style: TextStyle(
                      color: AppColors.backgroundColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Radio<bool>(
                          value: false,
                          groupValue: isCustomCategory,
                          onChanged: (value) {
                            setState(() {
                              isCustomCategory = value!;
                            });
                          },
                        ),
                        const Text("Predefined Category"),
                      ],
                    ),
                    Column(
                      children: [
                        Radio<bool>(
                          value: true,
                          groupValue: isCustomCategory,
                          onChanged: (value) {
                            setState(() {
                              isCustomCategory = value!;
                            });
                          },
                        ),
                        const Text("Custom Category"),
                      ],
                    ),
                  ],
                ),
                buildCategorySelector(),
                const SizedBox(height: 8),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  productTitle.pdescript,
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
                      hintText: 'Enter ' + productTitle.pdescript,
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
                  height: 14,
                ),
                Text(
                  productTitle.pimg,
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
                  decoration: BoxDecoration(
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.circular(50)),
                  child: _imageFile != null
                      ? Image.file(_imageFile!, height: 200, fit: BoxFit.cover)
                      : TextButton.icon(
                          onPressed: _pickImage,
                          icon: Icon(Icons.add_photo_alternate),
                          label: Text('Select Image'),
                        ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Text(
            productTitle.brand,
            style: TextStyle(
                color: AppColors.primaryColor,
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
                      hintText: 'Enter ' + productTitle.brand + ' Name',
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
            onPressed: submitProduct,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "UPLOAD",
                  style: TextStyle(
                      color: AppColors.backgroundColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}

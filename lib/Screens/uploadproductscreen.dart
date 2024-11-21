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
  final TextEditingController productTitleController = TextEditingController();
  final TextEditingController productDetailsController =
      TextEditingController();
  final TextEditingController brandNameController = TextEditingController();
  final TextEditingController customTitleController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  File? _imageFile;
  String? customImagePath;
  List categories = [];
  String? selectedCategory;
  bool isCustomCategory = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      await fetchCategories();
    } catch (e) {
      print('Error loading data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading categories. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> fetchCategories() async {
    const url = 'http://192.168.171.9:3000/getCategories';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          categories = json.decode(response.body) as List;
        });
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print('Error fetching categories: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to fetch categories. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Submit product to database with the correct category ID
  Future<void> submitProductToDatabase({
    required String productTitle,
    required String productDetails,
    required String brandName,
    required int categoryId,
    required String categoryTitle, // added categoryTitle here
  }) async {
    final productData = {
      'product_title': productTitle,
      'title':
          categoryTitle, // This ensures the category title is passed correctly
      'pdetails': productDetails,
      'brandName': brandName,
      'categoryId': categoryId,
      'pimg': _imageFile!.path,
    };

    try {
      final response = await http.post(
        Uri.parse('http://192.168.171.9:3000/addProduct'),
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
        // Navigate to product screen
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ProductsScreen()),
          );
        });
      } else {
        final errorResponse = json.decode(response.body);
        showErrorSnackBar('Failed to add product: ${errorResponse['message']}');
      }
    } catch (e) {
      showErrorSnackBar('Error: $e');
    }
  }

  Future<void> addCustomCategoryAndSubmitProduct({
    required String productTitle,
    required String productDetails,
    required String brandName,
    required Map<String, String> categoryData,
  }) async {
    // Ensure customTitleController.text and customImagePath are not null or empty
    final customTitle = customTitleController.text.trim();
    if (customTitle.isEmpty) {
      showErrorSnackBar('Custom category title is required');
      return;
    }

    if (customImagePath == null || customImagePath!.isEmpty) {
      showErrorSnackBar('Custom category image is required');
      return;
    }

    try {
      // Add custom category to the categories table
      final response = await http.post(
        Uri.parse('http://192.168.171.9:3000/addCategory'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'title': customTitle,
          'img': customImagePath!,
        }),
      );

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        final customCategoryId = responseData['categoryId'];

        // Add product to the products table with custom category ID
        await submitProductToDatabase(
          productTitle: productTitle,
          productDetails: productDetails,
          brandName: brandName,
          categoryId: customCategoryId,
          categoryTitle: customTitle, // Pass the custom category title
        );
      } else {
        showErrorSnackBar('Failed to add custom category.');
      }
    } catch (e) {
      showErrorSnackBar('Error adding custom category: $e');
    }
  }

// Submit Product with Predefined Category
  Future<void> submitProduct() async {
    final productTitle = productTitleController.text.trim();
    final productDetails = productDetailsController.text.trim();
    final brandName = brandNameController.text.trim();

    // Ensure all required fields are filled
    if (productTitle.isEmpty || productDetails.isEmpty || brandName.isEmpty) {
      showErrorSnackBar('All fields (title, details, brand) are required');
      return;
    }

    if (_imageFile == null) {
      showErrorSnackBar('Please select an image for the product');
      return;
    }

    String categoryTitle = ''; // Initialize categoryTitle

    if (isCustomCategory) {
      final customTitle = customTitleController.text.trim();
      if (customTitle.isEmpty || customImagePath == null) {
        showErrorSnackBar('Custom category title and image are required');
        return;
      }

      // Use customTitleController for custom category title
      categoryTitle = customTitle;

      final newCategory = {
        'title': customTitle,
        'img': customImagePath!,
      };

      await addCustomCategoryAndSubmitProduct(
        productTitle: productTitle,
        productDetails: productDetails,
        brandName: brandName,
        categoryData: newCategory,
      );
    } else {
      if (selectedCategory == null) {
        showErrorSnackBar('Please select a predefined category');
        return;
      }

      // Retrieve the category title from the selected category
      final selectedCategoryTitle = categories.firstWhere(
        (category) => category['id'].toString() == selectedCategory,
      )['title'];

      categoryTitle = selectedCategoryTitle; // Set category title

      await submitProductToDatabase(
        productTitle: productTitle,
        productDetails: productDetails,
        brandName: brandName,
        categoryId: int.parse(selectedCategory!),
        categoryTitle: categoryTitle, // Pass categoryTitle to the database
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

  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  Widget buildCategorySelector() {
    if (isCustomCategory) {
      return Column(
        children: [
          TextField(
            controller: customTitleController,
            decoration: InputDecoration(labelText: "Category Title"),
          ),
          SizedBox(height: 12),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppColors.backgroundColor)),
            onPressed: _pickImage,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.image,
                  color: AppColors.primaryColor,
                ),
                Text(
                  "Pick Image",
                  style: TextStyle(color: AppColors.primaryColor),
                ),
              ],
            ),
          ),
          if (_imageFile != null) Image.file(_imageFile!, height: 150),
        ],
      );
    } else {
      return DropdownButton<String>(
        isExpanded: true,
        value: selectedCategory,
        hint: Text("Select Category"),
        onChanged: (value) {
          setState(() {
            selectedCategory = value;
          });
        },
        items: categories.map<DropdownMenuItem<String>>((category) {
          return DropdownMenuItem<String>(
            value: category['id'].toString(),
            child: Text(category['title']),
          );
        }).toList(),
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
                    controller: productTitleController,
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
                        Radio(
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
                        Radio(
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
                    controller: productDetailsController,
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
                    controller: brandNameController,
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

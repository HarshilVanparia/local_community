import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:local_community/Names/imagenames.dart';
import 'package:local_community/Names/stringnames.dart';
import 'package:local_community/Screens/allproductsscreen.dart';
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
      showErrorSnackBar('Failed to load data. Please try again.');
    }
  }

  Future<void> fetchCategories() async {
    const url = 'http://192.168.43.113:3000/getCategories';
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
      showErrorSnackBar('Error fetching categories.');
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    } else {
      showErrorSnackBar('No image selected.');
    }
  }

  Future<void> submitProduct() async {
    final productTitle = productTitleController.text.trim();
    final productDetails = productDetailsController.text.trim();
    final brandName = brandNameController.text.trim();
    final customTitle = customTitleController.text.trim();

    // Validate fields
    if (productTitle.isEmpty ||
        productDetails.isEmpty ||
        brandName.isEmpty ||
        _imageFile == null) {
      showErrorSnackBar('Please fill all required fields and upload an image.');
      return;
    }

    if (isCustomCategory && customTitle.isEmpty) {
      showErrorSnackBar('Custom category title is required.');
      return;
    }

    try {
      if (isCustomCategory) {
        await addCustomCategoryAndSubmitProduct(
          productTitle: productTitle,
          productDetails: productDetails,
          brandName: brandName,
          customTitle: customTitle,
        );
      } else {
        await submitProductToDatabase(
          productTitle: productTitle,
          productDetails: productDetails,
          brandName: brandName,
          categoryId: int.parse(selectedCategory!),
          categoryTitle: categories.firstWhere(
              (cat) => cat['id'].toString() == selectedCategory)['title'],
        );
      }
    } catch (e) {
      showErrorSnackBar('Failed to submit product: $e');
    }
  }

  Future<void> addCustomCategoryAndSubmitProduct({
    required String productTitle,
    required String productDetails,
    required String brandName,
    required String customTitle,
  }) async {
    try {
      final categoryRequest = http.MultipartRequest(
        'POST',
        Uri.parse('http://192.168.43.113:3000/addCategory'),
      );

      categoryRequest.fields['title'] = customTitle;

      final categoryResponse = await categoryRequest.send();
      final categoryResponseData =
          await http.Response.fromStream(categoryResponse);

      if (categoryResponse.statusCode == 201) {
        final responseData = json.decode(categoryResponseData.body);
        if (responseData['categoryId'] == null) {
          throw Exception('Category ID is null');
        }

        final customCategoryId = responseData['categoryId'];
        print('Received customCategoryId: $customCategoryId');

        await submitProductToDatabase(
          productTitle: productTitle,
          productDetails: productDetails,
          brandName: brandName,
          categoryId: customCategoryId,
          categoryTitle: customTitle,
        );
      } else {
        throw Exception('Failed to add custom category');
      }
    } catch (e) {
      throw Exception('Error adding custom category: $e');
    }
  }

  Future<void> submitProductToDatabase({
    required String productTitle,
    required String productDetails,
    required String brandName,
    required int categoryId,
    required String categoryTitle,
  }) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('http://192.168.43.113:3000/addProduct'),
      );

      request.fields['product_title'] = productTitle;
      request.fields['title'] = categoryTitle;
      request.fields['pdetails'] = productDetails;
      request.fields['brandName'] = brandName;
      request.fields['categoryId'] = categoryId.toString();
      request.files
          .add(await http.MultipartFile.fromPath('pimg', _imageFile!.path));

      final response = await request.send();
      final responseData = await http.Response.fromStream(response);

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Product added successfully!"),
            backgroundColor: Colors.green,
          ),
        );

        // Redirect to LoginScreen
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AllProductsScreen()),
          );
        });
      } else {
        final errorResponse = json.decode(responseData.body);
        showErrorSnackBar('Failed to add product: ${errorResponse['error']}');
      }
    } catch (e) {
      throw Exception('Error submitting product: $e');
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
      return TextField(
        controller: customTitleController,
        decoration: const InputDecoration(labelText: "Custom Category Title"),
      );
    } else {
      return DropdownButton<String>(
        isExpanded: true,
        value: selectedCategory,
        hint: const Text("Select Category"),
        onChanged: (value) {
          setState(() {
            selectedCategory = value;
            isCustomCategory = false; // Ensure it switches back
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
            height: 40,
          ),
        ],
      ),
    );
  }
}

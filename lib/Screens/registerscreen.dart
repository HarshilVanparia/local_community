import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_community/Names/imagenames.dart';
import 'package:local_community/Names/stringnames.dart';
import 'package:local_community/Screens/loginscreen.dart';
import 'package:local_community/Screens/widgetsscreen.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _unameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _unumberController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  bool _isObscured = true; // Tracks the visibility state of the password

  // image & register form datasend start
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      if (_imageFile != null) {
        await _pickAndUploadImage(
          _unameController.text,
          _emailController.text,
          _unumberController.text,
          _countryController.text,
          _cityController.text,
          _addressController.text,
          _passwordController.text,
        );
      } else {
        print('Please select an image');
      }
    }
  }

  Future<void> _pickAndUploadImage(String uname, String email, String unumber,
      String country, String city, String address, String upassword) async {
    if (_imageFile != null) {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://192.168.43.172:3000/register'),
      );

      // Add text fields
      request.fields['uname'] = uname;
      request.fields['email'] = email;
      request.fields['unumber'] = unumber;
      request.fields['country'] = country;
      request.fields['city'] = city;
      request.fields['address'] = address;
      request.fields['upassword'] = upassword;

      // Add image file
      request.files
          .add(await http.MultipartFile.fromPath('photo', _imageFile!.path));

      var response = await request.send();
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'User registered and image uploaded successfully',
              style: TextStyle(color: AppColors.txtColor),
            ),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to register user'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }
// end

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(
                      35, 22, 35, 22), // left top right bottom
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          wing,
                          width: 175,
                          height: 175,
                        ),
                        Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 32,
                            color: AppColors.txtColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        CustomTextField(
                          controller: _unameController,
                          hintText: "Name",
                          borderColor: AppColors.txtColor,
                          keyboardType: TextInputType.name,
                          validator: (value) => value!.isEmpty
                              ? "Please enter your username"
                              : null,
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        CustomTextField(
                          controller: _emailController,
                          hintText: "Email",
                          borderColor: AppColors.txtColor,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) =>
                              value!.isEmpty ? "Please enter your email" : null,
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        CustomTextField(
                          controller: _addressController,
                          hintText: "Address",
                          borderColor: AppColors.txtColor,
                          keyboardType: TextInputType.text,
                          validator: (value) => value!.isEmpty
                              ? "Please enter your address"
                              : null,
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        CustomTextField(
                          controller: _unumberController,
                          hintText: "Number",
                          borderColor: AppColors.txtColor,
                          keyboardType: TextInputType.number,
                          validator: (value) => value!.isEmpty
                              ? "Please enter your number"
                              : null,
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        CustomTextField(
                          controller: _cityController,
                          hintText: "City",
                          borderColor: AppColors.txtColor,
                          keyboardType: TextInputType.text,
                          validator: (value) =>
                              value!.isEmpty ? "Please enter your city" : null,
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        CustomTextField(
                          controller: _countryController,
                          hintText: "Country",
                          borderColor: AppColors.txtColor,
                          keyboardType: TextInputType.text,
                          validator: (value) => value!.isEmpty
                              ? "Please enter your country"
                              : null,
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        CustomTextField(
                          controller: _passwordController,
                          hintText: "Password",
                          borderColor: AppColors.txtColor,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: _isObscured,
                          suffixIcon: _isObscured
                              ? Icons.visibility_off
                              : Icons.visibility, // Change icon based on state
                          onSuffixIconPressed: () {
                            setState(() {
                              _isObscured =
                                  !_isObscured; // Toggle the visibility state
                            });
                          },
                          validator: (value) => value!.isEmpty
                              ? "Please enter your password"
                              : null,
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: AppColors.primaryColor,
                          ),
                          child: IconButton(
                            icon: Icon(Icons.image),
                            onPressed: _pickImage,
                            style: ButtonStyle(
                              iconSize: WidgetStatePropertyAll(30),
                              iconColor: WidgetStatePropertyAll(
                                  AppColors.backgroundColor),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        ElevatedButton(
                          onPressed: _registerUser,
                          child: Text(
                            "Submit",
                            style: TextStyle(
                                color: AppColors.backgroundColor,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(AppColors.primaryColor),
                            minimumSize: WidgetStatePropertyAll(
                                Size(double.infinity, 55)),
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 2,
                                width: 140,
                                child: Container(
                                  color: AppColors.lineColor,
                                )),
                            Text(
                              "  or  ",
                              style: TextStyle(color: AppColors.txtColor),
                            ),
                            SizedBox(
                                height: 2,
                                width: 140,
                                child: Container(
                                  color: AppColors.lineColor,
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        SizedBox(
                          width: 64,
                          height: 64,
                          child: IconButton(
                            icon: Image.asset(google),
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: TextStyle(
                                  fontSize: 18, color: AppColors.txtColor),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()));
                                },
                                child: Text("Login",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold))),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

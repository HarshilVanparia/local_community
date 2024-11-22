import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_community/Names/imagenames.dart';
import 'package:local_community/Names/stringnames.dart';
import 'package:local_community/Screens/loginscreen.dart';
import 'package:local_community/Screens/widgetsscreen.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isObscured = true; // Tracks the visibility state of the password
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

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

// register route
  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate() && _imageFile != null) {
      try {
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('http://192.168.43.113:3000/register'),
        );

        request.fields['uname'] = _unameController.text;
        request.fields['email'] = _emailController.text;
        request.fields['unumber'] = _unumberController.text;
        request.fields['country'] = _countryController.text;
        request.fields['city'] = _cityController.text;
        request.fields['address'] = _addressController.text;
        request.fields['upassword'] = _passwordController.text;
        request.files.add(
          await http.MultipartFile.fromPath('photo_path', _imageFile!.path),
        );

        var response = await request.send();
        var responseData = await http.Response.fromStream(response);
        var json = jsonDecode(responseData.body);

        if (response.statusCode == 201) {
          // Success: Registration completed
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(json['message']),
              backgroundColor: Colors.green,
            ),
          );

          // Redirect to LoginScreen
          Future.delayed(Duration(seconds: 2), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          });
        } else if (response.statusCode == 409) {
          // Email already registered
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(json['message']),
              backgroundColor: Colors.red,
            ),
          );
        } else {
          // General failure
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to register. Try again later.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An unexpected error occurred'),
            backgroundColor: Colors.red,
          ),
        );
        print('Error: $e');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all fields and select an image'),
          backgroundColor: Colors.red,
        ),
      );
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
                        GestureDetector(
                          onTap: _pickImage,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: _imageFile != null
                                ? FileImage(_imageFile!)
                                : null,
                            child: _imageFile == null
                                ? Icon(
                                    Icons.image_rounded,
                                    size: 50,
                                    color: AppColors.backgroundColor,
                                  )
                                : null,
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

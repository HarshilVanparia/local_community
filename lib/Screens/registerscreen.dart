
import 'package:flutter/material.dart';
import 'package:local_community/Module/regformdata.dart';
import 'package:local_community/Names/imagenames.dart';
import 'package:local_community/Names/stringnames.dart';
import 'package:local_community/Screens/loginscreen.dart';
import 'package:local_community/Screens/widgetsscreen.dart';
import 'package:local_community/Services/Services/regdatasend.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _unameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _unumberController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isObscured = true; // Tracks the visibility state of the password

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
                        ElevatedButton(
                          onPressed: () {
                            Quotes newUser = Quotes(
                              uname: _unameController.text,
                              email: _emailController.text,
                              unumber: _unumberController.text,
                              country: _countryController.text,
                              city: _cityController.text,
                              address: _addressController.text,
                              upassword: _passwordController.text,
                            );

                            registerUser(newUser,
                                context); // Call the function to register the user
                          },
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
                            minimumSize: WidgetStatePropertyAll(Size(450, 55)),
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
                            onPressed: () {},
                            icon: Image.asset(google),
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

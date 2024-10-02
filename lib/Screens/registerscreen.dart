import 'package:flutter/material.dart';
import 'package:local_community/Names/imagenames.dart';
import 'package:local_community/Names/stringnames.dart';
import 'package:local_community/Screens/loginscreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                      TextField(
                        style: TextStyle(
                          color: AppColors.txtColor,
                        ),
                        decoration: InputDecoration(
                          hintText: "Name",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(70),
                            borderSide: BorderSide(color: AppColors.txtColor),
                          ),
                          hintStyle: TextStyle(color: AppColors.txtColor),
                          contentPadding: EdgeInsets.fromLTRB(14, 0, 0, 0),
                        ),
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      TextField(
                        style: TextStyle(
                          color: AppColors.txtColor,
                        ),
                        decoration: InputDecoration(
                          hintText: "Email",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(70),
                            borderSide: BorderSide(color: AppColors.txtColor),
                          ),
                          hintStyle: TextStyle(color: AppColors.txtColor),
                          contentPadding: EdgeInsets.fromLTRB(14, 0, 0, 0),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      TextField(
                        style: TextStyle(
                          color: AppColors.txtColor,
                        ),
                        decoration: InputDecoration(
                          hintText: "Address",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(70),
                            borderSide: BorderSide(color: AppColors.txtColor),
                          ),
                          hintStyle: TextStyle(color: AppColors.txtColor),
                          contentPadding: EdgeInsets.fromLTRB(14, 0, 0, 0),
                        ),
                        keyboardType: TextInputType.streetAddress,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      TextField(
                        style: TextStyle(
                          color: AppColors.txtColor,
                        ),
                        decoration: InputDecoration(
                          hintText: "Country",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(70),
                            borderSide: BorderSide(color: AppColors.txtColor),
                          ),
                          contentPadding: EdgeInsets.fromLTRB(14, 0, 0, 0),
                          hintStyle: TextStyle(color: AppColors.txtColor),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      TextField(
                        style: TextStyle(
                          color: AppColors.txtColor,
                        ),
                        decoration: InputDecoration(
                          hintText: "City",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(70),
                            borderSide: BorderSide(color: AppColors.txtColor),
                          ),
                          contentPadding: EdgeInsets.fromLTRB(14, 0, 0, 0),
                          hintStyle: TextStyle(color: AppColors.txtColor),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      TextField(
                        style: TextStyle(
                          color: AppColors.txtColor,
                        ),
                        decoration: InputDecoration(
                          hintText: "Password",
                          suffixIcon: Icon(
                            Icons.visibility_off,
                            color: AppColors.txtColor,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(70),
                            borderSide: BorderSide(color: AppColors.txtColor),
                          ),
                          hintStyle: TextStyle(color: AppColors.txtColor),
                          contentPadding: EdgeInsets.fromLTRB(14, 0, 0, 0),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // SnackBar(
                          //     content: const Text("Regstration Successfull"));
                          // Navigate to the login screen
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

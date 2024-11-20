import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_community/Names/imagenames.dart';
import 'package:local_community/Names/stringnames.dart';
import 'package:local_community/Screens/communitypostscreen.dart';
import 'package:local_community/Screens/widgetsscreen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UploadPostScreen extends StatefulWidget {
  const UploadPostScreen({super.key});

  @override
  State<UploadPostScreen> createState() => _UploadPostScreenState();
}

class _UploadPostScreenState extends State<UploadPostScreen> {
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
                          builder: (context) => CommunityPostScreen()));
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
                  UploadPost(),
                  SizedBox(height: 18),
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

class UploadPost extends StatefulWidget {
  const UploadPost({super.key});

  @override
  State<UploadPost> createState() => _UploadPostState();
}

class _UploadPostState extends State<UploadPost> {
  final TextEditingController _pdetailsController = TextEditingController();
  final TextEditingController _ptagsController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadPost() async {
    if (_imageFile != null &&
        _pdetailsController.text.isNotEmpty &&
        _ptagsController.text.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? email =
          prefs.getString('email'); // Retrieve logged-in user's email

      if (email == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please log in again'),
          backgroundColor: Colors.red,
        ));
        return;
      }

      final request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://192.168.43.150:3000/uploadPost'), // Update with your server URL
      );

      request.fields['email'] = email; // Include the email in the request
      request.fields['pdetails'] = _pdetailsController.text;
      request.fields['ptags'] = _ptagsController.text;
      request.files
          .add(await http.MultipartFile.fromPath('pimg', _imageFile!.path));

      final response = await request.send();
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Post uploaded successfully'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ));
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => CommunityPostScreen()));
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to upload post'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please fill all fields and select an image'),
        backgroundColor: Colors.red,
      ));
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
            "Upload Post",
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
                  postTitle.ptag,
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
                    controller: _ptagsController,
                    decoration: InputDecoration(
                      hintText: 'Enter ' + postTitle.ptag,
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
                  postTitle.pdescript,
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
                    controller: _pdetailsController,
                    decoration: InputDecoration(
                      hintText: 'Enter ' + postTitle.pdescript,
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
                  "Post Image",
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
                  height: 10,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 18,
          ),
          SizedBox(
            height: 18,
          ),
          ElevatedButton(
            onPressed: _uploadPost,
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

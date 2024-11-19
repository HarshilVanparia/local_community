import 'package:flutter/material.dart';
import 'package:local_community/Names/imagenames.dart';
import 'package:local_community/Names/stringnames.dart';
import 'package:local_community/Screens/uploadpostscreen.dart';
import 'package:local_community/Screens/widgetsscreen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CommunityPostScreen extends StatefulWidget {
  const CommunityPostScreen({super.key});

  @override
  State<CommunityPostScreen> createState() => _CommunityPostScreenState();
}

class _CommunityPostScreenState extends State<CommunityPostScreen> {
  List<dynamic> posts = [];
  Map<int, List<dynamic>> comments = {};
  String? userId;
  bool isLoading = true;
  String? uname;
  String? email;
  String? photoPath; // To store the image name from SharedPreferences

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
    fetchPosts();
  }

  Future<void> _loadUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uname = prefs.getString('uname');
      email = prefs.getString('email');
      photoPath = prefs.getString('photo_path'); // Retrieve the image name
    });

    setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchPosts() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.171.243:3000/getPosts'));

      if (response.statusCode == 200) {
        // Ensure the response is valid and the data is a List
        var decodedResponse = json.decode(response.body);
        if (decodedResponse is List) {
          setState(() {
            posts = decodedResponse;
            isLoading = false;
          });
        } else {
          print("Unexpected data format received: $decodedResponse");
          setState(() {
            isLoading = false;
          });
        }
      } else {
        print('Failed to fetch posts. Status code: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      print('Error fetching posts: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchComments(int postId) async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.171.243:3000/comments/$postId'));
      if (response.statusCode == 200) {
        setState(() {
          comments[postId] = json.decode(response.body)['comments'];
        });
      } else {
        print('Failed to fetch comments. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching comments: $error');
    }
  }

  Future<void> _addComment(int postId, String comment) async {
    if (userId == null || uname == null || photoPath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User data not available. Please log in.')));
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://192.168.171.243:3000/add-comment'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'postid': postId,
          'userid': userId,
          'userphoto': photoPath,
          'username': uname,
          'comment': comment,
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Comment added successfully')));
        _fetchComments(postId); // Fetch updated comments
      } else {
        final error = json.decode(response.body)['error'] ?? 'Unknown error';
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error)));
      }
    } catch (error) {
      print('Error adding comment: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: EdgeInsets.fromLTRB(5, 8, 5, 8),
          child: Row(
            children: [
              Image.asset(
                logo,
                width: 50,
                height: 50,
              ),
              SizedBox(width: 8),
              Text(
                "Community Posts",
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // Main scrollable content
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 8),
                  Community_Posts_Title(),
                  SizedBox(height: 8),
                  // Constrain ListView inside a fixed-height Container
                  posts.isEmpty
                      ? Center(
                          child: Text('No posts found'),
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: ListView.builder(
                            itemCount: posts.length,
                            itemBuilder: (context, index) {
                              final post = posts[index];
                              final postId = post['postid'];
                              return Card(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          'http://192.168.171.243:3000/uploads/${post['userphoto']}',
                                        ),
                                      ),
                                      title: Text(
                                          post['username'] ?? 'Unknown User'),
                                    ),
                                    Image.network(
                                      'http://192.168.171.243:3000/uploads/${post['pimg']}',
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      height: 300,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Text('Image not available');
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        post['pdetails'] ??
                                            'No details available',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    if (post['ptags'] != null &&
                                        post['ptags'] is String)
                                      Wrap(
                                        spacing: 10,
                                        runSpacing: 10,
                                        children: (post['ptags'] as String)
                                            .split(',')
                                            .map((tag) => Chip(
                                                backgroundColor:
                                                    AppColors.primaryColor,
                                                label: Text(
                                                  tag.trim(),
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .backgroundColor,
                                                      fontSize: 14),
                                                )))
                                            .toList(),
                                      )
                                    else
                                      SizedBox(
                                        height: 8,
                                      ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              onSubmitted: (value) =>
                                                  _addComment(postId, value),
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                hintText: 'Add a comment...',
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 12),
                                          IconButton(
                                            icon: Icon(Icons.send,
                                                color: AppColors.primaryColor),
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    WidgetStatePropertyAll(
                                                        AppColors
                                                            .backgroundColor),
                                                padding: WidgetStatePropertyAll(
                                                    EdgeInsets.all(12))),
                                            onPressed: () =>
                                                _fetchComments(postId),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (post['comments'] != null &&
                                        post['comments'].isNotEmpty)
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: post['comments']
                                              .map<Widget>((comment) {
                                            return ListTile(
                                              leading: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    'http://192.168.171.243:3000/uploads/${comment['userphoto']}'),
                                              ),
                                              title: Text(comment['username'] ??
                                                  'Anonymous'),
                                              subtitle: Text(
                                                  comment['comment'] ?? ''),
                                            );
                                          }).toList(),
                                        ),
                                      )
                                    else
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('No comments yet'),
                                      ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                  SizedBox(height: 20),
                  // Upload button
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 14),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UploadPostScreen(),
                            ));
                      },
                      child: Text(
                        "UPLOAD YOUR POST",
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColors.backgroundColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        minimumSize: Size(double.infinity, 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 120,
                  ),
                ],
              ),
            ),
            // Floating button for menu
            FloatingCircularMenu(),
          ],
        ),
      ),
    );
  }
}

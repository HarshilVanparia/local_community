import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:local_community/Module/profiledetailmodel.dart';

Future<User> fetchUserProfile(String userId) async {
  final response = await http.get(Uri.parse('http://192.168.171.174:3000/users/$userId'));

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load user profile');
  }
}

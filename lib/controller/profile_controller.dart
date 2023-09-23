import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/user_model.dart';
import '../constants/keys.dart';
import '../services/helper/shared_pref.dart';
import '../services/helper/token_helper.dart';

Future<File?> pickImageFile() async {
  final ImagePicker picker = ImagePicker();
  XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
  if (pickedImage == null) {
    return null;
  }
  File imageFile = File(pickedImage.path);
  return imageFile;
}

Future<void> uploadProfilePic(File imageFail, String givenName) async {
  String? token = await getToken();
  var request =
  http.MultipartRequest("POST", Uri.parse('$baseUrl/user/update'));
  var pic = await http.MultipartFile.fromPath('image', imageFail.path);
  request.fields["name"] = givenName;
  request.fields['title'] = 'image_${DateTime.now()}';
  request.files.add(pic);
  request.headers
      .addAll({'Accept': 'application/json', 'Authorization': 'Bearer $token'});
  var response = await request.send();
  var responseData = await response.stream.toBytes();
  var responseString = String.fromCharCodes(responseData);

  debugPrint(responseString);
}

Future<void> updateName(String givenName) async {
  String? token = await getToken();
  var request =
  http.MultipartRequest("POST", Uri.parse('$baseUrl/user/update'));
  request.fields["name"] = givenName;
  request.fields['title'] = 'image_${DateTime.now()}';
  request.headers
      .addAll({'Accept': 'application/json', 'Authorization': 'Bearer $token'});
  var response = await request.send();
  var responseData = await response.stream.toBytes();
  var responseString = String.fromCharCodes(responseData);

  debugPrint(responseString);
}

Future<String?> getNewProfilePic() async {
  final token = await getToken();
  final response = await http.get(Uri.parse('$baseUrl/user'), headers: {
    'Accept': 'application/json',
    'Authorization': 'Bearer $token'
  });
  final data = json.decode(response.body);
  return data['user']['image'];
}

Future<void> updateSharedPreferences(
    String newName, String newImagePath) async {
  SharedPrefsController prefs = SharedPrefsController();
  final userData = await prefs.getData('user');
  if (userData != null) {
    UserModel user = UserModel.fromJson(json.decode(userData));
    final newUser = user.copyWith(
      user: user.user.copyWith(
        name: newName,
        image: newImagePath,
      ),
    );
    prefs.deleteData('user');
    prefs.setData('user', userToJson(newUser));
  }
}

Future<void> updateNameSharedPreferences(String newName) async {
  SharedPrefsController prefs = SharedPrefsController();
  final userData = await prefs.getData('user');
  if (userData != null) {
    UserModel user = UserModel.fromJson(json.decode(userData));
    final newUser = user.copyWith(
      user: user.user.copyWith(
        name: newName,
      ),
    );
    prefs.deleteData('user');
    prefs.setData('user', userToJson(newUser));
  }
}

Future<void> updateRoleSharedPreferences(Role? newRole) async {
  SharedPrefsController prefs = SharedPrefsController();
  final userData = await prefs.getData('user');
  if (userData != null) {
    UserModel user = UserModel.fromJson(json.decode(userData));
    final newUser = user.copyWith(
      user: user.user.copyWith(role: newRole),
    );
    prefs.deleteData('user');
    prefs.setData('user', userToJson(newUser));
  }
}
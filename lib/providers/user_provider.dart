import 'package:flutter/material.dart';
import '../controller/user_controller.dart';
import '../models/user_model.dart';
import '../services/helper/api_response.dart';

class UserProvider extends ChangeNotifier {
  late UserController _userController;
  late ApiResponse<UserModel> _data;

  UserProvider() {
    _userController = UserController();
    getUserData();
  }
  ApiResponse<UserModel> get data => _data;
  void updatuser() {
    getUserData();
  }

  Future<void> getUserData() async {
    _data = ApiResponse.loading('Loading');

    notifyListeners();
    try {
      final response = await _userController.getLocalUser();

      _data = ApiResponse.completed(response);

      notifyListeners();
    } catch (e) {
      _data = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}
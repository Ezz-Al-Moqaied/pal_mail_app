import 'package:flutter/cupertino.dart';
import '../controller/users_controller.dart';
import '../models/all_user_model.dart';
import '../services/helper/api_response.dart';


class AllUserProvider extends ChangeNotifier {
  late AllUserController _allUserController;
  late ApiResponse<AllUserModel> _dataUser;

  AllUserProvider() {
    _allUserController = AllUserController();
    getusersData();
  }
  void UpdateAllUserProvider() {
    getusersData();
  }

  ApiResponse<AllUserModel> get allUserdata => _dataUser;
  Future<void> getusersData() async {
    _dataUser = ApiResponse.loading('Loading');
    notifyListeners();
    try {
      final response = await _allUserController.fetchUsersData();
      _dataUser = ApiResponse.completed(response);
      notifyListeners();
    } catch (e) {
      _dataUser = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}
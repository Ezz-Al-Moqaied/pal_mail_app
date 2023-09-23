import '../models/all_user_model.dart';
import '../services/helper/api_base_helper.dart';

class AllUserController {
  Future<AllUserModel> fetchUsersData() async {
    final ApiBaseHelper _helper = ApiBaseHelper();
    final token = '';
    final response =
    await _helper.get("/users", {'Authorization': 'Bearer $token'});
    return AllUserModel.fromJson(response[1]);
  }
//
// Future<int>? deleteSender(int id) async {
//   final ApiBaseHelper _helper = ApiBaseHelper();
//   final token = await getToken();
//   final response = await _helper.delete("/senders/$id", id, {'Authorization': 'Bearer $token'});
//   return (response[0]);
}

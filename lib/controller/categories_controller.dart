import 'package:pal_mail_app/constants/keys.dart';
import 'package:pal_mail_app/services/helper/api_base_helper.dart';
import 'package:pal_mail_app/services/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/categories_model.dart';

class CategoriesHelper {
  CategoriesHelper._();

  static final CategoriesHelper instance = CategoriesHelper._();

  Future<CategoriesModel> getCategories() async {
    ApiBaseHelper _helper = ApiBaseHelper();
    final response = _helper.get(Keys.categoriesUrl,
        {'Authorization': 'Bearer ${SharedPreferencesHelper.user.token}'});
    Map<String, dynamic>? data;
    await response.then((value) {
      data = value;
    });

    return CategoriesModel.fromJson(data!);
  }
}
import 'package:pal_mail_app/constants/keys.dart';
import 'package:pal_mail_app/models/category_model.dart';
import 'package:pal_mail_app/models/mails_model.dart';
import 'package:pal_mail_app/models/status_model.dart';
import 'package:pal_mail_app/models/tage_model.dart';
import 'package:pal_mail_app/services/helper/api_base_helper.dart';
import 'package:pal_mail_app/services/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomeHelper {
  HomeHelper._();

  static final HomeHelper instance = HomeHelper._();

  Future<MailsModel> getMails() async {
    ApiBaseHelper helper = ApiBaseHelper();
    final response = helper.get(Keys.mailsUrl,
        {'Authorization': 'Bearer ${SharedPreferencesHelper.user.token}'});
    Map<String, dynamic>? data;
    await response.then((value) {
      data = value;
    });
    return MailsModel.fromJson(data!);
  }

  Future<CategoryModel> getCategory() async {
    final response = await http.get(Uri.parse(Keys.categoriesUrl), headers: {
      'Authorization': 'Bearer ${SharedPreferencesHelper.user.token}'
    });
    if (response.statusCode == 200) {
      return categoryModelFromJson(response.body);
    }
    return Future.error('an error occurred');
  }

  Future<StatusModel> getStatusMails() async {
    final response = await http.get(Uri.parse(Keys.statusUrl), headers: {
      'Authorization': 'Bearer ${SharedPreferencesHelper.user.token}'
    });
    if (response.statusCode == 200) {
      return statusModelFromJson(response.body);
    }
    return Future.error('an error occurred');
  }

  Future<MailsModel> searchMails(String text) async {
    ApiBaseHelper helper = ApiBaseHelper();
    final response = helper.get('${Keys.mailsUrl}?text=$text',
        {'Authorization': 'Bearer ${SharedPreferencesHelper.user.token}'});
    Map<String, dynamic>? data;
    await response.then((value) {
      data = value;
    });
    print('${Keys.mailsUrl}?text=$text');
    return MailsModel.fromJson(data!);
  }

  Future<CategoryModel> getSingleCategory(int id) async {
    try {
      final response = await http.get(Uri.parse('${Keys.categoriesUrl}/$id'),
          headers: {
            'Authorization': 'Bearer ${SharedPreferencesHelper.user.token}'
          });
      return categoryModelFromJson(response.body);
    } catch (e) {
      flutterToastWidget(msg: "error", colors: Colors.redAccent);
      return CategoryModel();
    }
  }

  Future<TagsModel> getTage() async {
    ApiBaseHelper helper = ApiBaseHelper();
    final response = helper.get(Keys.tagsUrl,
        {'Authorization': 'Bearer ${SharedPreferencesHelper.user.token}'});
    Map<String, dynamic>? data;
    await response.then((value) {
      data = value;
    });
    return TagsModel.fromJson(data!);
  }
}

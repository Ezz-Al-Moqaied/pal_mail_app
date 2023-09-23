import 'package:pal_mail_app/services/shared_preferences.dart';

class Keys {
  Keys._();
  static final Keys instance = Keys._();

  final Map<String, String> header = {
    'Authorization': 'Bearer ${SharedPreferencesHelper.user.token}',
    'Accept': 'application/json'
  };
  //------------------------URLs------------------------
  static const double screenWidth = 428;
  static const double screenHeight = 926;
  static const baseUrl = 'https://palmail.gsgtt.tech/api';
  static const loginUrl = '$baseUrl/login';
  static const registerUrl = '$baseUrl/register';
  static const mailsUrl = '$baseUrl/mails';
  static const sendersUrl = '$baseUrl/senders';
  static const userUrl = '$baseUrl/user';
  static const categoriesUrl = '$baseUrl/categories';
  static const tagsUrl = '$baseUrl/tags';
  static const statusUrl = '$baseUrl/statuses';
  static const attachmentUrl = '$baseUrl/attachments';
}


const String baseUrl = 'https://palmail.gsgtt.tech/api';
const categoUrl = '$baseUrl/categories';
const allMailsUrl = '$baseUrl/mails';
const allTagsUrl = '$baseUrl/tags';
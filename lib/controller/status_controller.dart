import 'package:pal_mail_app/constants/keys.dart';
import 'package:pal_mail_app/services/helper/api_base_helper.dart';
import '../models/status_model.dart';

class StatusHelper {
  StatusHelper._();
  static final StatusHelper instance = StatusHelper._();
  final _helper = ApiBaseHelper();
  Future<StatusModel> getStatus() async {
    final response = await _helper.get(Keys.statusUrl, Keys.instance.header);
    return StatusModel.fromJson(response);
  }
}

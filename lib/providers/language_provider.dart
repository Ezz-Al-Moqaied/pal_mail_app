import 'package:flutter/material.dart';
import 'package:pal_mail_app/services/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  bool isEnglishLanguage = true;
  String languageKey = 'en';

  changeLanguage() {
    isEnglishLanguage = !isEnglishLanguage ;
    languageKey = isEnglishLanguage ? 'en' : 'ar' ;
    SharedPreferencesHelper.setLanguage(isEnglishLanguage ? 'en' : 'ar').then((value){
      languageKey = isEnglishLanguage ? 'en' : 'ar' ;
    });
    notifyListeners();
  }
}

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pal_mail_app/constants/keys.dart';
import 'package:pal_mail_app/providers/auth_provider.dart';
import 'package:pal_mail_app/providers/category_provider.dart';
import 'package:pal_mail_app/providers/details_mail_provider.dart';
import 'package:pal_mail_app/providers/home_provider.dart';
import 'package:pal_mail_app/providers/language_provider.dart';
import 'package:pal_mail_app/providers/new_inbox_provider.dart';
import 'package:pal_mail_app/providers/search_provider.dart';
import 'package:pal_mail_app/providers/status_provider.dart';
import 'package:pal_mail_app/providers/tags_provider.dart';
import 'package:pal_mail_app/screens/auth_screen.dart';
import 'package:pal_mail_app/screens/main_page.dart';
import 'package:pal_mail_app/screens/splash_screen.dart';
import 'package:pal_mail_app/services/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(Keys.screenWidth, Keys.screenHeight),
      builder: (context, child) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AuthProvider()),
          ChangeNotifierProvider(create: (context) => HomeProvider()),
          ChangeNotifierProvider(create: (context) => SearchProvider()),
          ChangeNotifierProvider(create: (context) => DetailsMailProvider()),
          ChangeNotifierProvider(create: (context) => LanguageProvider()),
          ChangeNotifierProvider(
            create: (context) => NewInboxProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => TagsProvider(),
          ),
          ChangeNotifierProvider(create: (context) => CategoryProvider()),
          ChangeNotifierProvider(create: (context) => StatusProvider())
        ],
        builder: (context, child) {
          return MaterialApp(
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en'), // English
                Locale('ar'), // Arabic
              ],
              locale: Locale(context.watch<LanguageProvider>().languageKey),
              debugShowCheckedModeBanner: false,
              home: AnimatedSplashScreen(
                  duration: 4000,
                  splashIconSize: double.infinity,
                  splash: const SplashScreen(),
                  nextScreen: SharedPreferencesHelper.isLogged
                      ? const MainPage()
                      : const AuthScreen(),
                  splashTransition: SplashTransition.fadeTransition));
        },
      ),
    );
  }
}

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pal_mail_app/constants/keys.dart';
import 'package:pal_mail_app/providers/auth_provider.dart';
import 'package:pal_mail_app/screens/auth_screen.dart';
import 'package:pal_mail_app/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(Keys.screenWidth, Keys.screenHeight),
      builder: (context, child) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AuthProvider()),
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
                Locale('ar'), // Spanish
              ],
              locale: const Locale('en'),
              debugShowCheckedModeBanner: false,
              home: AnimatedSplashScreen(
                  duration: 3000,
                  splashIconSize: double.infinity,
                  splash: const SplashScreen(),
                  nextScreen: const AuthScreen(),
                  splashTransition: SplashTransition.fadeTransition));
        },
      ),
    );
  }
}

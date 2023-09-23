import 'package:flutter/material.dart';
import 'drawer_screen.dart';
import 'home_screen.dart';


class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: Stack(
          children: [
            DrawerScreen(),
            HomeScreen(),
      ]),
    );
  }
}
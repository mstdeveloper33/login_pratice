import 'package:flutter/material.dart';
import 'package:login_pratice/home/home_page.dart';

import 'package:login_pratice/login/login_screen.dart';
import 'package:login_pratice/provider/token_provider.dart';
import 'package:login_pratice/splash_screen/splash_screen_page.dart';
import 'package:provider/provider.dart';

void main() => runApp(ChangeNotifierProvider(
      create: (context) => TokenProvider(),
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: SplashScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeView(),
      },
    );
  }
}

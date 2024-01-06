
import 'package:covid19_app/constants/constants.dart';
import 'package:covid19_app/screens/home_screen.dart';
import 'package:covid19_app/screens/login/signin_screen.dart';
import 'package:covid19_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: orangeColor),
        useMaterial3: true,
      ),
      home: SignInScreen(),
    );
  }
}


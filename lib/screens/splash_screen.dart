import 'dart:async';
import 'package:covid19_app/screens/home_screen.dart';
import 'package:covid19_app/screens/login/signin_screen.dart';
import 'package:covid19_app/screens/world_states_screen.dart';
import 'package:covid19_app/widgets/custom_animation_icon.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  late AnimationController animationController = AnimationController(
    duration: Duration(seconds: 10),
    vsync: this
  )..repeat();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      Timer(const Duration(seconds: 2),(){
        animationController.stop();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInScreen(),));
      });
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomAnimatedIcon(animationController: animationController),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08,),
            Text(
              'Covid-19\nTracker App',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            )
          ],
        ),
      ),
    );
  }
}

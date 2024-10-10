import 'dart:async';

import 'package:calcu/basicScreen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home_screen/home_Screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextPage();
  }

  Future<void> _navigateToNextPage() async {
    // Simulate some initialization process like loading resources
    await Future.delayed(Duration(seconds: 2));

    // Retrieve the login status from SharedPreferences or any other persistence storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

   // Redirect to the appropriate page based on login status and user type
    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }else{
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
   }
  }
    @override
    Widget build(BuildContext context) {
      return Scaffold(

        backgroundColor:Color(0xff061414),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Your logo or branding here
              // Image.asset(
              //   'assets/images/logo.png', // Replace with your logo
              //   height: 100,
              // ),
              Container(
                height: 200,
                width: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color:   Colors.greenAccent,
                  borderRadius: BorderRadius.circular(100),
                ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/icon.jpeg",width: 100, height: 100,scale: 10,),
                      Text("CalcES",style: TextStyle(color: Colors.white,fontSize: 40, fontWeight: FontWeight.w600),),
                    ],
                  )), // Optional: You can add a loading indicator
            ],
          ),
        ),
      );
    }
  }


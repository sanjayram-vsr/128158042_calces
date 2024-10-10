import 'dart:math';

import 'package:calcu/home_screen/home_Screen.dart';
import 'package:calcu/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = '';

  // Static username and password
  final String correctUsername = 'admin';
  final String correctPassword = 'admin@123';

  // Random gradient color
  LinearGradient getGradient() {
    final random = Random();
    final colors = [
      Color(0xff061414),

      Colors.greenAccent,

    ];

    return LinearGradient(
      colors: [
        colors.first,
        colors.last,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _login() async{

      String username = _usernameController.text;
      String password = _passwordController.text;

      if (username == correctUsername && password == correctPassword) {
        _errorMessage = '';
        // Navigate to the Home Page
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        setState(() {
        _errorMessage = 'Incorrect username or password';
        });
      }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: getGradient(), // Apply random gradient
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Login',
                  style: TextStyle(fontSize: 32, color: Colors.white),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),

                  child: TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Color(0xff061414)),
                      border: null,
                      labelText: 'Username',

                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),

                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Color(0xff061414)),
                      border: null,
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _login,
                  child: Text('Login'),
                ),
                SizedBox(height: 20),
                Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.white,),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
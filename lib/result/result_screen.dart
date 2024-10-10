import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final double result;

  ResultScreen({required this.result});
  // Random gradient color
  LinearGradient getGradient() {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          'Result',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xff061414),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(gradient: getGradient()),
        child: Center(
          child: Text(
            'Result: $result',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

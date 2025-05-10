import 'package:flutter/material.dart';
// import 'package:ibundiksha/main.dart';
import 'package:ibundiksha/screen/home_screen.dart';
import 'package:ibundiksha/screen/login_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      // home: HomeScreen(),
    );
  }
}


class MenuUtama extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Ini Halaman Menu Utama")),
    );
  }
}

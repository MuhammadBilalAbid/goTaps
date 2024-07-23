import 'package:flutter/material.dart';
import 'package:gotaps/view/auth/signin.dart';
import 'package:gotaps/view/bottomnavigationbar.dart';
import 'dart:async';

import 'package:gotaps/model/userdetails_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    initializeApp();
  }

  Future<void> initializeApp() async {
    try {
      await Future.delayed(Duration(seconds: 3));

      User? user = await User.loadUser();
      //log(user!.token);
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NavBar()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignIn()),
        );
      }
    } catch (e) {
      print('Failed to initialize app: $e');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignIn()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/gotaps_logo_landscape 1.png',
              height: 150,
              width: 100,
            ),
            SizedBox(height: 20),
            _isLoading ? CircularProgressIndicator() : Container(),
          ],
        ),
      ),
    );
  }
}

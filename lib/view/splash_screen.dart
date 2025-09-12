import 'package:flutter/material.dart';
import 'package:login_page/preferences_helper.dart';
import 'package:login_page/view/bottom_bar_page.dart';
import 'package:login_page/view/login_page.dart';
import 'package:login_page/view/sign_up_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _choosePage();
  }

  Future<void> _choosePage() async {
    await Future.delayed(Duration(seconds: 2));
    final token = await PreferencesHelper.getLogin();
    if (token == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignUpPage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomBarPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

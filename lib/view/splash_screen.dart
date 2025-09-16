import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        MaterialPageRoute(builder: (context) => LoginPage()),
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
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: Center(
        child: SvgPicture.asset(
          'assets/images/splash_screen.svg',
          height: 60.h,
          width: 210.w,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}

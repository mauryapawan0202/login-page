import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page/constants/color.dart';
import 'package:login_page/preferences_helper.dart';
import 'package:login_page/widgets/common_snackbar.dart';

import '../login_page.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: primary),
      body: Center(child: Icon(Icons.person, color: Colors.black, size: 100)),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primary,
        onPressed: () async {
          try {
            await PreferencesHelper.removeLogin();
            await FirebaseAuth.instance.signOut();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Logout SuccessFully'),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 1),
              ),
            );
            await Future.delayed(const Duration(seconds: 1));
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          } catch (e) {
            CommonSnackBar.show(
              context,
              text: "Error: $e",
              backGroundColor: Colors.red,
              durationSeconds: 1,
            );
          }
        },
        child: Icon(Icons.login_outlined, color: Color(0xffFFFFFF)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

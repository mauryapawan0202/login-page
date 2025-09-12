import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_page/preferences_helper.dart';
import 'package:login_page/view/bottom_bar_page.dart';
import 'package:login_page/widgets/common_snackbar.dart';

final loginPageController = ChangeNotifierProvider(
  (ref) => LoginPageController(),
);

class LoginPageController extends ChangeNotifier {
  final accountController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final _storage = const FlutterSecureStorage();

  bool _isVisiblePassword = true;
  bool get isVisiblePassword => _isVisiblePassword;

  void passwordShow() {
    _isVisiblePassword = !_isVisiblePassword;
    notifyListeners();
  }

  void textFieldClear() {
    accountController.clear();
    passwordController.clear();
    notifyListeners();
  }

  bool _isEnabled = false;
  bool get isEnabled => _isEnabled;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void checkIsEnabled() {
    _isEnabled =
        accountController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        passwordController.text.length >= 8;
    notifyListeners();
  }

  ///<==================== Login Method =====================>///

  Future<void> login(BuildContext context) async {
    final name = accountController.text;
    final password = passwordController.text;
    notifyListeners();
    if (name.isNotEmpty && password.isNotEmpty) {
      if (RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(name)) {
        if (password.length > 7) {
          _isLoading = true;
          notifyListeners();
          try {
            await _auth
                .signInWithEmailAndPassword(email: name, password: password)
                .then((value) {
                  log('dkndkln$value');
                  if (!context.mounted) return;
                  CommonSnackBar.show(
                    context,
                    text: "Login SuccessFully",
                    backGroundColor: Colors.green,
                    durationSeconds: 1,
                  );
                  accountController.clear();
                  passwordController.clear();
                  checkIsEnabled();
                  notifyListeners();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => BottomBarPage()),
                  );
                });
            await PreferencesHelper.setLogin('userLogin');
          }on FirebaseAuthException catch (e) {
            log('hjgh : ${e.code}');
            String message = '';
            switch (e.code) {
              case 'invalid-credential':
                message = "Invalid email or password.";
                break;
              case 'user-not-found':
                message = "No user found for this email.";
                break;
              case 'wrong-password':
                message = "Incorrect password. Please try again.";
                break;
              case 'invalid-email':
                message = "Email address is not valid.";
                break;
              default:
                message = "Something went wrong. Please try again.";
            }
            if (!context.mounted) return;
            CommonSnackBar.show(
              context,
              text: message,
              backGroundColor: Colors.red,
              durationSeconds: 2,
            );} catch (e) {
            log('askjcbskjc${e.toString()}');
            if (!context.mounted) return;
            CommonSnackBar.show(
              context,
              text: "Error: ${e.toString()}",
              backGroundColor: Colors.red,
              durationSeconds: 1,
            );
          }
        } else {
          CommonSnackBar.show(
            context,
            text: 'minimum password required 8 characters',
            backGroundColor: Colors.red,
            durationSeconds: 1,
          );
        }
      } else {
        CommonSnackBar.show(
          context,
          text: 'Invalid Email',
          backGroundColor: Colors.red,
          durationSeconds: 1,
        );
      }
    } else {
      CommonSnackBar.show(
        context,
        text: 'please fill the blanks',
        backGroundColor: Colors.red,
        durationSeconds: 1,
      );
    }
    _isLoading = false;
    notifyListeners();
  }
}
// Future<void> submit(BuildContext context) async {
//   final account = accountController.text;
//   final password = passwordController.text;
//   String email = "pawanmaurya@gmail.com";
//   String passwordData = '12345678';
//   if (account.isNotEmpty && password.isNotEmpty) {
//     if (account == email) {
//       if (password == passwordData) {
//         // await _storage.write(key: "login_key", value: 'user1234');
//         await PreferencesHelper.setLogin('userLogin');
//         _isLoading = true;
//         notifyListeners();
//         await Future.delayed(Duration(seconds: 2));
//         CommonSnackBar.show(
//           context,
//           text: 'Login SuccessFully',
//           backGroundColor: Colors.green,
//           durationSeconds: 1,
//         );
//         accountController.clear();
//         passwordController.clear();
//         checkIsEnabled();
//         notifyListeners();
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => BottomBarPage()),
//         );
//       } else {
//         CommonSnackBar.show(
//           context,
//           text: 'password is incorrect',
//           backGroundColor: Colors.red,
//           durationSeconds: 1,
//         );
//       }
//     } else {
//       CommonSnackBar.show(
//         context,
//         text: 'email or phone is incorrect',
//         backGroundColor: Colors.red,
//         durationSeconds: 1,
//       );
//     }
//   } else {
//     CommonSnackBar.show(
//       context,
//       text: 'please fill the blanks',
//       backGroundColor: Colors.red,
//       durationSeconds: 1,
//     );
//   }
//   _isLoading = false;
//   notifyListeners();
// }

// Future<String?> getToken()async{
//   return await _storage.read(key: "login_key");
// }
// }

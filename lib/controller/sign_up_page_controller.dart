
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_page/view/login_page.dart';
import 'package:login_page/widgets/common_snackbar.dart';

final signUpPageController = ChangeNotifierProvider(
  (ref) => SignUpPageController(),
);

class SignUpPageController extends ChangeNotifier {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isEnabled = false;
  bool get isEnabled => _isEnabled;

  void checkIsEnabled() {
    _isEnabled =
        nameController.text.isNotEmpty && passwordController.text.isNotEmpty;
    notifyListeners();
  }

  bool _isVisiblePassword = true;
  bool get isVisiblePassword => _isVisiblePassword;

  void textFieldClear() {
    nameController.clear();
    passwordController.clear();
    notifyListeners();
  }

  void passwordShow() {
    _isVisiblePassword = !_isVisiblePassword;
    notifyListeners();
  }

  bool _isSignUpLoading = false;
  bool get isLoading => _isSignUpLoading;

  ///<=================== Register Method ==================>///

  Future<void> register(BuildContext context) async {
    final name = nameController.text;
    final password = passwordController.text;
    notifyListeners();
    if (name.isNotEmpty && password.isNotEmpty) {
      if (RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(name)) {
        if (password.length > 7) {
          _isSignUpLoading = true;
          notifyListeners();
          try {
            await _auth
                .createUserWithEmailAndPassword(email: name, password: password)
                .then((value) {
              if (!context.mounted) return;
                  CommonSnackBar.show(
                    context,
                    text: "User Created SuccessFully",
                    backGroundColor: Colors.green,
                    durationSeconds: 1,
                  );
                  nameController.clear();
                  passwordController.clear();
                  checkIsEnabled();
                  notifyListeners();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                });
          } catch (e) {
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
    _isSignUpLoading = false;
    notifyListeners();
  }
}

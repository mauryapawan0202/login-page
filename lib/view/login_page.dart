import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_page/controller/login_page_controller.dart';
import 'package:login_page/preferences_helper.dart';
import 'package:login_page/view/sign_up_page.dart';
import 'package:login_page/widgets/common_textfield.dart';
import '../widgets/common_button_widget.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final loginCtrl = ref.watch(loginPageController);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              80.verticalSpace,
              Text(
                'Welcome back!',
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w800,
                  color: Color(0xffFFFFFF),
                ),
              ),
              Text(
                'Login to continue',
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffFFFFFF),
                ),
              ),
              30.verticalSpace,
              Text(
                'Account',
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  color: Colors.white,
                ),
              ),
              5.verticalSpace,
              CommonTextFormField(
                onChanged: (value) => loginCtrl.checkIsEnabled(),
                controller: loginCtrl.accountController,
                hintText: 'Enter email or phone',
              ),
              15.verticalSpace,
              Text(
                'Password',
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  color: Colors.white,
                ),
              ),
              5.verticalSpace,
              CommonTextFormField(
                onChanged: (value) => loginCtrl.checkIsEnabled(),
                controller: loginCtrl.passwordController,
                obscureText: loginCtrl.isVisiblePassword,
                hintText: 'Enter Password',
                suffixIcon: IconButton(
                  onPressed: () {
                    loginCtrl.passwordShow();
                  },
                  icon: Icon(
                    loginCtrl.isVisiblePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                ),
              ),
              13.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot Password?",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              13.verticalSpace,
              Opacity(
                opacity: loginCtrl.isEnabled ? 1.0 : 0.4,
                child: CommonButtonWidget(
                  isLoading: loginCtrl.isLoading,
                  buttonName: 'Get Started!',
                  onTapValue: loginCtrl.isEnabled
                      ? () async {
                          await loginCtrl.login(context);
                          final token = await PreferencesHelper.getLogin();
                          if (kDebugMode) {
                            print(token);
                          }
                        }
                      : null,
                ),
              ),
              115.verticalSpace,
              Align(
                alignment: AlignmentGeometry.center,
                child: Text(
                  'Or login with',
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                ),
              ),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.w,
                      vertical: 15.h,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xff1E1E1E),
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Row(
                      children: [
                        Image.asset("assets/images/googleicon.png"),
                        10.horizontalSpace,
                        Text(
                          'Google',
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  10.horizontalSpace,
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.w,
                      vertical: 15.h,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xff1E1E1E),
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Row(
                      children: [
                        Image.asset("assets/images/appleicon.png"),
                        10.horizontalSpace,
                        Text(
                          'Apple',
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              15.verticalSpace,
              Align(
                alignment: AlignmentGeometry.center,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.white70),
                    children: [
                      TextSpan(
                        text: "Don't have an account ",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                        ),
                      ),
                      TextSpan(
                        text: " Sign Up",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          color: Colors.blueAccent,
                          fontSize: 18.sp,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            loginCtrl.textFieldClear();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpPage(),
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

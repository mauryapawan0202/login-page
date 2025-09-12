import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_page/view/login_page.dart';
import 'package:login_page/widgets/common_button_widget.dart';
import '../controller/sign_up_page_controller.dart';
import '../widgets/common_textfield.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  TextEditingController emailTextEditingCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final signUpCtrl = ref.watch(signUpPageController);
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
                'Sign up',
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w700,
                  fontSize: 28.sp,
                  color: Colors.white,
                ),
              ),
              Text(
                'new account',
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w700,
                  fontSize: 28.sp,
                  color: Colors.white,
                ),
              ),
              30.verticalSpace,
              Text(
                'Email Id',
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  color: Colors.white,
                ),
              ),
              5.verticalSpace,
              CommonTextFormField(
                onChanged: (value) => signUpCtrl.checkIsEnabled(),
                controller: signUpCtrl.nameController,
                hintText: 'Example: user123@gmail.com',
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
                onChanged: (value) => signUpCtrl.checkIsEnabled(),
                controller: signUpCtrl.passwordController,
                obscureText: signUpCtrl.isVisiblePassword,
                suffixIcon: IconButton(
                  onPressed: () {
                    signUpCtrl.passwordShow();
                  },
                  icon: Icon(
                    signUpCtrl.isVisiblePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                ),
                hintText: 'Example: User@1234',
              ),
              25.verticalSpace,
              Opacity(
                opacity: signUpCtrl.isEnabled ? 1.0 : 0.5,
                child: CommonButtonWidget(
                  buttonName: 'Register',
                  isLoading: signUpCtrl.isLoading,
                  onTapValue: signUpCtrl.isEnabled
                      ? () async {
                          await signUpCtrl.register(context);
                        }
                      : null,
                ),
              ),
              110.verticalSpace,
              Align(
                alignment: AlignmentGeometry.center,
                child: Text(
                  'Or sign up with',
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                ),
              ),
              24.verticalSpace,
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
              20.verticalSpace,
              Align(
                alignment: AlignmentGeometry.center,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.white70),
                    children: [
                      TextSpan(
                        text: "You had an account ",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                        ),
                      ),
                      TextSpan(
                        text: " Login now",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          color: Colors.blueAccent,
                          fontSize: 18.sp,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            signUpCtrl.textFieldClear();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
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

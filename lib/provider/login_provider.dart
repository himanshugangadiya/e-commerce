import 'package:e_commerce_app/screen/authentication/intro_screen.dart';
import 'package:e_commerce_app/screen/authentication/log_in_screen.dart';
import 'package:e_commerce_app/screen/main_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/app_color.dart';
import '../widget/toast_widget.dart';

class LoginProvider extends ChangeNotifier {
  String emailOnChangedValue = '';
  String passwordOnChangedValue = '';
  bool isRemember = false;

  rememberMe(bool value) {
    isRemember = value;
    notifyListeners();
  }

  passwordOnChanged(String val) {
    emailOnChangedValue = val;
    notifyListeners();
  }

  emailOnChanged(String val) {
    passwordOnChangedValue = val;
    notifyListeners();
    print("============== $passwordOnChangedValue");
  }

  loginUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        emailOnChangedValue = '';
        passwordOnChangedValue = '';
        showToast(
          color: AppColor.purple,
          msg: "You are successfully logged in",
        );
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MainScreen(),
            ),
            (route) => false);
      });
    } on FirebaseAuthException catch (error) {
      emailOnChangedValue = '';
      passwordOnChangedValue = '';
      showToast(color: AppColor.red, msg: error.toString());
    }
  }

  currentUser() {
    if (FirebaseAuth.instance.currentUser != null) {
      debugPrint(
          "============================= ${FirebaseAuth.instance.currentUser!.uid}");
      return true;
    } else {
      return false;
    }
  }

  loginStatus(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2),
      () => currentUser()
          ? Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => MainScreen(),
              ),
              (route) => false)
          : Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => IntroScreen(),
              ),
              (route) => false),
    );
  }

  /// sign out
  signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut().then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LogInScreen(),
          ),
          (route) => false);
    }).catchError((error) {
      showToast(color: AppColor.red, msg: error.toString());
    });
  }

  currentUserId() {
    if (FirebaseAuth.instance.currentUser != null) {
      return FirebaseAuth.instance.currentUser!.uid;
    }
  }

  currentUserEmail() {
    if (FirebaseAuth.instance.currentUser != null) {
      return FirebaseAuth.instance.currentUser!.email;
    }
  }
}

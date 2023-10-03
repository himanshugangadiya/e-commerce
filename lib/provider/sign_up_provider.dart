import 'package:e_commerce_app/utils/app_color.dart';
import 'package:e_commerce_app/widget/toast_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screen/main_screen.dart';

class SignUpProvider extends ChangeNotifier {
  bool isRemember = false;
  String emailOnChangedValue = '';
  String passwordOnChangedValue = '';
  String userNameOnChangedValue = '';

  rememberMe(bool value) {
    isRemember = value;
    notifyListeners();
  }

  passwordOnChanged(String val) {
    passwordOnChangedValue = val;
    notifyListeners();

    notifyListeners();
  }

  userNameOnChanged(String val) {
    userNameOnChangedValue = val;
    notifyListeners();
  }

  emailOnChanged(String val) {
    emailOnChangedValue = val;
    notifyListeners();
  }

  createUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        emailOnChangedValue = '';
        passwordOnChangedValue = '';
        userNameOnChangedValue = '';
        showToast(
          color: AppColor.purple,
          msg: "Your account has been successfully created.",
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
      userNameOnChangedValue = '';
      showToast(color: AppColor.red, msg: error.toString());
    }
  }
}

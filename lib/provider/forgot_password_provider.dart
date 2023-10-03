import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../utils/app_color.dart';
import '../widget/toast_widget.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  String emailOnChangedValue = '';

  emailOnChanged(String val) {
    emailOnChangedValue = val;
    notifyListeners();
  }

  forgotPassword({
    required BuildContext context,
    required String email,
  }) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(
        email: email,
      )
          .then((value) {
        emailOnChangedValue = '';

        showToast(
          color: AppColor.purple,
          msg: "Password reset email has been send to your email address.",
        );
        Future.delayed(
            const Duration(seconds: 3), () => Navigator.pop(context));
      });
    } on FirebaseAuthException catch (error) {
      emailOnChangedValue = '';
      showToast(color: AppColor.red, msg: error.toString());
    }
  }
}

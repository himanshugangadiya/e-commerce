import 'package:e_commerce_app/utils/app_color.dart';
import 'package:e_commerce_app/widget/toast_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ChangePasswordProvider extends ChangeNotifier {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  clearController() {
    newPasswordController.clear();
    confirmPasswordController.clear();
  }

  changePassword({
    required BuildContext context,
  }) async {
    if (newPasswordController.text.trim() ==
        confirmPasswordController.text.trim()) {
      if (FirebaseAuth.instance.currentUser != null) {
        await FirebaseAuth.instance.currentUser!
            .updatePassword(
          newPasswordController.text.toString(),
        )
            .then((value) {
          clearController();
          showToast(color: AppColor.green, msg: "Change password successfully");
          Navigator.pop(context);
        }).catchError((e) {
          showToast(color: AppColor.red, msg: e.toString());
        });
      }
    } else {
      showToast(
        color: AppColor.red,
        msg: "New password and confirm password does not match",
      );
    }
  }
}

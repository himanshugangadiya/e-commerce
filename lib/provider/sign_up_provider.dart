import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpProvider extends ChangeNotifier {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isRemember = false;

  rememberMe(bool value) {
    isRemember = value;
    notifyListeners();
  }

  passwordOnChanged(String val) {
    passwordController.text = val;
    notifyListeners();
    passwordController.selection = TextSelection.collapsed(
      offset: passwordController.text.length,
    );
    notifyListeners();
  }

  userNameOnChanged(String val) {
    userNameController.text = val;
    notifyListeners();
    userNameController.selection = TextSelection.collapsed(
      offset: userNameController.text.length,
    );
    notifyListeners();
  }

  emailOnChanged(String val) {
    emailController.text = val;
    notifyListeners();
    emailController.selection = TextSelection.collapsed(
      offset: emailController.text.length,
    );
    notifyListeners();
  }
}

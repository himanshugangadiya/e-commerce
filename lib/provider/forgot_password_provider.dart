import 'package:flutter/cupertino.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  emailOnChanged(String val) {
    emailController.text = val;
    notifyListeners();
    emailController.selection = TextSelection.collapsed(
      offset: emailController.text.length,
    );
    notifyListeners();
  }
}

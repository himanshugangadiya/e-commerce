import 'package:e_commerce_app/provider/forgot_password_provider.dart';
import 'package:e_commerce_app/provider/login_provider.dart';
import 'package:e_commerce_app/utils/app_color.dart';
import 'package:e_commerce_app/utils/app_image.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widget/common_back_button.dart';
import '../../widget/common_bottom_button.dart';
import '../../widget/toast_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    clearController();
  }

  clearController() {
    emailController.clear();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.04,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonBackButton(
                    onTap: () {
                      clearController();
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Forgot Password",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),

                  Image.asset(
                    AppImage.forgotPassword,
                    fit: BoxFit.cover,
                  ),

                  SizedBox(
                    height: height * 0.03,
                  ),

                  /// email
                  TextField(
                    controller: emailController,
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    cursorColor: AppColor.black,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "Email Address",
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text(
                    "Please write your email to receive a \nconfirmation code to set a new password.",
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColor.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: height * 0.06,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      ///
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Consumer<ForgotPasswordProvider>(
        builder: (context, value, child) => CommonBottomButton(
          onTap: () {
            forgotPassword();
          },
          title: 'Confirm Mail',
        ),
      ),
    );
  }

  forgotPassword() {
    if (emailController.text.isEmpty) {
      showToast(color: AppColor.red, msg: "Enter email address");
    } else if (!EmailValidator.validate(emailController.text)) {
      showToast(color: AppColor.red, msg: "Email not validate");
    } else {
      FocusScope.of(context).unfocus();
      Provider.of<ForgotPasswordProvider>(context, listen: false)
          .forgotPassword(
        context: context,
        email: emailController.text.trim().toString(),
      );
      clearController();
    }
  }
}

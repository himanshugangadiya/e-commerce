import 'package:e_commerce_app/provider/change_password_provider.dart';
import 'package:e_commerce_app/provider/sign_up_provider.dart';
import 'package:e_commerce_app/utils/app_color.dart';
import 'package:e_commerce_app/utils/height_width.dart';
import 'package:e_commerce_app/widget/common_bottom_button.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widget/common_back_button.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("change password screen build method run =================== ");
    return WillPopScope(
      onWillPop: () async {
        Provider.of<ChangePasswordProvider>(context, listen: false)
            .clearController();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: W(0.04),
                vertical: H(0.04),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonBackButton(
                    onTap: () {
                      Provider.of<ChangePasswordProvider>(context,
                              listen: false)
                          .clearController();

                      Navigator.pop(context);
                    },
                  ),
                  hSizedBox(0.03),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Change Password",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),

                  hSizedBox(0.1),
                  Consumer<ChangePasswordProvider>(
                    builder: (context, value, child) => TextFormField(
                      controller: value.newPasswordController,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                      validator: (text) {
                        if (text == null || text.toString().trim().isEmpty) {
                          return 'Enter your New password';
                        } else if (text.trim().length < 8) {
                          return "Your password is too weak!";
                        }
                        return null;
                      },
                      // onChanged: (val) => value.userNameOnChanged(val),
                      cursorColor: AppColor.black,
                      decoration: const InputDecoration(
                        labelText: "New password",
                      ),
                    ),
                  ),

                  hSizedBox(0.03),

                  /// password
                  Consumer<ChangePasswordProvider>(
                    builder: (context, value, child) => TextFormField(
                      controller: value.confirmPasswordController,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Enter your confirm password';
                        } else if (text.trim().length < 8) {
                          return "Your password is too weak!";
                        }
                        return null;
                      },
                      // onChanged: (val) => value.passwordOnChanged(val),
                      cursorColor: AppColor.black,
                      decoration: const InputDecoration(
                        labelText: "Confirm password",
                      ),
                    ),
                  ),

                  hSizedBox(0.03),
                ],
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: CommonBottomButton(
            onTap: () {
              if (formKey.currentState!.validate()) {
                FocusScope.of(context).unfocus();
                Provider.of<ChangePasswordProvider>(context, listen: false)
                    .changePassword(
                  context: context,
                );
              }
            },
            title: "Save",
          ),
        ),
      ),
    );
  }
}

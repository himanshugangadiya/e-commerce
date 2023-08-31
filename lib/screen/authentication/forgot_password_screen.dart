import 'package:e_commerce_app/provider/forgot_password_provider.dart';
import 'package:e_commerce_app/provider/login_provider.dart';
import 'package:e_commerce_app/utils/app_color.dart';
import 'package:e_commerce_app/utils/app_image.dart';
import 'package:e_commerce_app/utils/height_width.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widget/common_back_button.dart';
import '../../widget/common_bottom_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    context.watch<ForgotPasswordProvider>().emailController.clear();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("forgot password screen build method run =================== ");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: Provider.of<ForgotPasswordProvider>(context, listen: false)
              .formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: W(0.04),
              vertical: H(0.04),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonBackButton(
                      onTap: () {},
                    ),
                    hSizedBox(0.03),
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

                    hSizedBox(0.03),

                    /// email
                    Consumer<ForgotPasswordProvider>(
                      builder: (context, value, child) => TextFormField(
                        controller: value.emailController,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                        validator: (text) {
                          if (!EmailValidator.validate(text!)) {
                            return "Enter valid email";
                          }
                          return null;
                        },
                        onChanged: (val) => value.emailOnChanged(val),
                        cursorColor: AppColor.black,
                        decoration: InputDecoration(
                          labelText: "Email Address",
                          suffixIcon: EmailValidator.validate(
                                  value.emailController.text)
                              ? const Icon(Icons.done, size: 20)
                              : const SizedBox(),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Please write your email to receive a \nconfirmation code to set a new password.",
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColor.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

      ///
      bottomNavigationBar: Consumer<ForgotPasswordProvider>(
        builder: (context, value, child) => CommonBottomButton(
          onTap: () {
            if (value.formKey.currentState!.validate()) {
              FocusScope.of(context).unfocus();
            } else {
              FocusScope.of(context).unfocus();
            }
          },
          title: 'Confirm Mail',
        ),
      ),
    );
  }
}

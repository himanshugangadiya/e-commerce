import 'package:e_commerce_app/provider/login_provider.dart';
import 'package:e_commerce_app/utils/app_color.dart';
import 'package:e_commerce_app/utils/app_route.dart';
import 'package:e_commerce_app/utils/height_width.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../widget/common_back_button.dart';
import '../../widget/common_bottom_button.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    context.watch<LoginProvider>().emailController.clear();
    context.watch<LoginProvider>().passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("log in screen build method run =================== ");
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: Provider.of<LoginProvider>(context, listen: false).formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: W(0.04),
              vertical: H(0.04),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonBackButton(
                    onTap: () {
                      context.pop();
                    },
                  ),
                  hSizedBox(0.03),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Welcome",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  hSizedBox(0.005),

                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Please enter your data to continue",
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColor.grey,
                      ),
                    ),
                  ),
                  hSizedBox(0.1),

                  /// email
                  Consumer<LoginProvider>(
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
                        suffixIcon:
                            EmailValidator.validate(value.emailController.text)
                                ? const Icon(Icons.done, size: 20)
                                : const SizedBox(),
                      ),
                    ),
                  ),

                  hSizedBox(0.03),

                  /// password
                  Consumer<LoginProvider>(
                    builder: (context, value, child) => TextFormField(
                      controller: value.passwordController,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Enter your password';
                        } else if (text.trim().length <= 8) {
                          return "Your password is too weak!";
                        }
                        return null;
                      },
                      onChanged: (val) => value.passwordOnChanged(val),
                      cursorColor: AppColor.black,
                      decoration: const InputDecoration(
                        labelText: "Password",
                      ),
                    ),
                  ),

                  hSizedBox(0.025),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.push(AppPages.forgotPasswordScreen);
                        },
                        child: Text(
                          "Forgot password?",
                          style: TextStyle(
                            color: AppColor.red,
                            fontSize: 15.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  hSizedBox(0.02),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Remember me",
                        style: TextStyle(fontSize: 15),
                      ),
                      Consumer<LoginProvider>(
                        builder: (context, value, child) => Transform.scale(
                          scale: 0.8,
                          child: CupertinoSwitch(
                            value: value.isRemember,
                            onChanged: (val) => value.rememberMe(val),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        /// e
        bottomNavigationBar: Consumer<LoginProvider>(
          builder: (context, value, child) => CommonBottomButton(
            onTap: () {
              if (value.formKey.currentState!.validate()) {
                FocusScope.of(context).unfocus();
                context.go(AppPages.mainScreen);
              } else {
                FocusScope.of(context).unfocus();
              }
            },
            title: 'Login',
          ),
        ),
      ),
    );
  }
}

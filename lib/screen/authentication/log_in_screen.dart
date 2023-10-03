import 'package:e_commerce_app/provider/login_provider.dart';
import 'package:e_commerce_app/provider/sign_up_provider.dart';
import 'package:e_commerce_app/screen/authentication/forgot_password_screen.dart';
import 'package:e_commerce_app/screen/authentication/sign_up_screen.dart';
import 'package:e_commerce_app/utils/app_color.dart';
import 'package:e_commerce_app/utils/height_width.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widget/common_back_button.dart';
import '../../widget/common_bottom_button.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    clearController();
  }

  clearController() {
    emailController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("log in screen build method run =================== ");
    return SafeArea(
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
                    clearController();
                    Navigator.pop(context);
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

                const Align(
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
                    controller: emailController,
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
                          EmailValidator.validate(value.emailOnChangedValue)
                              ? const Icon(Icons.done, size: 20)
                              : const SizedBox(),
                    ),
                  ),
                ),

                hSizedBox(0.03),

                /// password
                Consumer<LoginProvider>(
                  builder: (context, value, child) => TextFormField(
                    controller: passwordController,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Enter your password';
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
                        clearController();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPasswordScreen(),
                            ));
                      },
                      child: const Text(
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
                    const Text(
                      "Remember me",
                      style: TextStyle(fontSize: 15),
                    ),
                    Consumer<LoginProvider>(
                      builder: (context, value, child) => Transform.scale(
                        scale: 0.8,
                        child: CupertinoSwitch(
                          value: value.isRemember,
                          onChanged: (bool val) {
                            value.rememberMe(val);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColor.grey,
                          ),
                    ),
                    hSizedBox(0.01),
                    GestureDetector(
                      onTap: () {
                        clearController();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpScreen(),
                            ));
                      },
                      child: const Text(
                        "SignUp",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                hSizedBox(0.06),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Consumer<LoginProvider>(
          builder: (context, value, child) => CommonBottomButton(
            onTap: () {
              if (formKey.currentState!.validate()) {
                FocusScope.of(context).unfocus();
                Provider.of<LoginProvider>(context, listen: false).loginUser(
                  email: emailController.text.trim().toString(),
                  password: passwordController.text.trim().toString(),
                  context: context,
                );
                clearController();
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

import 'package:e_commerce_app/provider/sign_up_provider.dart';
import 'package:e_commerce_app/utils/app_color.dart';
import 'package:e_commerce_app/utils/height_width.dart';
import 'package:e_commerce_app/widget/common_bottom_button.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widget/common_back_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    clearController();
  }

  clearController() {
    emailController.clear();
    passwordController.clear();
    userNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("sign up screen build method run =================== ");
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
                    "Sign Up",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),

                hSizedBox(0.1),
                Consumer<SignUpProvider>(
                  builder: (context, value, child) => TextFormField(
                    controller: userNameController,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                    validator: (text) {
                      if (text == null || text.toString().trim().isEmpty) {
                        return 'Enter your username';
                      }
                      return null;
                    },
                    onChanged: (val) => value.userNameOnChanged(val),
                    cursorColor: AppColor.black,
                    decoration: InputDecoration(
                      labelText: "Username",
                      suffixIcon: userNameController.text.trim() != ""
                          ? const Icon(Icons.done, size: 20)
                          : const SizedBox(),
                    ),
                  ),
                ),

                hSizedBox(0.03),

                /// password
                Consumer<SignUpProvider>(
                  builder: (context, value, child) => TextFormField(
                    controller: passwordController,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Enter your password';
                      } else if (text.trim().length < 8) {
                        return "Your password is too weak!";
                      }
                      return null;
                    },
                    onChanged: (val) => value.passwordOnChanged(val),
                    cursorColor: AppColor.black,
                    decoration: InputDecoration(
                      labelText: "Password",
                      suffixIcon: passwordController.text.trim().length >= 8
                          ? const Text(
                              "Strong",
                              style: TextStyle(
                                color: AppColor.green,
                                fontSize: 14,
                              ),
                            )
                          : const SizedBox(),
                    ),
                  ),
                ),

                hSizedBox(0.03),

                /// email
                Consumer<SignUpProvider>(
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
                      suffixIcon: EmailValidator.validate(emailController.text)
                          ? const Icon(Icons.done, size: 20)
                          : const SizedBox(),
                    ),
                  ),
                ),

                hSizedBox(0.03),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Remember me",
                      style: TextStyle(fontSize: 15),
                    ),
                    Consumer<SignUpProvider>(
                      builder: (context, value, child) => Transform.scale(
                        scale: 0.8,
                        child: CupertinoSwitch(
                          value: value.isRemember,
                          onChanged: (val) {
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
                      "Already have an account?",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColor.grey,
                          ),
                    ),
                    hSizedBox(0.01),
                    GestureDetector(
                      onTap: () {
                        clearController();

                        Navigator.pop(context);
                      },
                      child: const Text(
                        "SignIn",
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
        floatingActionButton: CommonBottomButton(
          onTap: () {
            if (formKey.currentState!.validate()) {
              FocusScope.of(context).unfocus();
              Provider.of<SignUpProvider>(context, listen: false).createUser(
                email: emailController.text.trim().toString(),
                password: passwordController.text.trim().toString(),
                context: context,
              );
              clearController();
            }
          },
          title: "Create an Account",
        ),
      ),
    );
  }
}

import 'package:e_commerce_app/provider/sign_up_provider.dart';
import 'package:e_commerce_app/utils/app_color.dart';
import 'package:e_commerce_app/widget/common_bottom_button.dart';
import 'package:e_commerce_app/widget/toast_widget.dart';
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
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  signUp() {
    if (userNameController.text.trim().isEmpty) {
      showToast(color: AppColor.red, msg: "Enter your username");
    } else if (passwordController.text.trim().isEmpty) {
      showToast(color: AppColor.red, msg: "Enter your password");
    } else if (passwordController.text.trim().length < 8) {
      showToast(color: AppColor.red, msg: "Your password is too weak!");
    } else if (!EmailValidator.validate(emailController.text.trim())) {
      showToast(color: AppColor.red, msg: "Enter valid email address");
    } else {
      FocusScope.of(context).unfocus();
      Provider.of<SignUpProvider>(context, listen: false).createUser(
        email: emailController.text.trim().toString(),
        password: passwordController.text.trim().toString(),
        context: context,
      );
      clearController();
    }
  }

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
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    debugPrint("sign up screen build method run =================== ");
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.04,
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
              SizedBox(
                height: height * 0.03,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Sign Up",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),

              SizedBox(
                height: height * 0.1,
              ),

              /// username
              Row(
                children: [
                  const Icon(
                    Icons.person,
                  ),
                  SizedBox(
                    width: width * 0.03,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: userNameController,
                      cursorColor: AppColor.black,
                      decoration: const InputDecoration(
                        labelText: "Username",
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: height * 0.03,
              ),

              /// password
              Row(
                children: [
                  const Icon(
                    Icons.lock,
                  ),
                  SizedBox(
                    width: width * 0.03,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: passwordController,
                      cursorColor: AppColor.black,
                      decoration: const InputDecoration(
                        labelText: "Password",
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: height * 0.03,
              ),

              /// email
              Row(
                children: [
                  const Icon(
                    Icons.email,
                  ),
                  SizedBox(
                    width: width * 0.03,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: emailController,
                      cursorColor: AppColor.black,
                      decoration: const InputDecoration(
                        labelText: "Email Address",
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: height * 0.03,
              ),
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
                  SizedBox(
                    height: height * 0.01,
                  ),
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
              SizedBox(
                height: height * 0.06,
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: CommonBottomButton(
          onTap: () {
            signUp();
          },
          title: "Create an Account",
        ),
      ),
    );
  }
}

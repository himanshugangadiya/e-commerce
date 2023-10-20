import 'package:e_commerce_app/provider/login_provider.dart';
import 'package:e_commerce_app/provider/sign_up_provider.dart';
import 'package:e_commerce_app/screen/authentication/forgot_password_screen.dart';
import 'package:e_commerce_app/screen/authentication/sign_up_screen.dart';
import 'package:e_commerce_app/utils/app_color.dart';
import 'package:e_commerce_app/widget/toast_widget.dart';
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

  login() {
    if (emailController.text.isEmpty) {
      showToast(color: AppColor.red, msg: "Enter email address");
    } else if (!EmailValidator.validate(emailController.text)) {
      showToast(color: AppColor.red, msg: "Email not validate");
    } else if (passwordController.text.isEmpty) {
      showToast(color: AppColor.red, msg: "Enter password address");
    } else {
      FocusScope.of(context).unfocus();
      Provider.of<LoginProvider>(context, listen: false).loginUser(
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
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
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
              SizedBox(
                height: height * 0.15,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Welcome",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              SizedBox(
                height: height * 0.005,
              ),
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

              SizedBox(
                height: height * 0.1,
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

              SizedBox(
                height: height * 0.03,
              ),

              /// password
              TextField(
                controller: passwordController,
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                obscureText: true,
                obscuringCharacter: "*",
                cursorColor: AppColor.black,
                decoration: const InputDecoration(
                  labelText: "Password",
                ),
              ),

              SizedBox(
                height: height * 0.025,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      clearController();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordScreen(),
                        ),
                      );
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
              SizedBox(
                height: height * 0.02,
              ),

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
                  SizedBox(
                    height: height * 0.01,
                  ),
                  GestureDetector(
                    onTap: () {
                      clearController();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
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
              SizedBox(
                height: height * 0.06,
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: CommonBottomButton(
          onTap: login,
          title: 'Login',
        ),
      ),
    );
  }
}

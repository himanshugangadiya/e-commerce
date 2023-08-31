import 'package:e_commerce_app/utils/app_color.dart';
import 'package:e_commerce_app/utils/app_route.dart';
import 'package:e_commerce_app/utils/height_width.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../widget/common_back_button.dart';

class SocialScreen extends StatefulWidget {
  const SocialScreen({super.key});

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: W(0.04),
            vertical: H(0.04),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonBackButton(
                onTap: () {
                  context.pop();
                },
              ),
              hSizedBox(0.04),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Let's Get Started",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              const Spacer(),
              SocialButton(
                onTap: () {},
                color: AppColor.lightBlue,
                title: "Facebook",
              ),
              hSizedBox(0.01),
              SocialButton(
                onTap: () {},
                color: AppColor.blue,
                title: "Twitter",
              ),
              hSizedBox(0.01),
              SocialButton(
                onTap: () {},
                color: AppColor.red,
                title: "Google",
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
                      context.push(AppPages.loginScreen);
                    },
                    child: const Text(
                      "Signin",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              hSizedBox(0.02),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        context.push(AppPages.signUpScreen);
                      },
                      child: const Text("Create an Account"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SocialButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color color;
  final String title;
  const SocialButton({
    super.key,
    required this.onTap,
    required this.color,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: H(0.065),
          color: color,
          width: double.infinity,
          alignment: Alignment.center,
          child: Text(
            title,
            style: const TextStyle(
              color: AppColor.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

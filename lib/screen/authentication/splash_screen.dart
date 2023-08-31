import 'package:e_commerce_app/screen/authentication/log_in_screen.dart';
import 'package:e_commerce_app/utils/app_color.dart';
import 'package:e_commerce_app/utils/app_image.dart';
import 'package:e_commerce_app/utils/app_route.dart';
import 'package:e_commerce_app/utils/height_width.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  login() {
    Future.delayed(
      const Duration(seconds: 2),
      () => isLogin
          ? context.go(AppPages.mainScreen)
          : context.go(AppPages.introScreen),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    login();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.purple,
        body: Center(
          child: Image.asset(
            AppImage.logo,
            height: H(0.05),
          ),
        ),
      ),
    );
  }
}

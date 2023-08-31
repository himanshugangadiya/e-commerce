import 'package:e_commerce_app/screen/authentication/intro_screen.dart';
import 'package:e_commerce_app/screen/authentication/log_in_screen.dart';
import 'package:e_commerce_app/screen/authentication/sign_up_screen.dart';
import 'package:e_commerce_app/screen/authentication/social_screen.dart';
import 'package:e_commerce_app/screen/authentication/splash_screen.dart';
import 'package:e_commerce_app/screen/home/home_screen.dart';
import 'package:e_commerce_app/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screen/authentication/forgot_password_screen.dart';

class AppPages {
  static const String splashScreen = "/";
  static const String loginScreen = "/login_screen";
  static const String introScreen = "/intro_screen";
  static const String socialScreen = "/social_screen";
  static const String signUpScreen = "/sign_up_screen";
  static const String forgotPasswordScreen = "/forgot_password_screen";
  static const String mainScreen = "/main_screen";
  static const String homeScreen = "/home_screen";
  static const String detailedScreen = "detailed_screen";
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: AppPages.loginScreen,
      builder: (context, state) => const LogInScreen(),
    ),
    GoRoute(
      path: AppPages.splashScreen,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppPages.introScreen,
      builder: (context, state) => const IntroScreen(),
    ),
    GoRoute(
      path: AppPages.socialScreen,
      builder: (context, state) => const SocialScreen(),
    ),
    GoRoute(
      path: AppPages.signUpScreen,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: AppPages.forgotPasswordScreen,
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: AppPages.mainScreen,
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      path: AppPages.homeScreen,
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: AppPages.detailedScreen,
          builder: (context, state) => const HomeScreen(),
        ),
      ],
    ),
  ],
);

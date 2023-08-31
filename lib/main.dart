import 'package:e_commerce_app/provider/forgot_password_provider.dart';
import 'package:e_commerce_app/provider/login_provider.dart';
import 'package:e_commerce_app/provider/main_provider.dart';
import 'package:e_commerce_app/provider/sign_up_provider.dart';
import 'package:e_commerce_app/utils/app_route.dart';
import 'package:e_commerce_app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

bool isLogin = false;
late Size size;

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ForgotPasswordProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SignUpProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MainProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.sizeOf(context);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      routerConfig: router,
      // routerDelegate: router.routerDelegate,
      // routeInformationProvider: router.routeInformationProvider,
      // routeInformationParser: router.routeInformationParser,
    );
  }
}

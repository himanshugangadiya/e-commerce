import 'package:e_commerce_app/model/product.dart';
import 'package:e_commerce_app/provider/add_review_provider.dart';
import 'package:e_commerce_app/provider/cart_detailed_provider.dart';
import 'package:e_commerce_app/provider/change_password_provider.dart';
import 'package:e_commerce_app/provider/create_address_provider.dart';
import 'package:e_commerce_app/provider/detailed_provider.dart';
import 'package:e_commerce_app/provider/forgot_password_provider.dart';
import 'package:e_commerce_app/provider/home_provider.dart';
import 'package:e_commerce_app/provider/login_provider.dart';
import 'package:e_commerce_app/provider/main_provider.dart';
import 'package:e_commerce_app/provider/sellProvider.dart';
import 'package:e_commerce_app/provider/setting_provider.dart';
import 'package:e_commerce_app/provider/sign_up_provider.dart';
import 'package:e_commerce_app/screen/authentication/splash_screen.dart';
import 'package:e_commerce_app/screen/main_screen.dart';
import 'package:e_commerce_app/utils/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

bool isLogin = false;
late Size size;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();

  final document = await getApplicationDocumentsDirectory();

  /// initialize hive
  await Hive.initFlutter(document.path);

  // Registering the adapter
  Hive.registerAdapter(ProductAdapter());

  /// open box
  await Hive.openBox<Product>("product");
  await Hive.openBox("address");
  await Hive.openBox("theme");

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
        ChangeNotifierProvider(
          create: (context) => DetailedProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddReviewProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartDetailedProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SellProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CreateAddressProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChangePasswordProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SettingProvider(),
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<SettingProvider>(context).getCurrentTheme(),
      home: const SplashScreen(),
    );
  }
}

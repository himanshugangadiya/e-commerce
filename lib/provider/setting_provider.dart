import 'package:e_commerce_app/provider/change_password_provider.dart';
import 'package:e_commerce_app/screen/authentication/splash_screen.dart';
import 'package:e_commerce_app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';

class SettingProvider extends ChangePasswordProvider {
  bool isDark = false;

  var storage = GetStorage();
  changeTheme(bool val, BuildContext context) async {
    isDark = val;
    notifyListeners();
    await storage.write("isDark", isDark).then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const SplashScreen(),
          ),
          (route) => false);
    });
    notifyListeners();
  }

  currentTheme() {
    if (storage.read("isDark")) {
      isDark = true;
      notifyListeners();
    }
  }

  getCurrentTheme() {
    if (storage.read("isDark")) {
      return darkThemeData;
    } else {
      return lightThemeData;
    }
  }
}

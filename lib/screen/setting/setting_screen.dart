import 'package:e_commerce_app/provider/login_provider.dart';
import 'package:e_commerce_app/provider/setting_provider.dart';
import 'package:e_commerce_app/screen/setting/change_password_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/app_color.dart';
import '../../utils/app_image.dart';
import '../sell/sell_on_laza_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SettingProvider>(context, listen: false).currentTheme();
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            vertical: height * (0.03),
            horizontal: width * (0.03),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.05,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * (0.04)),
                child: Text(
                  FirebaseAuth.instance.currentUser!.email.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * (0.04),
                  vertical: height * (0.005),
                ),
                child: Row(
                  children: [
                    const Text(
                      "Verified Profile",
                      style: TextStyle(
                        color: AppColor.grey,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    ClipOval(
                      child: Container(
                        height: height * (0.01),
                        width: height * (0.01),
                        color: AppColor.green,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    Container(
                      height: height * (0.03),
                      width: height * (0.03),
                      margin: EdgeInsets.symmetric(
                        vertical: height * (0.01),
                        horizontal: width * (0.03),
                      ),
                      padding: const EdgeInsets.all(0),
                      child: Image.asset(
                        AppImage.darkMode,
                        fit: BoxFit.cover,
                        color: Provider.of<SettingProvider>(context)
                                .storage
                                .read("isDark")
                            ? Colors.white
                            : Colors.black,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.05,
                    ),
                    const Expanded(
                      child: Text(
                        "Dark Mode",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.visible,
                        maxLines: 1,
                      ),
                    ),
                    Consumer<SettingProvider>(
                      builder: (context, value, child) => Transform.scale(
                        scale: 0.8,
                        child: CupertinoSwitch(
                          value: value.isDark,
                          onChanged: (val) {
                            Provider.of<SettingProvider>(context, listen: false)
                                .changeTheme(val, context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CommonDrawerWidget(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChangePasswordScreen(),
                    ),
                  );
                },
                padding: 0,
                title: "Change Password",
                image: AppImage.password,
              ),
              CommonDrawerWidget(
                onTap: () {},
                padding: 0,
                title: "Order",
                image: AppImage.order,
              ),
              CommonDrawerWidget(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SellOnLazaScreen(),
                    ),
                  );
                },
                padding: 0,
                title: "Sell On Laza",
                image: AppImage.cart,
              ),

              /// logout
              GestureDetector(
                onTap: () {
                  context.read<LoginProvider>().signOut(context);
                },
                child: Row(
                  children: [
                    Container(
                      height: height * (0.03),
                      width: height * (0.03),
                      margin: EdgeInsets.symmetric(
                        vertical: height * (0.015),
                        horizontal: width * (0.03),
                      ),
                      padding: const EdgeInsets.all(2),
                      child: const Icon(Icons.logout),
                    ),
                    SizedBox(
                      width: width * 0.05,
                    ),
                    const Expanded(
                      child: Text(
                        "Sign out",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.visible,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommonDrawerWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String image;
  final String title;
  final double padding;

  const CommonDrawerWidget({
    super.key,
    required this.onTap,
    required this.image,
    required this.title,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            height: height * (0.03),
            width: height * (0.03),
            margin: EdgeInsets.symmetric(
              vertical: height * (0.015),
              horizontal: width * (0.03),
            ),
            padding: EdgeInsets.all(padding),
            child: Image.asset(
              image,
              color:
                  Provider.of<SettingProvider>(context).storage.read("isDark")
                      ? Colors.white
                      : Colors.black,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),
          SizedBox(
            width: width * 0.05,
          ),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.visible,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}

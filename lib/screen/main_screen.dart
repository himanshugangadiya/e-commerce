import 'package:animations/animations.dart';
import 'package:e_commerce_app/provider/login_provider.dart';
import 'package:e_commerce_app/provider/main_provider.dart';
import 'package:e_commerce_app/provider/setting_provider.dart';
import 'package:e_commerce_app/screen/cart/cart_screen.dart';
import 'package:e_commerce_app/screen/sell/sell_on_laza_screen.dart';
import 'package:e_commerce_app/screen/setting/setting_screen.dart';
import 'package:e_commerce_app/utils/app_color.dart';
import 'package:e_commerce_app/utils/app_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> screens = const [
    HomeScreen(),
    CartScreen(),
    SettingScreen(),
    SellOnLazaScreen(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<LoginProvider>(context, listen: false).currentUser();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return WillPopScope(
      onWillPop: () {
        return showExitPopUp(height, width);
      },
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: Consumer<MainProvider>(
            builder: (context, value, child) => BottomNavigationBar(
              enableFeedback: true,
              currentIndex: value.selectedIndex,
              type: BottomNavigationBarType.fixed,
              onTap: (index) => value.changeIndex(index),
              items: [
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.symmetric(vertical: height * (0.01)),
                    child: Image.asset(
                      AppImage.home,
                      height: height * (0.027),
                      color:
                          Provider.of<SettingProvider>(context, listen: false)
                                  .storage
                                  .read("isDark")
                              ? value.selectedIndex == 0
                                  ? AppColor.white
                                  : AppColor.grey
                              : value.selectedIndex == 0
                                  ? AppColor.black
                                  : AppColor.grey,
                    ),
                  ),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.symmetric(vertical: height * (0.01)),
                    child: Image.asset(
                      AppImage.bag,
                      height: height * (0.027),
                      color:
                          Provider.of<SettingProvider>(context, listen: false)
                                  .storage
                                  .read("isDark")
                              ? value.selectedIndex == 1
                                  ? AppColor.white
                                  : AppColor.grey
                              : value.selectedIndex == 1
                                  ? AppColor.black
                                  : AppColor.grey,
                    ),
                  ),
                  label: "Cart",
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.symmetric(vertical: height * (0.01)),
                    child: Image.asset(
                      AppImage.setting,
                      color:
                          Provider.of<SettingProvider>(context, listen: false)
                                  .storage
                                  .read("isDark")
                              ? value.selectedIndex == 2
                                  ? AppColor.white
                                  : AppColor.grey
                              : value.selectedIndex == 2
                                  ? AppColor.black
                                  : AppColor.grey,
                      height: height * (0.030),
                    ),
                  ),
                  label: "Setting",
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.symmetric(vertical: height * (0.01)),
                    child: Image.asset(
                      AppImage.cart,
                      height: height * (0.027),
                      color:
                          Provider.of<SettingProvider>(context, listen: false)
                                  .storage
                                  .read("isDark")
                              ? value.selectedIndex == 3
                                  ? AppColor.white
                                  : AppColor.grey
                              : value.selectedIndex == 3
                                  ? AppColor.black
                                  : AppColor.grey,
                    ),
                  ),
                  label: "Sell",
                ),
              ],
            ),
          ),
          body: Consumer<MainProvider>(
            builder: (context, value, child) => PageTransitionSwitcher(
              duration: const Duration(milliseconds: 600),
              transitionBuilder: (Widget child,
                  Animation<double> primaryAnimation,
                  Animation<double> secondaryAnimation) {
                return FadeThroughTransition(
                  fillColor:
                      Provider.of<SettingProvider>(context, listen: false)
                              .storage
                              .read("isDark")
                          ? AppColor.black
                          : AppColor.white,
                  animation: primaryAnimation,
                  secondaryAnimation: secondaryAnimation,
                  child: child,
                );
              },
              child: screens[value.selectedIndex],
            ),
          ),
        ),
      ),
    );
  }

  /// EXIT POPUP
  Future<bool> showExitPopUp(double height, double width) async {
    return await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                "Exit App",
                style: TextStyle(
                  color: AppColor.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              content: const Text(
                "Do you want to exit an App?",
                style: TextStyle(
                  color: AppColor.white,
                  fontSize: 14,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: AppColor.purple,
              actions: [
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(
                            horizontal: width * (0.02),
                            vertical: height * (0.005),
                          ),
                          decoration: BoxDecoration(
                            // color: BaseColor.blue,
                            border: Border.all(
                              color: AppColor.white,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            "No",
                            style: TextStyle(
                              color: AppColor.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          margin: EdgeInsets.symmetric(
                            horizontal: width * (0.02),
                            vertical: height * (0.005),
                          ),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            // color: BaseColor.gradient3,
                            border: Border.all(
                              color: AppColor.white,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            "Yes",
                            style: TextStyle(
                              color: AppColor.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: width * 0.03,
                )
              ],
            );
          },
        ) ??
        false;
  }
}

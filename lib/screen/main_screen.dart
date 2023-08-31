import 'package:e_commerce_app/provider/main_provider.dart';
import 'package:e_commerce_app/utils/app_color.dart';
import 'package:e_commerce_app/utils/app_image.dart';
import 'package:e_commerce_app/utils/height_width.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'home/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> screens = [
    const HomeScreen(),
    Container(),
    Container(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return showExitPopUp();
      },
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: Consumer<MainProvider>(
            builder: (context, value, child) => BottomNavigationBar(
              enableFeedback: true,
              currentIndex: value.selectedIndex,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedLabelStyle: GoogleFonts.inter(
                color: AppColor.black,
                fontSize: 10.0,
              ),
              unselectedLabelStyle: GoogleFonts.inter(
                color: AppColor.grey,
                fontSize: 15.0,
              ),
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppColor.white,
              onTap: (index) => value.changeIndex(index),
              items: [
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.symmetric(vertical: H(0.01)),
                    child: Image.asset(
                      AppImage.home,
                      height: H(0.027),
                      color: value.selectedIndex == 0
                          ? AppColor.black
                          : AppColor.grey,
                    ),
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.symmetric(vertical: H(0.01)),
                    child: Image.asset(AppImage.wishlist,
                        color: value.selectedIndex == 1
                            ? AppColor.black
                            : AppColor.grey,
                        height: H(0.027)),
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.symmetric(vertical: H(0.01)),
                    child: Image.asset(
                      AppImage.bag,
                      height: H(0.027),
                      color: value.selectedIndex == 2
                          ? AppColor.black
                          : AppColor.grey,
                    ),
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.symmetric(vertical: H(0.01)),
                    child: Image.asset(
                      AppImage.wallet,
                      color: value.selectedIndex == 3
                          ? AppColor.black
                          : AppColor.grey,
                      height: H(0.027),
                    ),
                  ),
                  label: "",
                ),
              ],
            ),
          ),
          body: Consumer<MainProvider>(
            builder: (context, value, child) => IndexedStack(
              index: value.selectedIndex,
              children: screens,
            ),
          ),
        ),
      ),
    );
  }

  /// EXIT POPUP
  Future<bool> showExitPopUp() async {
    return await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                "Exit App",
                style: TextStyle(
                  color: AppColor.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              content: const Text(
                "Do you want to exit an App?",
                style: TextStyle(
                  color: AppColor.black,
                  fontSize: 14,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: AppColor.white,
              actions: [
                Row(
                  children: [
                    hSizedBox(0.15),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(
                            horizontal: W(0.02),
                            vertical: H(0.005),
                          ),
                          decoration: BoxDecoration(
                            // color: BaseColor.blue,
                            border: Border.all(
                              color: AppColor.black,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            "No",
                            style: TextStyle(
                              color: AppColor.black,
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
                            horizontal: W(0.02),
                            vertical: H(0.005),
                          ),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            // color: BaseColor.gradient3,
                            border: Border.all(
                              color: AppColor.black,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            "Yes",
                            style: TextStyle(
                              color: AppColor.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                wSizedBox(0.03),
              ],
            );
          },
        ) ??
        false;
  }
}

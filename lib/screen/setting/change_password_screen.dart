import 'package:e_commerce_app/provider/change_password_provider.dart';
import 'package:e_commerce_app/utils/app_color.dart';
import 'package:e_commerce_app/widget/common_bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widget/common_back_button.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    debugPrint("change password screen build method run =================== ");
    return WillPopScope(
      onWillPop: () async {
        Provider.of<ChangePasswordProvider>(context, listen: false)
            .clearController();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * (0.04),
              vertical: height * (0.04),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonBackButton(
                  onTap: () {
                    Provider.of<ChangePasswordProvider>(context, listen: false)
                        .clearController();

                    Navigator.pop(context);
                  },
                ),
                SizedBox(height: height * 0.03),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Change Password",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),

                SizedBox(
                  height: height * 0.1,
                ),
                Consumer<ChangePasswordProvider>(
                  builder: (context, value, child) => TextFormField(
                    controller: value.newPasswordController,
                    cursorColor: AppColor.black,
                    decoration: const InputDecoration(
                      labelText: "New password",
                    ),
                  ),
                ),

                SizedBox(
                  height: height * 0.03,
                ),

                /// password
                Consumer<ChangePasswordProvider>(
                  builder: (context, value, child) => TextFormField(
                    controller: value.confirmPasswordController,
                    cursorColor: AppColor.black,
                    decoration: const InputDecoration(
                      labelText: "Confirm password",
                    ),
                  ),
                ),

                SizedBox(
                  height: height * 0.03,
                ),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: CommonBottomButton(
            onTap: () {
              FocusScope.of(context).unfocus();
              Provider.of<ChangePasswordProvider>(context, listen: false)
                  .changePassword(
                context: context,
              );
            },
            title: "Save",
          ),
        ),
      ),
    );
  }
}

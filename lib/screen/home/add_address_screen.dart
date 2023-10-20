 import 'package:e_commerce_app/widget/common_back_button.dart';
import 'package:e_commerce_app/widget/common_bottom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/app_color.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, height*(0.1)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: const Text("Add address"),
            centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.all(5.0),
              child: CommonBackButton(
                onTap: () {},
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width*(0.05),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             SizedBox(
              height: height*0.01,
            ),

            /// name
            Text(
              "Name",
              style: Theme.of(context).textTheme.displayMedium,
            ),

             SizedBox(
              height: height*0.015,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: height*(0.065),
                color: AppColor.grey.withOpacity(0.2),
                alignment: Alignment.center,
                child: TextField(
                  cursorColor: AppColor.purple,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: width*(0.03),
                    ),
                    hintText: "Type your name",
                    hintStyle: const TextStyle(
                      color: AppColor.grey,
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                  ),
                ),
              ),
            ),

             SizedBox(
              height: height*0.03,
            ),
            /// country && city
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Country",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                       SizedBox(
                        height: height*0.015,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: height*(0.065),
                          color: AppColor.grey.withOpacity(0.2),
                          alignment: Alignment.center,
                          child: TextField(
                            cursorColor: AppColor.purple,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: width*(0.03),
                              ),
                              hintText: "Country",
                              hintStyle: const TextStyle(
                                color: AppColor.grey,
                              ),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                 SizedBox(
                  width: width*0.05,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "City",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                       SizedBox(
                        height: height*0.015,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: height*(0.065),
                          color: AppColor.grey.withOpacity(0.2),
                          alignment: Alignment.center,
                          child: TextField(
                            cursorColor: AppColor.purple,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: width*(0.03),
                              ),
                              hintText: "City",
                              hintStyle: const TextStyle(
                                color: AppColor.grey,
                              ),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

             SizedBox(
              height: height*0.03,
            ),

            /// phone number
            Text(
              "Phone number",
              style: Theme.of(context).textTheme.displayMedium,
            ),
             SizedBox(
              height: height*0.015,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: height*(0.065),
                color: AppColor.grey.withOpacity(0.2),
                alignment: Alignment.center,
                child: TextField(
                  cursorColor: AppColor.purple,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: width*(0.03),
                    ),
                    hintText: "Enter phone number",
                    hintStyle: const TextStyle(
                      color: AppColor.grey,
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                  ),
                ),
              ),
            ),

             SizedBox(
              height: height*0.03,
            ),

            /// address
            Text(
              "Address",
              style: Theme.of(context).textTheme.displayMedium,
            ),
             SizedBox(
              height: height*0.015,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: height*(0.065),
                color: AppColor.grey.withOpacity(0.2),
                alignment: Alignment.center,
                child: TextField(
                  cursorColor: AppColor.purple,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: width*(0.03),
                    ),
                    hintText: "Enter address",
                    hintStyle: const TextStyle(
                      color: AppColor.grey,
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                  ),
                ),
              ),
            ),


             SizedBox(
              height: height*0.015,
            ),

            /// primary address
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Save as primary address",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Transform.scale(
                  scale: 0.8,
                  child: CupertinoSwitch(
                    value: false,
                    onChanged: (val) {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CommonBottomButton(
        onTap: () {},
        title: "Save Address",
      ),
    );
  }
}

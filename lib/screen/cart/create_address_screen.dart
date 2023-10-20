import 'package:e_commerce_app/provider/create_address_provider.dart';
import 'package:e_commerce_app/provider/login_provider.dart';
import 'package:e_commerce_app/widget/common_bottom_button.dart';
 import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/app_color.dart';
 import '../../widget/common_back_button.dart';

class CreateAddressScreen extends StatefulWidget {
  const CreateAddressScreen({super.key});

  @override
  State<CreateAddressScreen> createState() => _CreateAddressScreenState();
}

class _CreateAddressScreenState extends State<CreateAddressScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size(
            double.infinity,
            height*(0.1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              title: const Text("Create New Address"),
              centerTitle: true,
              leading: Padding(
                padding: const EdgeInsets.all(5.0),
                child: CommonBackButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width*(0.04),
          ),
          child: Consumer<CreateAddressProvider>(
            builder: (context, value, child) => Column(
              children: [
                CommonAddressTextFieldWidget(
                  controller: value.nameController,
                  title: "Name",
                  hintText: "john don",
                  inputType: TextInputType.text,
                ),
                 SizedBox(
                  height: height*0.02,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CommonAddressTextFieldWidget(
                        controller: value.countryController,
                        title: "Country",
                        hintText: "India",
                        inputType: TextInputType.text,
                      ),
                    ),
                    SizedBox(
                      width: width*0.04,
                    ),
                     Expanded(
                      child: CommonAddressTextFieldWidget(
                        controller: value.cityController,
                        title: "City",
                        hintText: "Surat",
                        inputType: TextInputType.text,
                      ),
                    ),
                  ],
                ),
                 SizedBox(
                  height: height*0.02,
                ),
                CommonAddressTextFieldWidget(
                  controller: value.phoneNumberController,
                  title: "Phone number",
                  hintText: "70445 61154",
                  inputType: TextInputType.number,
                ),
                 SizedBox(
                  height: height*0.02,
                ),
                CommonAddressTextFieldWidget(
                  controller: value.addressController,
                  title: "Address",
                  hintText: "28,xyz society,varachha,surat,gujarat",
                  inputType: TextInputType.text,
                ),
                 SizedBox(
                  height: height*0.02,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     const Text(
                //       "Save as primary address",
                //       style:
                //           TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                //     ),
                //     Transform.scale(
                //       scale: 0.8,
                //       child: CupertinoSwitch(
                //         value: false,
                //         onChanged: (val) {},
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Consumer<CreateAddressProvider>(
          builder: (context, value, child) => CommonBottomButton(
            onTap: () {
              if (value.validate()) {
                value.addAddress(
                  Provider.of<LoginProvider>(context, listen: false)
                      .currentUserId(),
                  context,
                );
              }
            },
            title: "Add address",
          ),
        ),
      ),
    );
  }
}

class CommonAddressTextFieldWidget extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String hintText;
  final TextInputType inputType;
  const CommonAddressTextFieldWidget({
    super.key,
    required this.title,
    required this.inputType,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: height*(0.01)),
          child: Text(
            title.toString(),
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: height*(0.06),
            color: AppColor.grey.withOpacity(0.2),
            child: TextField(
              controller: controller,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
              cursorColor: AppColor.black,
              keyboardType: inputType,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: width*(0.03),
                ),
                hintText: hintText,
                focusedErrorBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

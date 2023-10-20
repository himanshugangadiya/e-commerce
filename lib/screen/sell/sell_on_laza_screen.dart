import 'dart:developer';
import 'dart:io';

import 'package:chips_choice/chips_choice.dart';
import 'package:e_commerce_app/provider/sellProvider.dart';
import 'package:e_commerce_app/utils/app_color.dart';
import 'package:e_commerce_app/widget/common_bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

class SellOnLazaScreen extends StatefulWidget {
  const SellOnLazaScreen({super.key});

  @override
  State<SellOnLazaScreen> createState() => _SellOnLazaScreenState();
}

class _SellOnLazaScreenState extends State<SellOnLazaScreen> {
  List<String> selectedSizeList = [];
  List<String> sizeList = [
    "XXXS",
    "XXS",
    "XS",
    "S",
    "M",
    "L",
    "XL",
    "XXL",
    "XXXL",
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    log("Sell on laza screen build method  ============ ");
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(
            double.infinity,
            height * (0.1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              title: const Text("Add Product Details"),
              centerTitle: true,
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: height * (0.01),
              horizontal: width * (0.04),
            ),
            child: Consumer<SellProvider>(
              builder: (context, value, child) => Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      value.pickProductImage();
                    },
                    child: Container(
                      height: height * (0.2),
                      width: double.infinity,
                      alignment: Alignment.center,
                      color: AppColor.grey.withOpacity(0.2),
                      child: value.productImage != null
                          ? Image.file(
                              value.productImage!,
                              fit: BoxFit.cover,
                            )
                          : const Text(
                              "Add Product Image",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  TextField(
                    controller: value.titleController,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                    cursorColor: AppColor.black,
                    decoration: const InputDecoration(
                      labelText: "Product title",
                    ),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  TextField(
                    controller: value.subTitleController,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                    cursorColor: AppColor.black,
                    decoration: const InputDecoration(
                      labelText: "Product sub title",
                    ),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  TextField(
                    controller: value.descriptionController,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                    cursorColor: AppColor.black,
                    decoration: const InputDecoration(
                      labelText: "Product description",
                    ),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  TextField(
                    controller: value.brandController,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                    cursorColor: AppColor.black,
                    decoration: const InputDecoration(
                      labelText: "Product brand",
                    ),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  TextField(
                    controller: value.priceController,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                    keyboardType: TextInputType.number,
                    cursorColor: AppColor.black,
                    decoration: const InputDecoration(
                      labelText: "Product price",
                    ),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  TextField(
                    controller: value.taxController,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                    keyboardType: TextInputType.number,
                    cursorColor: AppColor.black,
                    decoration: const InputDecoration(
                      labelText: "Product tax",
                    ),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  TextField(
                    controller: value.discountController,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                    keyboardType: TextInputType.number,
                    cursorColor: AppColor.black,
                    decoration: const InputDecoration(
                      labelText: "Product discount",
                    ),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  TextField(
                    controller: value.shippingCostController,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                    keyboardType: TextInputType.number,
                    cursorColor: AppColor.black,
                    decoration: const InputDecoration(
                      labelText: "Product shipping cost",
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Consumer<SellProvider>(
                    builder: (context, value, child) => GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                                builder: (context, setState) {
                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: height * (0.01),
                                      ),
                                      child: const Text(
                                        "Select sizes",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    ChipsChoice<String>.multiple(
                                      value: selectedSizeList,
                                      mainAxisSize: MainAxisSize.max,
                                      alignment: WrapAlignment.start,
                                      wrapped: true,
                                      scrollPhysics:
                                          const NeverScrollableScrollPhysics(),
                                      onChanged: (val) {
                                        setState(() {
                                          selectedSizeList = val;
                                          log(selectedSizeList.toString());
                                        });
                                      },
                                      choiceStyle: const C2ChipStyle(),
                                      choiceItems:
                                          C2Choice.listFrom<String, String>(
                                        source: sizeList,
                                        value: (i, v) => v,
                                        label: (i, v) => v,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                          },
                        );
                      },
                      child: Container(
                        height: height * (0.06),
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(vertical: height * (0.02)),
                        color: AppColor.grey.withOpacity(0.2),
                        alignment: Alignment.center,
                        child: const Text(
                          "Select mutiple sizes",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: GestureDetector(
                      onTap: () {
                        value.pickProductMultipleImage();
                      },
                      child: Container(
                        height: height * (0.06),
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(vertical: height * (0.02)),
                        color: AppColor.grey.withOpacity(0.2),
                        alignment: Alignment.center,
                        child: const Text(
                          "+ Add Product Images",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),

                  /// picked multi images
                  Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: List.generate(
                      value.productImagesList.length,
                      (index) => badges.Badge(
                        position:
                            badges.BadgePosition.topEnd(top: -10, end: -12),
                        onTap: () {
                          value.removeSelectedImage(index);
                        },
                        badgeContent: const Icon(
                          Icons.clear,
                          color: Colors.white,
                          size: 15,
                        ),
                        badgeStyle: const badges.BadgeStyle(
                          badgeColor: AppColor.purple,
                        ),
                        child: Container(
                          height: height * (0.15),
                          width: height * (0.15),
                          color: AppColor.grey.withOpacity(0.5),
                          child: Image.file(
                            File(value.productImagesList[index]!.path),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.1,
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Consumer<SellProvider>(
          builder: (context, value, child) => value.isLoading
              ? Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * (0.05),
                    vertical: height * (0.02),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: AppColor.purple,
                      ),
                    ],
                  ),
                )
              : CommonBottomButton(
                  onTap: () {
                    value.addProduct(selectedSizeList);
                  },
                  title: "Sell Product",
                ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/provider/login_provider.dart';
import 'package:e_commerce_app/provider/setting_provider.dart';
import 'package:e_commerce_app/screen/cart/cart_detailed_screen.dart';
import 'package:e_commerce_app/utils/app_color.dart';
import 'package:e_commerce_app/utils/app_image.dart';
import 'package:e_commerce_app/widget/common_bottom_button.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/height_width.dart';
import '../../widget/common_add_remove_button.dart';
import '../../widget/common_arrow_forward_button.dart';
import '../../widget/common_back_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text("Cart"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: W(0.05),
        ),
        child: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection("cart_data").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColor.black,
                  ),
                );
              } else {
                List data = snapshot.data!.docs;
                List cartData = data
                    .where((element) =>
                        element["uId"] ==
                        FirebaseAuth.instance.currentUser!.uid)
                    .toList();
                return cartData.isNotEmpty
                    ? ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: cartData.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: H(0.02)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            CartDetailedScreen(
                                          id: cartData[index].id.toString(),
                                        ),
                                      ));
                                },
                                child: Container(
                                  height: H(0.16),
                                  color: AppColor.grey.withOpacity(0.1),
                                  padding: const EdgeInsets.all(12),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          height: double.infinity,
                                          width: W(0.28),
                                          color: Colors.white,
                                          child: FancyShimmerImage(
                                            imageUrl: cartData[index]
                                                    ["product_image"]
                                                .toString(),
                                          ),
                                        ),
                                      ),
                                      wSizedBox(0.03),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                hSizedBox(0.005),
                                                Text(
                                                  cartData[index]["title"]
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium!
                                                      .copyWith(fontSize: 18),
                                                  maxLines: 2,
                                                ),
                                                hSizedBox(0.005),
                                                Text(
                                                  cartData[index]["description"]
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: AppColor.grey,
                                                    fontSize: 16,
                                                  ),
                                                  maxLines: 1,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "₹ ${cartData[index]["price"].toString()}",
                                                  style: const TextStyle(
                                                      color: AppColor.grey),
                                                  maxLines: 1,
                                                ),
                                                CommonAddRemoveButton(
                                                  onTap: () async {
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection("cart_data")
                                                        .doc(cartData[index]
                                                            .id
                                                            .toString())
                                                        .delete();
                                                  },
                                                  height: H(0.04),
                                                  color:
                                                      Provider.of<SettingProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .storage
                                                              .read("isDark")
                                                          ? AppColor.grey
                                                              .withOpacity(0.4)
                                                          : AppColor.white,
                                                  icon: Icon(
                                                    Icons.delete_outline,
                                                    color:
                                                        Provider.of<SettingProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .storage
                                                                .read("isDark")
                                                            ? AppColor.white
                                                            : AppColor.grey,
                                                    size: 20,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Text("No data found"),
                      );
              }
            }
          },
        ),
      ),
    );
  }
}

class PriceWidget extends StatelessWidget {
  const PriceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Price",
          style: TextStyle(color: AppColor.grey),
        ),
        Text(
          "\$114",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class TotalWidget extends StatelessWidget {
  const TotalWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Total",
          style: TextStyle(color: AppColor.black, fontWeight: FontWeight.bold),
        ),
        Text(
          "\$125",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class ShippingCostWidget extends StatelessWidget {
  const ShippingCostWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Shipping cost",
          style: TextStyle(color: AppColor.grey),
        ),
        Text(
          "\$11",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class DiscountWidget extends StatelessWidget {
  const DiscountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Discount(2%)",
          style: TextStyle(color: AppColor.grey),
        ),
        Text(
          "\$2.4",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

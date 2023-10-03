import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/provider/login_provider.dart';
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
import '../home/home_screen.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text("Wishlist"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("wishlist").snapshots(),
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
              List response = snapshot.data!.docs;
              List wishListData = response
                  .where((element) =>
                      element["uId"] == FirebaseAuth.instance.currentUser!.uid)
                  .toList();
              return wishListData.isNotEmpty
                  ? GridView.builder(
                      itemCount: wishListData.length,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.62,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: W(0.05),
                        vertical: H(0.02),
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        dynamic data = wishListData[index];
                        return HomeSubWidget(
                          id: wishListData[index].id.toString(),
                          data: data.data(),
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

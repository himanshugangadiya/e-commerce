import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/model/product.dart';
import 'package:e_commerce_app/provider/login_provider.dart';
import 'package:e_commerce_app/screen/cart/cart_detailed_screen.dart';
import 'package:e_commerce_app/screen/cart/cart_screen.dart';
import 'package:e_commerce_app/services/firebase_firestore.dart';
import 'package:e_commerce_app/utils/app_color.dart';
import 'package:e_commerce_app/widget/toast_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class DetailedProvider extends ChangeNotifier {
  int? selectedSizeIndex;
  String selectedSizeName = "";
  bool isWishlist = false;

  String selectedProductImage = '';

  changeProductImage(String image) {
    selectedProductImage = image;
    notifyListeners();
  }

  changeWishList() {
    isWishlist = !isWishlist;
    notifyListeners();
  }

  addWishlist(num productId, BuildContext context, Box box) async {
    if (isWishlist == true) {
      Product product = Product()..productId = productId;
      await box.add(product).then((value) {
        log("wishlist added");
        isWishlist = false;
        notifyListeners();
      });
    }
  }

  selectedSize(int index, String name) {
    selectedSizeIndex = index;
    selectedSizeName = name;
    notifyListeners();
  }

  addToCart(data, size, BuildContext context, {required String id}) async {
    data["uId"] = Provider.of<LoginProvider>(context, listen: false)
        .currentUserId()
        .toString();
    data["selected_size"] = size.toString();

    await FirebaseFirestore.instance
        .collection("cart_data")
        .add(data)
        .then((value) {
      selectedSizeIndex = null;
      selectedSizeName = '';
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CartScreen(),
        ),
      );
    }).catchError((error) {
      selectedSizeIndex = null;
      selectedSizeName = '';
      showToast(color: AppColor.red, msg: error.toString());
    });
  }
}

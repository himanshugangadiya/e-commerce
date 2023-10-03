import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier {
  List brandList = [];
  bool isWishList = false;
  String searchingText = '';

  searchFilter(String val) {
    searchingText = val;
    print(searchingText);
    notifyListeners();
  }

  brandFilter(productData) {
    Set data = {};

    print(data.toString());
    brandList = data.toList();
    notifyListeners();
  }

  addWishList(bool value, {required product}) async {
    isWishList = value;
    notifyListeners();

    // if (isWishList) {
    // await FirebaseFirestore.instance.collection("wishlist").add(product);
    // }
  }
}

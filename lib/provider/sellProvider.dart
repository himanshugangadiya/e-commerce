import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/main.dart';
import 'package:e_commerce_app/widget/toast_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/app_color.dart';

class SellProvider extends ChangeNotifier {
  TextEditingController titleController = TextEditingController();
  TextEditingController subTitleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController taxController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController shippingCostController = TextEditingController();
  ImagePicker imagePicker = ImagePicker();
  List<XFile?> productImagesList = [];
  List<String> productUrlList = [];
  File? productImage;
  String productUrl = '';
  bool isLoading = false;

  /// pick product image
  pickProductImage() async {
    XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      productImage = File(image.path);
      notifyListeners();
    }
    notifyListeners();
  }

  pickProductMultipleImage() async {
    List<XFile?> list = await imagePicker.pickMultiImage(
      imageQuality: 50,
    );

    if (list.isNotEmpty) {
      productImagesList = [...list];
      notifyListeners();
    }
    notifyListeners();
  }

  /// remove picked image index
  removeSelectedImage(index) {
    productImagesList.removeAt(index);
    notifyListeners();
  }

  /// validation
  bool validate(List selectedSizeList) {
    if (productImage == null) {
      showToast(color: AppColor.red, msg: "Select Product image");
      return false;
    } else if (titleController.text.trim().isEmpty) {
      showToast(color: AppColor.red, msg: "Enter title to continue");
      notifyListeners();
      return false;
    } else if (subTitleController.text.trim().isEmpty) {
      showToast(color: AppColor.red, msg: "Enter sub title to continue");
      notifyListeners();
      return false;
    } else if (descriptionController.text.trim().isEmpty) {
      showToast(color: AppColor.red, msg: "Enter description to continue");
      return false;
    } else if (brandController.text.trim().isEmpty) {
      showToast(color: AppColor.red, msg: "Enter brand to continue");
      return false;
    } else if (priceController.text.trim().isEmpty) {
      showToast(color: AppColor.red, msg: "Enter price to continue");
      return false;
    } else if (taxController.text.trim().isEmpty) {
      showToast(color: AppColor.red, msg: "Enter tax to continue");
      return false;
    } else if (discountController.text.trim().isEmpty) {
      showToast(color: AppColor.red, msg: "Enter discount to continue");
      return false;
    } else if (shippingCostController.text.trim().isEmpty) {
      showToast(color: AppColor.red, msg: "Enter shipping cost to continue");
      return false;
    } else if (selectedSizeList.isEmpty) {
      showToast(color: AppColor.red, msg: "Select sizes to continue");
      return false;
    } else if (productImagesList.isEmpty) {
      showToast(color: AppColor.red, msg: "Select product images to continue");
      return false;
    } else {
      return true;
    }
  }

  FirebaseStorage storage = FirebaseStorage.instance;

  addProduct(List selectedSizeList) async {
    isLoading = true;
    notifyListeners();

    try {
      if (validate(selectedSizeList)) {
        isLoading = true;
        notifyListeners();
        productImageToUrl(selectedSizeList);
      } else {
        isLoading = false;
        notifyListeners();
      }
    } on Exception catch (error) {
      isLoading = false;
      notifyListeners();
      showToast(color: AppColor.red, msg: error.toString());
    }
  }

  productImageToUrl(List selectedSizeList) {
    var ref =
        storage.ref().child("images/${DateTime.now().millisecondsSinceEpoch}");
    ref.putFile(File(productImage!.path)).whenComplete(() async {
      await ref.getDownloadURL().then((value) {
        print("============================================$value");
        productUrl = value;
        notifyListeners();
      });
    }).then((value) {
      isLoading = true;
      notifyListeners();
      productMultipleImagesToUrl(selectedSizeList);
    }).catchError((error) {
      isLoading = false;
      notifyListeners();
      showToast(color: AppColor.red, msg: error.toString());
    });
  }

  productMultipleImagesToUrl(List selectedSizeList) async {
    try {
      for (var x in productImagesList) {
        var ref = storage
            .ref()
            .child("images/${DateTime.now().millisecondsSinceEpoch}");
        await ref.putFile(File(x!.path)).whenComplete(() async {
          await ref.getDownloadURL().then((value) {
            productUrlList.add(value);
            notifyListeners();
          });
        }).then((value) {
          isLoading = true;
          notifyListeners();
          uploadProduct(selectedSizeList);
        }).catchError((e) {
          showToast(color: AppColor.red, msg: e.toString());
        });
      }
    } catch (error) {
      isLoading = false;
      notifyListeners();
      showToast(color: AppColor.red, msg: error.toString());
    }
  }

  uploadProduct(List selectedSizeList) async {
    if (productUrl != '' && productUrlList.isNotEmpty) {
      try {
        var data = {
          "product_id": DateTime.now().millisecondsSinceEpoch,
          "product_image": productUrl,
          "review_list": [],
          "size_list": selectedSizeList,
          "title": titleController.text.toString(),
          "sub_title": subTitleController.text.toString(),
          "description": descriptionController.text.toString(),
          "brand": brandController.text.toString(),
          "price": num.parse(priceController.text.trim().toString()),
          "tax": num.parse(taxController.text.trim().toString()),
          "discount": num.parse(discountController.text.trim().toString()),
          "shipping_cost":
              num.tryParse(shippingCostController.text.trim().toString()),
          "image_list": productUrlList,
        };
        await FirebaseFirestore.instance
            .collection("product_data")
            .add(data)
            .then((value) {
          isLoading = false;
          notifyListeners();
          clearData();
          showToast(
            color: AppColor.purple,
            msg: "Your product has been added successfully.",
          );
        });
      } catch (error) {
        isLoading = false;
        notifyListeners();
        showToast(color: AppColor.red, msg: error.toString());
      }
    } else {
      isLoading = false;
      notifyListeners();
    }
  }

  clearData() {
    titleController.clear();
    subTitleController.clear();
    descriptionController.clear();
    brandController.clear();
    priceController.clear();
    discountController.clear();
    shippingCostController.clear();
    taxController.clear();
    productUrlList = [];
    productUrl = '';
    productImagesList = [];
    productImage = null;
    notifyListeners();
  }
}

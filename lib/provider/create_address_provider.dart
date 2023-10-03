import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/utils/app_color.dart';
import 'package:e_commerce_app/widget/toast_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class CreateAddressProvider extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  bool isPrimaryAddress = false;
  int? selectedAddressIndex;
  Map selectedAddressData = {};
  late Box address;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  deleteAddress(addressData, docId) async {
    var data = address.get("primaryAddress");
    if (data["name"] == addressData["name"] &&
        data["address"] == addressData["address"]) {
      address.put("primaryAddress", {});
      notifyListeners();
      selectedAddressIndex = null;
      notifyListeners();
    }
    await firebaseFirestore
        .collection("user_address")
        .doc(docId.toString())
        .delete()
        .then((value) {})
        .catchError((e) {
      showToast(color: AppColor.red, msg: e.toString());
    });
  }

  addressBoxInitialize() {
    address = Hive.box("address");
  }

  savePrimaryAddress(context) {
    if (selectedAddressData.isNotEmpty) {
      address.put("primaryAddress", selectedAddressData);
      notifyListeners();
      Navigator.pop(context);
    } else {
      showToast(color: AppColor.red, msg: "Please select address");
    }
  }

  addressIndex(index, data) {
    debugPrint(data.toString());
    selectedAddressIndex = index;
    notifyListeners();
    selectedAddressData = data;
    notifyListeners();
  }

  bool validate() {
    if (nameController.text.trim().isEmpty) {
      showToast(color: AppColor.red, msg: "Enter name");
      return false;
    } else if (countryController.text.trim().isEmpty) {
      showToast(color: AppColor.red, msg: "Enter country name");
      return false;
    } else if (cityController.text.trim().isEmpty) {
      showToast(color: AppColor.red, msg: "Enter city name");
      return false;
    } else if (phoneNumberController.text.trim().isEmpty) {
      showToast(color: AppColor.red, msg: "Enter phone number");
      return false;
    } else if (addressController.text.trim().isEmpty) {
      showToast(color: AppColor.red, msg: "Enter address");
      return false;
    } else {
      return true;
    }
  }

  clearControllerData() {
    nameController.clear();
    cityController.clear();
    countryController.clear();
    phoneNumberController.clear();
    addressController.clear();
    notifyListeners();
  }

  addAddress(
    userId,
    context,
  ) {
    var data = {
      "uId": userId.toString(),
      "name": nameController.text.toString(),
      "country": countryController.text.toString(),
      "city": cityController.text.toString(),
      "phone_number": int.parse(phoneNumberController.text.toString()),
      "address": addressController.text.toString(),
    };

    FirebaseFirestore.instance
        .collection("user_address")
        .add(data)
        .then((value) {
      clearControllerData();
      showToast(color: AppColor.purple, msg: "New address added");
      Navigator.pop(context);
    }).catchError((error) {
      showToast(color: AppColor.red, msg: error.toString());
    });
  }
}

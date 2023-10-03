import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/screen/main_screen.dart';
import 'package:e_commerce_app/utils/app_color.dart';
import 'package:e_commerce_app/widget/toast_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddReviewProvider extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  double rating = 3;
  List updatedReviewsData = [];

  ratingUpdate(double rating) {
    this.rating = rating;
    print(rating);
    notifyListeners();
  }

  validate() {
    if (nameController.text.trim().isEmpty) {
      return false;
    } else if (descriptionController.text.trim().isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  addReview(
    List reviewData, {
    required String id,
    required BuildContext context,
  }) async {
    if (validate()) {
      updatedReviewsData = reviewData;
      notifyListeners();
      updatedReviewsData.add({
        "date": Timestamp.fromMillisecondsSinceEpoch(
          DateTime.now().millisecondsSinceEpoch,
        ),
        "rating": rating,
        "name": nameController.text.trim().toString(),
        "description": descriptionController.text.trim().toString(),
      });
      notifyListeners();

      await FirebaseFirestore.instance
          .collection("product_data")
          .doc(id)
          .update({
        "review_list": updatedReviewsData.toList(),
      }).then((value) {
        clearData();
        showToast(
          color: AppColor.purple,
          msg: "Your review has been successfully added",
        );
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const MainScreen(),
            ),
            (route) => false);
      }).catchError((error) {
        clearData();
        showToast(color: AppColor.red, msg: error.toString());
      });
    } else {
      showToast(color: AppColor.red, msg: "Enter field to continue");
    }
  }

  clearData() {
    nameController.clear();
    descriptionController.clear();
    rating = 3;
    notifyListeners();
  }
}

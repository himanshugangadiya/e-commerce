import 'package:e_commerce_app/utils/height_width.dart';
import 'package:e_commerce_app/widget/common_back_button.dart';
import 'package:e_commerce_app/widget/common_bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../utils/app_color.dart';

class AddReviewScreen extends StatefulWidget {
  const AddReviewScreen({super.key});

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, H(0.1)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: const Text("Add Review"),
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
          horizontal: W(0.05),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            hSizedBox(0.01),
            Text(
              "Name",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            hSizedBox(0.015),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: H(0.065),
                color: AppColor.grey.withOpacity(0.2),
                child: TextField(
                  cursorColor: AppColor.purple,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: W(0.03),
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
            hSizedBox(0.03),
            Text(
              "How was your experience ?",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            hSizedBox(0.015),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: H(0.25),
                color: AppColor.grey.withOpacity(0.2),
                child: TextField(
                  maxLines: 10,
                  cursorColor: AppColor.purple,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: W(0.03),
                      vertical: H(0.01),
                    ),
                    hintText: "Describe your experience?",
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
            hSizedBox(0.03),
            Text(
              "Review",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            hSizedBox(0.02),
            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 30,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CommonBottomButton(
        onTap: () {},
        title: "Submit Review",
      ),
    );
  }
}

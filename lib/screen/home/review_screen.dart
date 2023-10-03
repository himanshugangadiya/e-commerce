import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/screen/home/add_review_screen.dart';
import 'package:e_commerce_app/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import '../../utils/height_width.dart';
import '../../widget/common_back_button.dart';

class ReviewScreen extends StatefulWidget {
  final String id;
  final int reviewLength;
  final List reviewList;
  const ReviewScreen(
      {super.key,
      required this.id,
      required this.reviewLength,
      required this.reviewList});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  List reviewReverseData = [];
  List averageList = [];

  reverseReview() {
    reviewReverseData = List.from(widget.reviewList.reversed);
  }

  double averageRating() {
    reviewReverseData.forEach((element) {
      averageList.add(element["rating"]);
    });
    var sum = averageList.reduce((a, b) => a + b);

    log((sum / averageList.length).toString());
    return sum / averageList.length;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reverseReview();
    averageRating();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("review screen build method run ========================== ");
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, H(0.1)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: const Text("Reviews"),
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
          horizontal: W(0.05),
        ),
        child: Visibility(
          visible: widget.reviewLength != 0,
          replacement: const Center(
            child: Text("No Review"),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.reviewList.length} Reviews",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(fontSize: 17),
                      ),
                      hSizedBox(0.005),
                      Row(
                        children: [
                          Text(
                            averageRating().toStringAsFixed(1),
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(fontSize: 15, color: AppColor.grey),
                          ),
                          wSizedBox(0.01),
                          RatingBar.builder(
                            initialRating:
                                double.parse(averageRating().toString()),
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            ignoreGestures: true,
                            itemCount: 5,
                            itemSize: 15,
                            unratedColor: AppColor.grey.withOpacity(0.4),
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
                    ],
                  ),

                  /// add review button
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddReviewScreen(
                            id: widget.id.toString(),
                            reviewsList: widget.reviewList,
                          ),
                        ),
                      );
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    color: AppColor.orange,
                    elevation: 0.0,
                    height: H(0.05),
                    child: const Text(
                      "Add Review",
                      style: TextStyle(color: AppColor.white),
                    ),
                  ),
                ],
              ),

              hSizedBox(0.01),

              /// reviews listview
              Expanded(
                child: ListView.builder(
                  itemCount: reviewReverseData.length,
                  padding: EdgeInsets.symmetric(
                    vertical: H(0.02),
                  ),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    var reviewsData = reviewReverseData[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: H(0.03),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipOval(
                                child: Container(
                                  height: H(0.05),
                                  width: H(0.05),
                                  color: Colors.grey.withOpacity(0.2),
                                  alignment: Alignment.center,
                                  child: Text(
                                    reviewsData["name"]
                                        .toString()[0]
                                        .toUpperCase(),
                                  ),
                                ),
                              ),
                              wSizedBox(0.03),
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            reviewsData["name"].toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium!
                                                .copyWith(fontSize: 16),
                                            maxLines: 1,
                                            overflow: TextOverflow.visible,
                                          ),
                                        ),
                                        Text(
                                          reviewsData["rating"].toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium!
                                              .copyWith(fontSize: 16),
                                        )
                                      ],
                                    ),
                                    hSizedBox(0.003),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            DateFormat.yMMMMd()
                                                .format(
                                                  DateTime
                                                      .fromMillisecondsSinceEpoch(
                                                    reviewsData["date"]
                                                        .millisecondsSinceEpoch,
                                                  ),
                                                )
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.visible,
                                          ),
                                        ),
                                        RatingBar.builder(
                                          initialRating: reviewsData["rating"],
                                          minRating: 1,
                                          ignoreGestures: true,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 12,
                                          unratedColor:
                                              AppColor.grey.withOpacity(0.4),
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {},
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          hSizedBox(0.005),
                          Text(
                            reviewsData["description"].toString(),
                            style: const TextStyle(
                              color: AppColor.grey,
                              fontSize: 15,
                            ),
                            maxLines: 4,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

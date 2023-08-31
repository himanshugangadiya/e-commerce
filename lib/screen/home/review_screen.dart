import 'package:e_commerce_app/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../utils/height_width.dart';
import '../../widget/common_back_button.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "245 Reviews",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontSize: 17),
                    ),
                    hSizedBox(0.005),
                    Row(
                      children: [
                        Text(
                          "4.8",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(fontSize: 15, color: AppColor.grey),
                        ),
                        wSizedBox(0.01),
                        RatingBar.builder(
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 15,
                          itemBuilder: (context, _) => Icon(
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
                MaterialButton(
                  onPressed: () {},
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
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                padding: EdgeInsets.symmetric(
                  vertical: H(0.02),
                ),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: H(0.03),
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: Container(
                                height: H(0.03),
                                width: H(0.03),
                                color: Colors.grey,
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
                                          "Ronald Richards ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium!
                                              .copyWith(fontSize: 16),
                                          maxLines: 1,
                                          overflow: TextOverflow.visible,
                                        ),
                                      ),
                                      Text(
                                        "4.8",
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
                                          "13 Sep, 2020",
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.visible,
                                        ),
                                      ),
                                      RatingBar.builder(
                                        initialRating: 3,
                                        minRating: 1,
                                        ignoreGestures: true,
                                        direction: Axis.horizontal,
                                        allowHalfRating: false,
                                        itemCount: 5,
                                        itemSize: 12,
                                        itemBuilder: (context, _) => const Icon(
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
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque malesuada eget vitae amet...",
                          style: TextStyle(
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
    );
  }
}

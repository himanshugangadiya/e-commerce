import 'package:e_commerce_app/utils/app_image.dart';
import 'package:e_commerce_app/widget/common_back_button.dart';
import 'package:e_commerce_app/widget/common_bottom_button.dart';
import 'package:e_commerce_app/widget/common_round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:readmore/readmore.dart';

import '../../utils/app_color.dart';
import '../../utils/height_width.dart';

class DetailedScreen extends StatefulWidget {
  const DetailedScreen({super.key});

  @override
  State<DetailedScreen> createState() => _DetailedScreenState();
}

class _DetailedScreenState extends State<DetailedScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      height: H(0.4),
                      width: double.infinity,
                      color: AppColor.grey.withOpacity(0.2),
                      child: Image.asset(
                        AppImage.intro,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: H(0.11),
                        horizontal: W(0.04),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Men's Printed Pullover Hoodie",
                              style: TextStyle(
                                color: AppColor.grey,
                                fontSize: 15,
                              ),
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: W(0.04),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Nike Club Fleece",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(fontSize: 19),
                              maxLines: 2,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                          Text(
                            "\$1189",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(fontSize: 19),
                          ),
                        ],
                      ),
                    ),
                    hSizedBox(0.02),

                    /// listview
                    SizedBox(
                      height: H(0.1),
                      width: double.maxFinite,
                      child: ListView.builder(
                        itemCount: 10,
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: W(0.04)),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                              right: W(0.02),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                height: H(0.01),
                                width: W(0.22), // 22
                                color: Colors.grey,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    hSizedBox(0.01),

                    /// size guide
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: W(0.04),
                        vertical: H(0.015),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Size",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          Text(
                            "Size Guide",
                            style: TextStyle(
                              color: AppColor.grey,
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// size listiview
                    SizedBox(
                      height: H(0.075),
                      width: double.maxFinite,
                      child: ListView.builder(
                        itemCount: 10,
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: W(0.04)),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                              right: W(0.02),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                height: H(0.075),
                                width: W(0.17),
                                color: Colors.grey.withOpacity(0.2),
                                alignment: Alignment.center,
                                child: const Text(
                                  "M",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    hSizedBox(0.005),

                    /// description
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: W(0.04),
                        vertical: H(0.015),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Description",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ],
                      ),
                    ),

                    /// description text
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: W(0.04),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: ReadMoreText(
                              'The Flutter framework builds its layout via the composition of widgets, everything that you construct programmatically is a widget and these are compiled together to create the user interface. ',
                              trimLines: 3,
                              style: TextStyle(color: Colors.grey),
                              colorClickableText: Colors.black,
                              moreStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColor.black,
                              ),
                              lessStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColor.black,
                              ),
                              trimMode: TrimMode.Line,
                              trimCollapsedText: '...Read more',
                              trimExpandedText: ' Less',
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// review
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: W(0.04),
                        vertical: H(0.015),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Reviews",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          const Text(
                            "View All",
                            style: TextStyle(
                              color: AppColor.grey,
                            ),
                          ),
                        ],
                      ),
                    ),

                    ListView.builder(
                      itemCount: 1,
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(
                        horizontal: W(0.04),
                        vertical: H(0.01),
                      ),
                      physics: const NeverScrollableScrollPhysics(),
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
                                      height: H(0.06),
                                      width: H(0.06),
                                      color: Colors.grey,
                                    ),
                                  ),
                                  W(0.03),
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
                                            ),
                                          ],
                                        ),
                                        H(0.003),
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
                              H(0.005),
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

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: W(0.04),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Price",
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                              Text(
                                "(include all Taxes)",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColor.grey,
                                ),
                              )
                            ],
                          ),
                          Text(
                            "\$1195",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                    /////////////////////

                    H(0.02),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 20,
              right: 15,
              left: 15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonBackButton(
                    onTap: () {
                      context.pop();
                    },
                  ),
                  CommonRoundButton(
                    image: AppImage.bag,
                    onTap: () {},
                    padding: 10,
                    height: H(0.055),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: CommonBottomButton(
          onTap: () {},
          title: "Add to Cart",
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // floatingActionButton: CommonBottomButton(
        //   onTap: () {},
        //   title: "Add to Cart",
        // ),
      ),
    );
  }
}

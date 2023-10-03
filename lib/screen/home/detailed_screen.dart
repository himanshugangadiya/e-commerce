import 'package:e_commerce_app/model/product.dart';
import 'package:e_commerce_app/provider/detailed_provider.dart';
import 'package:e_commerce_app/provider/setting_provider.dart';
import 'package:e_commerce_app/screen/home/add_review_screen.dart';
import 'package:e_commerce_app/screen/home/review_screen.dart';
import 'package:e_commerce_app/services/firebase_firestore.dart';
import 'package:e_commerce_app/utils/app_image.dart';
import 'package:e_commerce_app/widget/common_back_button.dart';
import 'package:e_commerce_app/widget/common_bottom_button.dart';
import 'package:e_commerce_app/widget/common_round_button.dart';
import 'package:e_commerce_app/widget/toast_widget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import '../../provider/login_provider.dart';
import '../../utils/app_color.dart';
import '../../utils/height_width.dart';

class DetailedScreen extends StatefulWidget {
  final String id;
  final Map data;
  const DetailedScreen({super.key, required this.id, required this.data});

  @override
  State<DetailedScreen> createState() => _DetailedScreenState();
}

class _DetailedScreenState extends State<DetailedScreen> {
  late Box<Product> box;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    box = Hive.box("product");
  }

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
                    SizedBox(
                      height: H(0.4),
                      width: double.infinity,
                      // color: AppColor.grey.withOpacity(0.2),
                      child: widget.data["product_image"] != ''
                          ? FancyShimmerImage(
                              imageUrl: widget.data["product_image"].toString(),
                              boxFit: BoxFit.contain,
                            )
                          : const Icon(Icons.error),
                    ),

                    /// sub title
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: H(0.011),
                        horizontal: W(0.04),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.data["sub_title"].toString(),
                              style: const TextStyle(
                                color: AppColor.grey,
                                fontSize: 15,
                              ),
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// title & price
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: W(0.04),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.data["title"].toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                    fontSize: 21,
                                  ),
                              maxLines: 2,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                          Text(
                            "₹ ${widget.data["price"].toString()}",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(fontSize: 19),
                          ),
                        ],
                      ),
                    ),
                    hSizedBox(0.02),

                    /// image listview
                    SizedBox(
                      height: H(0.1),
                      width: double.maxFinite,
                      child: ListView.builder(
                        itemCount: widget.data["image_list"].length,
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: W(0.04)),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return ImageListSubWidget(
                            image: widget.data["image_list"][index].toString(),
                          );
                        },
                      ),
                    ),
                    hSizedBox(0.01),

                    /// size
                    const SizeTextWidget(),

                    /// size listview
                    SizedBox(
                      height: H(0.075),
                      width: double.maxFinite,
                      child: Consumer<DetailedProvider>(
                        builder: (context, value, child) => ListView.builder(
                          itemCount: widget.data["size_list"].length,
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
                                child: GestureDetector(
                                  onTap: () {
                                    value.selectedSize(
                                      index,
                                      widget.data["size_list"][index],
                                    );
                                  },
                                  child: Container(
                                    height: H(0.075),
                                    width: W(0.17),
                                    color: value.selectedSizeIndex == index
                                        ? AppColor.purple
                                        : AppColor.grey.withOpacity(0.2),
                                    alignment: Alignment.center,
                                    child: Text(
                                      widget.data["size_list"][index]
                                          .toString()
                                          .toUpperCase(),
                                      style: TextStyle(
                                        color: MediaQuery.platformBrightnessOf(
                                                    context) ==
                                                Brightness.light
                                            ? value.selectedSizeIndex == index
                                                ? AppColor.white
                                                : AppColor.black
                                            : value.selectedSizeIndex == index
                                                ? AppColor.white
                                                : AppColor.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    hSizedBox(0.005),

                    /// description
                    const DescriptionTextWidget(),

                    /// description text
                    DescriptionWidget(
                      description: widget.data["description"].toString(),
                    ),

                    /// review
                    widget.data["review_list"].length != 0
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: W(0.04),
                              vertical: H(0.015),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Reviews",
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ReviewScreen(
                                            id: widget.id,
                                            reviewLength: widget
                                                .data["review_list"].length,
                                            reviewList:
                                                widget.data["review_list"],
                                          ),
                                        ));
                                  },
                                  child: const Text(
                                    "View All",
                                    style: TextStyle(
                                      color: AppColor.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: W(0.04),
                              vertical: H(0.02),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddReviewScreen(
                                        id: widget.id,
                                        reviewsList: widget.data["review_list"],
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: H(0.01),
                                  ),
                                  width: double.infinity,
                                  color: AppColor.grey.withOpacity(0.2),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Add your review",
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ),
                              ),
                            ),
                          ),

                    /// review list
                    if (widget.data["review_list"].length != 0)
                      ListView.builder(
                        itemCount: 1,
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(
                          horizontal: W(0.04),
                          vertical: H(0.01),
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var reviewsData = widget.data["review_list"].last;
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
                                        height: H(0.06),
                                        width: H(0.06),
                                        color: Colors.grey.withOpacity(0.3),
                                        alignment: Alignment.center,
                                        child: Text(
                                          reviewsData["name"][0]
                                              .toString()
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
                                                  reviewsData["name"]
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium!
                                                      .copyWith(fontSize: 16),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.visible,
                                                ),
                                              ),
                                              Text(
                                                reviewsData["rating"]
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium!
                                                    .copyWith(fontSize: 16),
                                              ),
                                            ],
                                          ),
                                          hSizedBox(0.003),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  DateFormat.yMMMMd().format(
                                                    DateTime
                                                        .fromMillisecondsSinceEpoch(
                                                      reviewsData["date"]
                                                          .millisecondsSinceEpoch,
                                                    ),
                                                  ),
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.visible,
                                                ),
                                              ),
                                              RatingBar.builder(
                                                initialRating: double.parse(
                                                  reviewsData["rating"]
                                                      .toString(),
                                                ),
                                                ignoreGestures: true,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemSize: 12,
                                                unratedColor: AppColor.grey
                                                    .withOpacity(0.4),
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

                    /// total price
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
                              const Text(
                                "(include all Taxes)",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColor.grey,
                                ),
                              )
                            ],
                          ),
                          Text(
                            "₹ ${(((widget.data["price"] * widget.data["tax"]) / 100) + widget.data["price"]).toString()}",
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

                    hSizedBox(0.03),
                  ],
                ),
              ),
            ),

            /// button
            Positioned(
              top: 20,
              right: 15,
              left: 15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonBackButton(
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ).animate(
                    delay: const Duration(milliseconds: 1000),
                  ),
                  ClipOval(
                    child: GestureDetector(
                      onTap: () async {
                        dynamic data = widget.data;
                        data["uId"] =
                            Provider.of<LoginProvider>(context, listen: false)
                                .currentUserId();
                        await FireStore.firebaseFirestore
                            .collection("wishlist")
                            .add(data)
                            .then((value) {
                          print(value.toString());
                        }).catchError(
                          (e) => showToast(
                            color: AppColor.red,
                            msg: e.toString(),
                          ),
                        );
                      },
                      child: Container(
                        height: H(0.06),
                        width: H(0.06),
                        color: AppColor.grey.withOpacity(0.2),
                        child: const Icon(Icons.favorite_border_outlined),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Consumer<DetailedProvider>(
          builder: (context, value, child) => CommonBottomButton(
            onTap: () {
              if (value.selectedSizeIndex != null) {
                value.addToCart(
                  widget.data,
                  value.selectedSizeName,
                  context,
                  id: widget.id,
                );
              } else {
                showToast(color: AppColor.red, msg: "Select size to continue");
              }
            },
            title: "Add to Cart",
          ),
        ),
      ),
    );
  }
}

class DescriptionWidget extends StatelessWidget {
  final String description;
  const DescriptionWidget({
    super.key,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    var brightness = View.of(context).platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: W(0.04),
      ),
      child: Row(
        children: [
          Expanded(
            child: ReadMoreText(
              description.toString(),
              trimLines: 3,
              style: const TextStyle(color: Colors.grey),
              colorClickableText: Colors.black,
              moreStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Provider.of<SettingProvider>(context, listen: false)
                        .storage
                        .read("isDark")
                    ? AppColor.white
                    : AppColor.black,
              ),
              lessStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Provider.of<SettingProvider>(context, listen: false)
                        .storage
                        .read("isDark")
                    ? AppColor.white
                    : AppColor.black,
              ),
              trimMode: TrimMode.Line,
              trimCollapsedText: 'Read more',
              trimExpandedText: '...Less',
            ),
          ),
        ],
      ),
    );
  }
}

class DescriptionTextWidget extends StatelessWidget {
  const DescriptionTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}

class SizeTextWidget extends StatelessWidget {
  const SizeTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
        ],
      ),
    );
  }
}

class ImageListSubWidget extends StatelessWidget {
  final String image;
  const ImageListSubWidget({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: W(0.02),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: H(0.01),
          width: W(0.22), // 22
          color: Colors.grey.withOpacity(0.2),
          child: FancyShimmerImage(
            imageUrl: image.toString(),
            boxFit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

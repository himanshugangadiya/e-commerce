import 'package:e_commerce_app/utils/app_image.dart';
import 'package:e_commerce_app/utils/app_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../utils/app_color.dart';
import '../../utils/height_width.dart';
import '../../widget/common_round_button.dart';
import '../../widget/common_view_all_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: H(0.025)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: W(0.05),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonRoundButton(
                      onTap: () {},
                      image: AppImage.menu,
                      padding: 10,
                      height: H(0.055),
                    ),
                    CommonRoundButton(
                      onTap: () {},
                      image: AppImage.bag,
                      padding: 12,
                      height: H(0.055),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: H(0.02),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: W(0.05)),
                child: Text(
                  "Hello",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              SizedBox(
                height: H(0.005),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: W(0.05)),
                child: const Text(
                  "Welcome to Laza",
                  style: TextStyle(color: AppColor.grey),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: H(0.02),
                  horizontal: W(0.05),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: H(0.06),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColor.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: W(0.04),
                              ),
                              child: Image.asset(
                                AppImage.search,
                                height: H(0.025),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: searchController,
                                cursorColor: AppColor.black,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  hintText: "Search...",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    wSizedBox(0.03),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: H(0.06),
                        width: H(0.06),
                        color: AppColor.purple,
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          AppImage.voice,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      hSizedBox(0.02),

                      /// choose brand
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: W(0.05)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Choose brand",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            CommonViewAllButton(
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: H(0.02)),

                      /// brand listview
                      SizedBox(
                        height: H(0.065),
                        child: ListView.builder(
                          itemCount: 10,
                          padding: EdgeInsets.symmetric(horizontal: W(0.05)),
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(right: W(0.03)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: H(0.06),
                                  padding: EdgeInsets.only(
                                    right: W(0.03),
                                  ),
                                  color: AppColor.grey.withOpacity(0.1),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: W(0.02),
                                          vertical: H(0.01),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          child: Container(
                                            height: H(0.06),
                                            width: W(0.1),
                                            color: Colors.white,
                                            padding: const EdgeInsets.all(5),
                                            child: Image.asset(AppImage.search),
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        "Nike",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: H(0.025)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: W(0.05)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "New Arrival",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            CommonViewAllButton(
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),

                      /// new arrival
                      GridView.builder(
                        shrinkWrap: true,
                        itemCount: 10,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.58,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: W(0.05),
                          vertical: H(0.02),
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              await context.push(AppPages.detailedScreen);
                            },
                            child: GridTile(
                              header: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Image.asset(
                                      AppImage.wishlist,
                                      height: H(0.025),
                                    ),
                                  ],
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      height: H(0.24),
                                      color: AppColor.grey.withOpacity(0.1),
                                    ),
                                  ),
                                  hSizedBox(0.005),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: W(0.01)),
                                      child: const Text(
                                        "Nike Sportswear Club Fleece dsjfhhbhfbb fhgbfgbhfhgb",
                                        maxLines: 2,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: H(0.008),
                                        left: W(0.01),
                                      ),
                                      child: const Text(
                                        "99\$",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 17,
                                        ),
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                          // return Container(
                          //   margin: EdgeInsets.symmetric(vertical: 0.5.h),
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       ClipRRect(
                          //         borderRadius: BorderRadius.circular(15),
                          //         child: Container(
                          //           height: 24.0.h,
                          //           color: Colors.red,
                          //         ),
                          //       ),
                          //       SizedBox(
                          //         height: 0.5.h,
                          //       ),
                          //       Expanded(
                          //         child: Padding(
                          //           padding: EdgeInsets.only(left: 1.0.w),
                          //           child: const Text(
                          //             "Nike Sportswear Club Fleece dsjfhhbhfbb fhgbfgbhfhgb",
                          //             maxLines: 2,
                          //           ),
                          //         ),
                          //       ),
                          //       Expanded(
                          //         child: Padding(
                          //           padding: EdgeInsets.only(top: 0.8.h, left: 1.0.w),
                          //           child: Text(
                          //             "99\$",
                          //             style: TextStyle(
                          //               fontWeight: FontWeight.w700,
                          //               fontSize: 17.sp,
                          //             ),
                          //             maxLines: 1,
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // );
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

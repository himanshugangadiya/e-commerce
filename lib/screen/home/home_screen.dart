import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/provider/home_provider.dart';
import 'package:e_commerce_app/screen/home/all_brands_screen.dart';
import 'package:e_commerce_app/screen/home/brand_screen.dart';
import 'package:e_commerce_app/screen/home/detailed_screen.dart';
import 'package:e_commerce_app/screen/home/mic_screen.dart';
import 'package:e_commerce_app/screen/home/search_screen.dart';
import 'package:e_commerce_app/utils/app_image.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../../utils/app_color.dart';
import '../../widget/common_view_all_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: height * (0.025)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.01,
              ),
              const HelloTextWidget(),
              SizedBox(
                height: height * 0.005,
              ),
              const WelcomeToLazaWidget(),

              /// search
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: height * (0.02),
                  horizontal: width * (0.05),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const SearchScreen(spokenText: ""),
                            ),
                          );
                        },
                        child: Container(
                          height: height * (0.06),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColor.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: width * (0.04),
                                ),
                                child: Image.asset(
                                  AppImage.search,
                                  height: height * (0.025),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  enabled: false,
                                  cursorColor: AppColor.black,
                                  onChanged: (val) {
                                    Provider.of<HomeProvider>(
                                      context,
                                      listen: false,
                                    ).searchFilter(val);
                                  },
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
                    ),
                    SizedBox(
                      width: width * 0.03,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MicScreen(),
                            ),
                          );
                        },
                        child: Container(
                          height: height * (0.06),
                          width: height * (0.06),
                          color: AppColor.purple,
                          padding: const EdgeInsets.all(10),
                          child: Image.asset(
                            AppImage.voice,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(
                height: height * 0.02,
              ),

              /// choose brand
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * (0.05)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Choose brand",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    CommonViewAllButton(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AllBrandsScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),

              /// brand listview
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("product_data")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(
                        height: height * (0.065),
                        child: ListView.builder(
                          itemCount: 5,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(right: width * (0.03)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: width * 0.15,
                                  padding: EdgeInsets.only(
                                    right: width * (0.05),
                                    left: width * (0.05),
                                  ),
                                  alignment: Alignment.center,
                                  color: AppColor.grey.withOpacity(0.15),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      Set data = {};
                      List brandList = [];
                      snapshot.data!.docs.forEach((element) {
                        data.add(element["brand"].toString());
                      });
                      brandList = data.toList();

                      return SizedBox(
                        height: height * (0.065),
                        child: ListView.builder(
                          itemCount: brandList.length,
                          padding:
                              EdgeInsets.symmetric(horizontal: width * (0.05)),
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(right: width * (0.03)),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BrandScreen(
                                        brandName: brandList[index],
                                      ),
                                    ),
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      right: width * (0.05),
                                      left: width * (0.05),
                                    ),
                                    alignment: Alignment.center,
                                    color: AppColor.grey.withOpacity(0.15),
                                    child: Text(
                                      "${brandList[index][0].toString().toUpperCase()}${brandList[index].toString().substring(1).toLowerCase()}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  }
                },
              ),

              SizedBox(height: height * (0.025)),

              /// new arrival
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * (0.05)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
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
              SizedBox(height: height * (0.01)),

              /// new arrival listview
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("product_data")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: AppColor.black,
                            ),
                          );
                        } else {
                          List productList = snapshot.data!.docs;
                          return productList.isNotEmpty
                              ? GridView.builder(
                                  itemCount: productList.length,
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: 0.62,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: width * (0.05),
                                    vertical: height * (0.02),
                                  ),
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    dynamic data = productList[index];
                                    return HomeSubWidget(
                                      id: productList[index].id.toString(),
                                      data: data.data(),
                                      productId: productList[index]
                                          ["product_id"],
                                    );
                                  },
                                )
                              : const Center(
                                  child: Text("No data found"),
                                );
                        }
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeSubWidget extends StatelessWidget {
  final dynamic data;
  final String id;
  final num productId;
  const HomeSubWidget({
    super.key,
    this.data,
    required this.id,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return GestureDetector(
      onTap: () async {
        Map product = data;

        debugPrint(product.toString());
      },
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailedScreen(
                  id: id.toString(),
                  productId: productId,
                  data: data,
                ),
              ),
            );
/*            .animate().scaleXY(
            duration: const Duration(milliseconds: 600),
            curve: Curves.linearToEaseOut,
            ),*/
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Hero(
                tag: productId.toString(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                      height: height * (0.24),
                      width: double.infinity,
                      color: AppColor.grey.withOpacity(0.1),
                      child: FancyShimmerImage(
                        imageUrl: data["product_image"].toString(),
                        boxFit: BoxFit.cover,
                      )),
                ),
              ),
              SizedBox(
                height: height * 0.005,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: width * (0.01),
                ),
                child: Text(
                  data["title"].toString(),
                  softWrap: true,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                ),
              ),
              SizedBox(
                height: height * 0.005,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: width * (0.01),
                ),
                child: Text(
                  "₹ ${data["price"].toString()}",
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WelcomeToLazaWidget extends StatelessWidget {
  const WelcomeToLazaWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * (0.05)),
      child: const Text(
        "Welcome to Laza",
        style: TextStyle(color: AppColor.grey),
      ),
    );
  }
}

class HelloTextWidget extends StatelessWidget {
  const HelloTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * (0.05)),
      child: Text(
        "Hello",
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}

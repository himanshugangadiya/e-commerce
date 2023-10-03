import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/screen/home/brand_screen.dart';
import 'package:flutter/material.dart';

import '../../utils/app_color.dart';
import '../../utils/height_width.dart';
import '../../widget/common_back_button.dart';
import 'home_screen.dart';

class AllBrandsScreen extends StatefulWidget {
  const AllBrandsScreen({super.key});

  @override
  State<AllBrandsScreen> createState() => _AllBrandsScreenState();
}

class _AllBrandsScreenState extends State<AllBrandsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          double.infinity,
          H(0.1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: const Text("All Brands"),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: W(0.05),
            ),
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
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColor.black,
                      ),
                    );
                  } else {
                    Set data = {};
                    List brandList = [];
                    snapshot.data!.docs.forEach((element) {
                      data.add(element["brand"].toString());
                    });
                    brandList = data.toList();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${brandList.length} total brands",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        const Text(
                          "Available in Stock",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColor.grey,
                          ),
                        ),
                      ],
                    );
                  }
                }
              },
            ),
          ),
          Expanded(
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
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColor.black,
                      ),
                    );
                  } else {
                    Set data = {};
                    List brandList = [];
                    snapshot.data!.docs.forEach((element) {
                      data.add(element["brand"].toString());
                    });
                    brandList = data.toList();

                    return brandList.isNotEmpty
                        ? GridView.builder(
                            itemCount: brandList.length,
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: W(0.05),
                              vertical: H(0.02),
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return GestureDetector(
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
                                child: Container(
                                  height: H(0.1),
                                  width: H(0.1),
                                  color: AppColor.grey.withOpacity(0.2),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${brandList[index][0].toString().toUpperCase()}${brandList[index].toString().substring(1).toLowerCase()}",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
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
        ],
      ),
    );
  }
}

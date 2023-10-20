import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../utils/app_color.dart';
 import '../../widget/common_back_button.dart';
import 'home_screen.dart';

class BrandScreen extends StatefulWidget {
  final String brandName;
  const BrandScreen({super.key, required this.brandName});

  @override
  State<BrandScreen> createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          double.infinity,
          height*(0.1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: Text(widget.brandName.toString()),
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
              horizontal: width*(0.05),
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
                    List data = snapshot.data!.docs;
                    List productList = data
                        .where((element) =>
                            element["brand"] == widget.brandName.toString())
                        .toList();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${productList.length} items",
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
                    List data = snapshot.data!.docs;
                    List productList = data
                        .where(
                          (element) =>
                              element["brand"] == widget.brandName.toString(),
                        )
                        .toList();

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
                              horizontal: width*(0.05),
                              vertical: height*(0.02),
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              dynamic data = productList[index];
                              return HomeSubWidget(
                                id: productList[index].id.toString(),
                                data: data.data(),
                                productId: productList[index]["product_id"],
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

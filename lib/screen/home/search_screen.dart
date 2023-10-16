import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/home_provider.dart';
import '../../utils/app_color.dart';
import '../../utils/app_image.dart';
import '../../utils/height_width.dart';
import 'home_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: W(0.02),
            vertical: H(0.01),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                              cursorColor: AppColor.purple,
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
                ],
              ),
              SizedBox(
                height: H(0.03),
              ),
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
                          List response = snapshot.data!.docs;
                          List productList = response
                              .where(
                                (element) => element["title"]
                                    .toString()
                                    .toLowerCase()
                                    .contains(Provider.of<HomeProvider>(context)
                                        .searchingText
                                        .toString()
                                        .toLowerCase()),
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
                                    horizontal: W(0.03),
                                    vertical: H(0.02),
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/provider/create_address_provider.dart';
import 'package:e_commerce_app/provider/login_provider.dart';
import 'package:e_commerce_app/screen/cart/create_address_screen.dart';
import 'package:e_commerce_app/widget/common_bottom_button.dart';
import 'package:flutter/material.dart';
 import 'package:provider/provider.dart';

import '../../utils/app_color.dart';
 import '../../widget/common_back_button.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CreateAddressProvider>().addressBoxInitialize();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(
            double.infinity,
            height* 0.1,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              title: const Text("Address"),
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
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateAddressScreen(),
                  ),
                );
              },
              child: Container(
                height: height*0.06,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: width*(0.04)),
                color: AppColor.grey.withOpacity(0.2),
                alignment: Alignment.center,
                child: const Text(
                  "Add new address",
                ),
              ),
            ),
             SizedBox(
              height: height*0.01,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("user_address")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          snapshot.error.toString(),
                        ),
                      );
                    } else {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                              backgroundColor: AppColor.purple),
                        );
                      } else {
                        List response = snapshot.data!.docs;
                        List addressData = response.isNotEmpty
                            ? response
                                .where((element) =>
                                    element["uId"] ==
                                    Provider.of<LoginProvider>(context)
                                        .currentUserId())
                                .toList()
                            : [];
                        return addressData.isNotEmpty
                            ? Consumer<CreateAddressProvider>(
                                builder: (context, value, child) =>
                                    ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: addressData.length,
                                  itemBuilder: (context, index) {
                                    var data = addressData[index].data();
                                    return RadioListTile(
                                      value: index,
                                      groupValue: value.selectedAddressIndex,
                                      onChanged: (ind) {
                                        value.addressIndex(index, data);
                                      },
                                      subtitle: Text(
                                        "${data["city"]}, ${data["country"]}",
                                        maxLines: 1,
                                      ),
                                      title: Text(
                                        data["address"].toString(),
                                        maxLines: 1,
                                      ),
                                      secondary: IconButton(
                                        onPressed: () {
                                          value.deleteAddress(
                                            addressData[index],
                                            addressData[index].id,
                                          );
                                        },
                                        icon: const Icon(Icons.delete),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : SizedBox(
                                height: height*0.5,
                                child: const Center(
                                  child: Text("Please add new address"),
                                ),
                              );
                      }
                    }
                  },
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: CommonBottomButton(
          onTap: () {
            context.read<CreateAddressProvider>().savePrimaryAddress(context);
          },
          title: "Save primary Address",
        ),
      ),
    );
  }
}

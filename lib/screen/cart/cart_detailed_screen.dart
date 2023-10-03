import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/provider/cart_detailed_provider.dart';
import 'package:e_commerce_app/provider/create_address_provider.dart';
import 'package:e_commerce_app/provider/login_provider.dart';
import 'package:e_commerce_app/screen/cart/address_screen.dart';
import 'package:e_commerce_app/screen/home/order_confirmed_screen.dart';
import 'package:e_commerce_app/utils/app_color.dart';
import 'package:e_commerce_app/utils/app_image.dart';
import 'package:e_commerce_app/widget/common_bottom_button.dart';
import 'package:e_commerce_app/widget/toast_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../utils/height_width.dart';
import '../../widget/common_add_remove_button.dart';
import '../../widget/common_arrow_forward_button.dart';
import '../../widget/common_back_button.dart';
import 'create_address_screen.dart';

class CartDetailedScreen extends StatefulWidget {
  final String id;
  const CartDetailedScreen({super.key, required this.id});

  @override
  State<CartDetailedScreen> createState() => _CartDetailedScreenState();
}

class _CartDetailedScreenState extends State<CartDetailedScreen> {
  Razorpay razorpay = Razorpay();
  String description = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CreateAddressProvider>(context, listen: false)
        .addressBoxInitialize();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    description = '';
    showToast(color: AppColor.green, msg: "Payment successful");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const OrderConfirmedScreen(),
        ),
        (route) => false);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    showToast(color: AppColor.red, msg: "Payment unsuccessful");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(
        "cart detailed screen build ======================================= ");
    return WillPopScope(
      onWillPop: () async {
        Provider.of<CartDetailedProvider>(context, listen: false).clearData();
        return true;
      },
      child: Scaffold(
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
              title: const Text("Orders summary"),
              centerTitle: true,
              leading: Padding(
                padding: const EdgeInsets.all(5.0),
                child: CommonBackButton(
                  onTap: () {
                    Provider.of<CartDetailedProvider>(context, listen: false)
                        .clearData();
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
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("cart_data")
                  .doc(widget.id)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: AppColor.black),
                    );
                  } else {
                    dynamic data = snapshot.data;
                    description = data["title"];
                    return data != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// order details
                              Padding(
                                padding: EdgeInsets.only(bottom: H(0.02)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    height: H(0.16),
                                    color: AppColor.grey.withOpacity(0.1),
                                    padding: const EdgeInsets.all(12),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Container(
                                            height: double.infinity,
                                            width: W(0.28),
                                            color: Colors.white,
                                            child: data["product_image"] != ''
                                                ? Image.network(
                                                    data!["product_image"]
                                                        .toString(),
                                                    fit: BoxFit.cover,
                                                  )
                                                : const Center(
                                                    child: Text("him"),
                                                  ),
                                          ),
                                        ),
                                        wSizedBox(0.03),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  hSizedBox(0.005),
                                                  Text(
                                                    data["title"].toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displayMedium!
                                                        .copyWith(fontSize: 19),
                                                    maxLines: 2,
                                                  ),
                                                  hSizedBox(0.005),
                                                  Text(
                                                    "Size : ${data["selected_size"].toString().toUpperCase()}",
                                                    style: const TextStyle(
                                                        color: AppColor.grey),
                                                    maxLines: 2,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Consumer<
                                                      CartDetailedProvider>(
                                                    builder: (context, value,
                                                            child) =>
                                                        Row(
                                                      children: [
                                                        CommonAddRemoveButton(
                                                          onTap: () {
                                                            value.subCart();
                                                          },
                                                          height: H(0.03),
                                                          color: AppColor.white,
                                                          icon: const Icon(
                                                            Icons.remove,
                                                            size: 20,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal: W(0.03),
                                                          ),
                                                          child: Text(
                                                            value.cart
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        CommonAddRemoveButton(
                                                          onTap: () {
                                                            value.addCart();
                                                          },
                                                          height: H(0.03),
                                                          color: AppColor.white,
                                                          icon: const Icon(
                                                            Icons.add,
                                                            size: 20,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Text(
                                                    "₹ ${data["price"].toString()}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displayMedium!
                                                        .copyWith(fontSize: 15),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              /// delivery address

                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: H(0.01),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Delivery Address",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium,
                                    ),
                                    CommonArrowForwardButton(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const AddressScreen(),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),

                              /// address

                              Consumer<CreateAddressProvider>(
                                  builder: (context, value, child) {
                                var data = value.address.get("primaryAddress");
                                return data != null && data.isNotEmpty
                                    ? Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Container(
                                              height: H(0.07),
                                              width: H(0.07),
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                    AppImage.location,
                                                  ),
                                                ),
                                              ),
                                              child: const Icon(
                                                Icons.location_on_outlined,
                                                color: AppColor.orange,
                                                size: 30,
                                              ),
                                            ),
                                          ),
                                          wSizedBox(0.03),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  data["address"].toString(),
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  maxLines: 1,
                                                ),
                                                hSizedBox(0.005),
                                                Text(
                                                  "${data["city"]}, ${data["country"]}",
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    color: AppColor.grey,
                                                  ),
                                                  maxLines: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                          CommonAddRemoveButton(
                                            onTap: () {},
                                            height: H(0.03),
                                            color: AppColor.green,
                                            icon: const Icon(
                                              Icons.done,
                                              color: AppColor.white,
                                              size: 15,
                                            ),
                                          ),
                                        ],
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const AddressScreen(),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            height: H(0.06),
                                            width: double.infinity,
                                            color:
                                                AppColor.grey.withOpacity(0.2),
                                            alignment: Alignment.center,
                                            child: const Text(
                                              "Add new address",
                                            ),
                                          ),
                                        ),
                                      );
                              }),

                              SizedBox(height: H(0.015)),

                              /// order info
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(vertical: H(0.015)),
                                child: Text(
                                  "Order info",
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                              ),

                              Consumer<CartDetailedProvider>(
                                builder: (context, value, child) => Column(
                                  children: [
                                    /// price
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Price",
                                          style:
                                              TextStyle(color: AppColor.grey),
                                        ),
                                        Text(
                                          value
                                              .priceIntoCart(
                                                  data["price"], value.cart)
                                              .toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: H(0.01)),

                                    /// discount
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Discount(${data["discount"]}%)",
                                          style: const TextStyle(
                                              color: AppColor.grey),
                                        ),
                                        Text(
                                          "- ${value.discount(data["price"], data["discount"]).toStringAsFixed(2)}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: H(0.01)),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Tax(${data["tax"].toString()}%)",
                                          style: const TextStyle(
                                              color: AppColor.grey),
                                        ),
                                        Text(
                                          "${value.tax(data["price"], value.cart, data["tax"]).toStringAsFixed(2)}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: H(0.01)),

                                    /// shipping cost
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Shipping cost",
                                          style:
                                              TextStyle(color: AppColor.grey),
                                        ),
                                        Visibility(
                                          visible: data["shipping_cost"] != 0,
                                          replacement: const Text(
                                            "Free",
                                            style: TextStyle(
                                                color: AppColor.purple),
                                          ),
                                          child: Text(
                                            "${data["shipping_cost"]}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(),

                                    /// total
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Total",
                                          style:
                                              TextStyle(color: AppColor.grey),
                                        ),
                                        Text(
                                          "₹ ${value.total(data["price"], data["tax"], data["discount"], value.cart, data["shipping_cost"]).toStringAsFixed(2)}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : const Center(
                            child: Text("No data found"),
                          );
                  }
                }
              },
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: CommonBottomButton(
          onTap: () {
            dynamic addressData =
                Provider.of<CreateAddressProvider>(context, listen: false)
                    .address
                    .get("primaryAddress");
            if (addressData != null && addressData.isNotEmpty) {
              var options = {
                'key': 'rzp_test_LDn42h0RDr04LB',
                'amount':
                    Provider.of<CartDetailedProvider>(context, listen: false)
                            .totalPrice *
                        100, //in the smallest currency sub-unit.
                'name': "Laza",
                'description': description,
                'timeout': 60, // in seconds
              };
              razorpay.open(options);
            } else {
              showToast(color: AppColor.red, msg: "Add deliver address");
            }
          },
          title: "Payment",
        ),
      ),
    );
  }
}

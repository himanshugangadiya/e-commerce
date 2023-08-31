import 'package:e_commerce_app/utils/app_color.dart';
import 'package:e_commerce_app/utils/app_image.dart';
import 'package:e_commerce_app/widget/common_bottom_button.dart';
import 'package:flutter/material.dart';

import '../../utils/height_width.dart';
import '../../widget/common_add_remove_button.dart';
import '../../widget/common_arrow_forward_button.dart';
import '../../widget/common_back_button.dart';

class OrdersSummaryScreen extends StatefulWidget {
  const OrdersSummaryScreen({super.key});

  @override
  State<OrdersSummaryScreen> createState() => _OrdersSummaryScreenState();
}

class _OrdersSummaryScreenState extends State<OrdersSummaryScreen> {
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
            title: const Text("Orders summary"),
            centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.all(5.0),
              child: CommonBackButton(
                onTap: () {},
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
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: double.infinity,
                          width: W(0.28),
                          color: Colors.white,
                          child: Image.asset(
                            AppImage.intro,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      wSizedBox(0.03),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                hSizedBox(0.005),
                                Text(
                                  "Men's Tie-Dye T-Shirt Nike Sportswear",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(fontSize: 16),
                                  maxLines: 2,
                                ),
                                hSizedBox(0.005),
                                const Text(
                                  "\$45",
                                  style: TextStyle(color: AppColor.grey),
                                  maxLines: 1,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CommonAddRemoveButton(
                                      onTap: () {},
                                      height: H(0.03),
                                      color: AppColor.white,
                                      icon: const Icon(
                                        Icons.remove,
                                        size: 20,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: W(0.03),
                                      ),
                                      child: const Text(
                                        "1",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    CommonAddRemoveButton(
                                      onTap: () {},
                                      height: H(0.03),
                                      color: AppColor.white,
                                      icon: const Icon(Icons.add, size: 20),
                                    ),
                                  ],
                                ),
                                CommonAddRemoveButton(
                                  onTap: () {},
                                  height: H(0.03),
                                  color: AppColor.white,
                                  icon: Icon(
                                    Icons.delete_outline,
                                    color: AppColor.grey,
                                    size: 20,
                                  ),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Delivery Address",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  CommonArrowForwardButton(
                    onTap: () {},
                  ),
                ],
              ),
            ),

            /// address
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Chhatak, Sunamgonj 12/8AB",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                      ),
                      hSizedBox(0.005),
                      Text(
                        "Surat",
                        style: TextStyle(
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
            ),

            SizedBox(height: H(0.015)),

            /// order info
            Padding(
              padding: EdgeInsets.symmetric(vertical: H(0.015)),
              child: Text(
                "Order info",
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),

            /// price
            PriceWidget(),
            SizedBox(height: H(0.01)),

            /// discount
            DiscountWidget(),
            SizedBox(height: H(0.01)),

            /// shipping cost
            ShippingCostWidget(),
            Divider(),

            /// total
            TotalWidget(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CommonBottomButton(
        onTap: () {},
        title: "Payment",
      ),
    );
  }
}

class PriceWidget extends StatelessWidget {
  const PriceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Price",
          style: TextStyle(color: AppColor.grey),
        ),
        Text(
          "\$114",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class TotalWidget extends StatelessWidget {
  const TotalWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Total",
          style: TextStyle(color: AppColor.grey),
        ),
        Text(
          "\$125",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class ShippingCostWidget extends StatelessWidget {
  const ShippingCostWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Shipping cost",
          style: TextStyle(color: AppColor.grey),
        ),
        Text(
          "\$11",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class DiscountWidget extends StatelessWidget {
  const DiscountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Discount(2%)",
          style: TextStyle(color: AppColor.grey),
        ),
        Text(
          "\$2.4",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

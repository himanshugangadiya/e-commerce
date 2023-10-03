import 'package:e_commerce_app/utils/app_color.dart';
import 'package:e_commerce_app/utils/app_image.dart';
import 'package:e_commerce_app/widget/common_bottom_button.dart';
import 'package:flutter/material.dart';

import '../../utils/height_width.dart';
import '../../widget/common_back_button.dart';
import '../main_screen.dart';

class OrderConfirmedScreen extends StatefulWidget {
  const OrderConfirmedScreen({super.key});

  @override
  State<OrderConfirmedScreen> createState() => _OrderConfirmedScreenState();
}

class _OrderConfirmedScreenState extends State<OrderConfirmedScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("sign up screen build method run =================== ");
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: W(0.05),
                vertical: H(0.04),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  hSizedBox(0.03),
                  Center(
                    child: Image.asset(
                      AppImage.orderConfirmed,
                      fit: BoxFit.cover,
                      height: H(0.3),
                    ),
                  ),
                  hSizedBox(0.04),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Order Confirmed!",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  hSizedBox(0.02),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Your order has been confirmed, we will send you confirmation email shortly.",
                      style: TextStyle(
                        color: AppColor.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: W(0.05),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          AppColor.grey.withOpacity(0.1),
                        ),
                      ),
                      child: const Text(
                        "Go to orders",
                        style: TextStyle(color: AppColor.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: CommonBottomButton(
          onTap: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainScreen(),
                ),
                (route) => false);
          },
          title: "Continue Shopping",
        ),
      ),
    );
  }
}

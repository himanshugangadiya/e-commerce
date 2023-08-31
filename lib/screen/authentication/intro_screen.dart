import 'package:e_commerce_app/utils/app_color.dart';
import 'package:e_commerce_app/utils/app_image.dart';
import 'package:e_commerce_app/utils/app_route.dart';
import 'package:e_commerce_app/utils/height_width.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.purple,
        body: Stack(
          children: [
            Image.asset(
              AppImage.intro,
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.all(15),
                padding: EdgeInsets.symmetric(
                  horizontal: W(0.04),
                  vertical: H(0.03),
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Look Good, Feel Good",
                      style: Theme.of(context).textTheme.headlineSmall!,
                      textAlign: TextAlign.center,
                    ),
                    hSizedBox(0.01),
                    const Text(
                      "Create your individual & unique style and look amazing everyday.",
                      style: TextStyle(
                        color: AppColor.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    hSizedBox(0.03),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              context.push(AppPages.socialScreen);
                            },
                            child: Container(
                              height: H(0.07),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColor.grey.withOpacity(0.2),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Men",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: AppColor.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ),
                        ),
                        wSizedBox(0.03),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              context.push(AppPages.socialScreen);
                            },
                            child: Container(
                              height: H(0.07),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColor.purple,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Women",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: AppColor.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    hSizedBox(0.02),
                    GestureDetector(
                      onTap: () {
                        context.push(AppPages.socialScreen);
                      },
                      child: Text(
                        "Skip",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColor.grey,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

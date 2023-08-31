import 'package:flutter/material.dart';

import '../utils/app_color.dart';

class CommonRoundButton extends StatelessWidget {
  final String image;
  final VoidCallback onTap;
  final double padding;
  final double height;
  const CommonRoundButton({
    super.key,
    required this.image,
    required this.onTap,
    required this.padding,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: height,
          width: height,
          color: AppColor.grey.withOpacity(0.2),
          padding: EdgeInsets.all(padding),
          child: Image.asset(
            image,
            fit: BoxFit.cover,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

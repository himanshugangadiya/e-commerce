import 'package:e_commerce_app/utils/height_width.dart';
import 'package:flutter/material.dart';

import '../utils/app_color.dart';

class CommonBackButton extends StatelessWidget {
  final VoidCallback onTap;
  const CommonBackButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: H(0.06),
          width: H(0.06),
          color: AppColor.grey.withOpacity(0.2),
          child: const Icon(Icons.arrow_back),
        ),
      ),
    );
  }
}

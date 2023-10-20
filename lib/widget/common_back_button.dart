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
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return ClipOval(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: height * 0.06,
          width: height * 0.06,
          color: AppColor.grey.withOpacity(0.2),
          child: const Icon(Icons.arrow_back),
        ),
      ),
    );
  }
}

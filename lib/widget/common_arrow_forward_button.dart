import 'package:e_commerce_app/utils/height_width.dart';
import 'package:flutter/material.dart';

class CommonArrowForwardButton extends StatelessWidget {
  final VoidCallback onTap;
  const CommonArrowForwardButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: W(0.1),
        height: H(0.04),
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.arrow_forward,
          size: 20,
        ),
      ),
    );
  }
}

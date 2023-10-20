import 'package:flutter/material.dart';

class CommonArrowForwardButton extends StatelessWidget {
  final VoidCallback onTap;
  const CommonArrowForwardButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width * 0.1,
        height: height * 0.04,
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.arrow_forward,
          size: 20,
        ),
      ),
    );
  }
}

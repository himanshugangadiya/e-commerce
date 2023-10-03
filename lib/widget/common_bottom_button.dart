import 'package:e_commerce_app/utils/height_width.dart';
import 'package:flutter/material.dart';

class CommonBottomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;

  const CommonBottomButton({
    super.key,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: W(0.05),
        vertical: H(0.02),
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: onTap,
              child: Text(title.toString()),
            ),
          ),
        ],
      ),
    );
  }
}

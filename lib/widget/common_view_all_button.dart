import 'package:flutter/material.dart';

class CommonViewAllButton extends StatelessWidget {
  final VoidCallback onTap;
  const CommonViewAllButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        "View All",
        style: TextStyle(
          fontSize: 15,
          // fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

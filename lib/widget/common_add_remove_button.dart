import 'package:flutter/material.dart';

class CommonAddRemoveButton extends StatelessWidget {
  final VoidCallback onTap;
  final Icon icon;
  final Color color;
  final double height;
  const CommonAddRemoveButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.color,
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
          color: color,
          alignment: Alignment.center,
          child: icon,
        ),
      ),
    );
  }
}

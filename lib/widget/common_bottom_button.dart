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
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: height * 0.02,
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

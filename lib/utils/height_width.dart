import 'package:e_commerce_app/main.dart';
import 'package:flutter/material.dart';

H(double height) {
  return height * size.height;
}

W(double width) {
  return width * size.width;
}

Widget hSizedBox(double height) {
  return SizedBox(
    height: height * size.height,
  );
}

Widget wSizedBox(double width) {
  return SizedBox(
    width: width * size.width,
  );
}

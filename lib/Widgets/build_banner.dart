import 'package:flutter/material.dart';

Widget buildBanner(String image) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(10),
      child: Image.asset(image, fit: BoxFit.cover),
    ),
  );
}

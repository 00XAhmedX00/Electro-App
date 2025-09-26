import 'package:flutter/material.dart';

class Category extends StatelessWidget {
   final category;
   Category({super.key , required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        centerTitle: true,
      ),
    );
  }
}
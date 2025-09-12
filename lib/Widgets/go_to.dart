import 'package:flutter/material.dart';

goTo({required BuildContext context, required Widget page}) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => page),
    (route) => false,
  );
}

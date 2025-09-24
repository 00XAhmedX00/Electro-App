import 'package:flutter/material.dart';

goTo({required BuildContext context, required Widget page , bool routed = false}) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => page),
    (route) => routed,
  );
}

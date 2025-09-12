import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget chatButton({required String message}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(fixedSize: Size(double.maxFinite, 20)),
    onPressed: () {},
    child: Text(
      message,
      style: GoogleFonts.voces(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
  );
}

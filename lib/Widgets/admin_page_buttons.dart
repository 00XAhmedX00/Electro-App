import 'package:electrocart/Widgets/go_to.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget adminPageButton({
  required context,
  required String text,
  required Widget page,
}) {
  return InkWell(
    onTap: () {
      goTo(context: context, page: page, routed: true);
    },
    child: Container(
      width: 130,
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(78, 76, 175, 79),
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [BoxShadow(color: Colors.black26)],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: GoogleFonts.aBeeZee(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    ),
  );
}

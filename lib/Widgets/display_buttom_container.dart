import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> displayModalBottomSheet({
  required context,
  required String message,
  required String header,
}) {
  return showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Center(
        child: Container(
          height: 500,
          padding: const EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    header,
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Divider(),
                  const SizedBox(height: 30),
                  Text(message, style: GoogleFonts.poppins(fontSize: 18)),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

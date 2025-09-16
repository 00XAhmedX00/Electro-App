import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget botAnswer({required String answer}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Container(
          width: 200,
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
              topLeft: Radius.circular(10),
            ),
            border: Border.all(color: Colors.purple, width: 2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              answer,
              style: GoogleFonts.voces(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      const SizedBox(width: 10),
      Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.purple, width: 2),
        ),
        child: Icon(Icons.support_agent_outlined, size: 40),
      ),
    ],
  );
}

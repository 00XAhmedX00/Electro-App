import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget productContainer({
  required String image,
  required String name,
  required double rate,
  required double price,
  required double priceAfterDiscount,
}) {
  return Container(
    width: 100,
    height: 200,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: Colors.black12,
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Image.asset(image),
          // Name of the product
          Center(
            child: Text(
              name,
              style: GoogleFonts.voces(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          // Rate
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                rate.toString(),
                style: GoogleFonts.voces(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 2),
              Icon(
                Icons.star,
                size: 15,
                color: rate > 4 ? Colors.green : Colors.orange,
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Price after discount
          Text(
            "EGP $priceAfterDiscount",
            style: GoogleFonts.voces(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          // Price after discount
          Text(
            "EGP $price",
            style: GoogleFonts.voces(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.black38,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ),
    ),
  );
}

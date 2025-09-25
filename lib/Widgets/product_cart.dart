import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCart extends StatelessWidget {
  final Map product;
  final VoidCallback onDelete;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const ProductCart({
    super.key,
    required this.product,
    required this.onDelete,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(screenWidth * 0.02), // 2% padding
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                Container(
                  width: screenWidth * 0.25, // 25% of screen width
                  height: screenHeight * 0.15, // 15% of screen height
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade100,
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  ),
                  child: product["image"].toString().contains('assets')
                            ? Image.asset(product["image"], fit: BoxFit.contain)
                            : Image.network(
                                product["image"],
                                fit: BoxFit.contain,
                              ),
                ),

                SizedBox(width: screenWidth * 0.03), // spacing
                // Product info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product['name'],
                        style: GoogleFonts.voces(
                          fontSize: screenWidth * 0.05, // responsive font
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        product['category'],
                        style: GoogleFonts.voces(
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.0135,),
                      Text(
                        '${product['price'] * product['quantity']} EGP',
                        style: GoogleFonts.voces(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // Buttons
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: onDelete,
                      icon: Icon(
                        Icons.delete_outline,
                        size: screenWidth * 0.08,
                        color: Color(0xFF9C27B0),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: onAdd,
                          icon: Icon(
                            Icons.add_circle_outline,
                            size: screenWidth * 0.07,
                            color: Color(0xFF9C27B0),
                          ),
                        ),
                        Text(
                          product['quantity'].toString(),
                          style: GoogleFonts.voces(
                            fontSize: screenWidth * 0.045,
                          ),
                        ),
                        IconButton(
                          onPressed: onRemove,
                          icon: Icon(
                            Icons.remove_circle_outline,
                            size: screenWidth * 0.07,
                            color: Color(0xFF9C27B0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Divider(
          color: Colors.grey,
          thickness: 1,
          indent: screenWidth * 0.05,
          endIndent: screenWidth * 0.05,
        ),
      ],
    );
  }
}

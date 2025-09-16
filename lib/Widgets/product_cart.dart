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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Image
                Container(
                  width: 100,
                  height: 110,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(product['image'], fit: BoxFit.cover),
                ),

                // [Product : name , category , price ]
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Name
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, top: 4),
                        child: Text(
                          product['name'],
                          style: GoogleFonts.voces(fontSize: 20),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      // Product Category
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          product['category'],
                          style: GoogleFonts.voces(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // Product Price
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, top: 11),
                        child: Text(
                          '${product['price'].toString()} EGP',
                          style: GoogleFonts.voces(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // To push the buttons to the end (create Empty space)
                Spacer(),

                // [Delete  , Add or Decrease button , Count]
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Delete Button
                    IconButton(
                      onPressed: onDelete,
                      icon: Icon(
                        Icons.delete_outline,
                        size: 33,
                        color: Color(0xFF9C27B0),
                      ),
                    ),

                    // [ADD , COUNT , DECREASE]
                    Row(
                      children: [
                        // Add Button
                        IconButton(
                          onPressed: onAdd,
                          icon: Icon(
                            Icons.add_circle_outline,
                            size: 30,
                            color: Color(0xFF9C27B0),
                          ),
                        ),

                        // Count
                        Text(
                          product['count'].toString(),
                          style: GoogleFonts.voces(fontSize: 20),
                        ),

                        // Decrease Button
                        IconButton(
                          onPressed: onRemove,
                          icon: Icon(
                            Icons.remove_circle_outline,
                            size: 30,
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
          color: Colors.grey, // line color
          thickness: 1, // line thickness
          indent: 20, // empty space before line
          endIndent: 20, // empty space after line
        ),
      ],
    );
  }
}

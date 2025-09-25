import 'package:electrocart/Firebase/firebase_functions.dart';
import 'package:electrocart/Screens/admin_screens/update_product_Page.dart';
import 'package:electrocart/Widgets/go_to.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        title: Text("All Product"),
      ),
      body: FutureBuilder(
        future: FirebaseFunctions().getAllProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("An Error Happend!"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "No Data Found!",
                style: GoogleFonts.voces(fontWeight: FontWeight.bold),
              ),
            );
          }
          final List<Map<String, dynamic>>? products = snapshot.data;
          return ListView.builder(
            itemCount: products!.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> product = products[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 10,
                ),
                child: Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.green.shade200,
                    border: Border.all(color: Colors.green, width: 3),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          maxRadius: 45,
                          backgroundColor: Colors.white,
                          child: product['image'].toString().contains("assets")
                              ? Image.asset(product['image'])
                              : Image.network(product['image']),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Name
                              Text(
                                "Name: ${product['name']}",
                                style: GoogleFonts.voces(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // Price
                              product['price'] == product['priceAfterDiscount']
                                  ? Text(
                                      "Price: ${product['price']}",
                                      style: GoogleFonts.voces(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  : Row(
                                      children: [
                                        Text(
                                          "Price: ",
                                          style: GoogleFonts.voces(
                                            fontSize: 17,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          "${product['price']}",
                                          style: GoogleFonts.voces(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontSize: 17,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          "${product['priceAfterDiscount']}",
                                          style: GoogleFonts.voces(
                                            fontSize: 17,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                              // Category
                              Text(
                                "Category: ${product['category']}",
                                style: GoogleFonts.voces(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              // Rate
                              Text(
                                "rate: ${product['rate']}",
                                style: GoogleFonts.voces(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Delete Button
                        Expanded(
                          child: Align(
                            alignment: AlignmentGeometry.centerRight,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                //Update Button
                                InkWell(
                                  onTap: () async {
                                    goTo(
                                      context: context,
                                      page: UpdateProductPage(
                                        productName: product['name'],
                                      ),
                                      routed: true,
                                    );
                                  },
                                  child: Container(
                                    width: 80,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Update",
                                        style: GoogleFonts.voces(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                //Delete Button
                                InkWell(
                                  onTap: () async {
                                    await FirebaseFunctions().deleteProduct(
                                      productName: product['name'],
                                    );
                                    setState(() {});
                                  },
                                  child: Container(
                                    width: 80,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Delete",
                                        style: GoogleFonts.voces(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

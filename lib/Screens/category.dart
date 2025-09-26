import 'package:electrocart/Widgets/showSnackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:electrocart/cubit/product/product_state.dart';
import 'package:electrocart/cubit/product/product_logic.dart';
import 'package:electrocart/Screens/product_details.dart';
import 'package:electrocart/Widgets/go_to.dart';

class Category extends StatelessWidget {
  final String category;
  const Category({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductLogic()..getAllProducts(),
      child: BlocConsumer<ProductLogic, ProductState>(
        listener: (context, state) {},
        builder: (context, state) {
          List<Map<String, dynamic>> products = [];

          if (state is GetProduct) {
            // Filter by category
            products = state.products
                .where(
                  (p) =>
                      (p['category']?.toString().toLowerCase() ?? '') ==
                      category.toLowerCase(),
                )
                .toList();
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(
                category,
                style: GoogleFonts.voces(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: state is LoadingProduct
                ? const Center(child: CircularProgressIndicator())
                : products.isEmpty
                ? Center(
                    child: Text(
                      "No products found in $category",
                      style: GoogleFonts.voces(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(15),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15,
                          childAspectRatio: 0.7,
                        ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return GestureDetector(
                        onTap: () {
                          if (FirebaseAuth.instance.currentUser != null) {
                            goTo(
                              context: context,
                              page: ProductDetails(product: product),
                              routed: true,
                            );
                          } else {
                            showSnackbar(
                              message: "You Must Login",
                              context: context,
                            );
                          }
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Product Image
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                  child:
                                      product['image'].toString().contains(
                                        'assets',
                                      )
                                      ? Image.asset(
                                          product['image'],
                                          height: 140,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.network(
                                          product['image'],
                                          height: 140,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product['name'],
                                      style: GoogleFonts.voces(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "\$${product['priceAfterDiscount']}",
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                    if (product['price'] !=
                                        product['priceAfterDiscount'])
                                      Text(
                                        "\$${product['price']}",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}

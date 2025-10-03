import 'package:electrocart/Screens/user_screens/product_details.dart';
import 'package:electrocart/Widgets/go_to.dart';
import 'package:electrocart/Widgets/showSnackbar.dart';
import 'package:electrocart/cubit/product/product_logic.dart';
import 'package:electrocart/cubit/product/product_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class DiscountPage extends StatelessWidget {
  const DiscountPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> discounts = [];

    return BlocProvider(
      create: (context) => ProductLogic()..getDiscountedProducts(),
      child: BlocConsumer<ProductLogic, ProductState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is LoadingProduct) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is GetDiscountProducts) {
            discounts = state.discountedProducts;
          }

          return Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: AppBar(
              elevation: 0,
              backgroundColor: const Color(0xFF9C27B0),
              centerTitle: true,
              title: Text(
                "Discounts",
                style: GoogleFonts.voces(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            body: SafeArea(
              child: ListView.builder(
                padding: const EdgeInsets.all(15),
                itemCount: discounts.length,
                itemBuilder: (context, index) {
                  final product = discounts[index];
                  final price = (product["price"] ?? 0).toDouble();
                  final priceAfter = (product["priceAfterDiscount"] ?? price)
                      .toDouble();
                  // Calculate discount percentage
                  final discountRate = price > 0
                      ? ((price - priceAfter) / price * 100).round()
                      : 0;

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              // Product Image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  product["image"] as String,
                                  height: 90,
                                  width: 90,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 15),

                              // Product Info
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product["name"].toString(),
                                      style: GoogleFonts.voces(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Text(
                                          "\$${product["priceAfterDiscount"]}",
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          "\$${product["price"]}",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              // Shop Now Button
                              ElevatedButton(
                                onPressed: () {
                                  if (FirebaseAuth.instance.currentUser !=
                                      null) {
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
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF9C27B0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 10,
                                  ),
                                ),
                                child: const Text(
                                  "Shop Now",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Discount Badge
                        Positioned(
                          top: 12,
                          left: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "-$discountRate%",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

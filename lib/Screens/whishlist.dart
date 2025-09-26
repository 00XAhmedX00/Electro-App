import 'package:electrocart/Screens/product_details.dart';
import 'package:electrocart/Widgets/go_to.dart';
import 'package:electrocart/cubit/wishlist/whishlist_logic.dart';
import 'package:electrocart/cubit/wishlist/wishlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class Whishlist extends StatelessWidget {
  const Whishlist({super.key});

  @override
  Widget build(BuildContext context) {
    // Example wishlist data (replace with Firebase or your cubit later)
    List<Map<String, dynamic>> wishlistItems = [];

    return BlocProvider(
      create: (context) => WhishlistLogic()..getAllItems(),
      child: BlocConsumer<WhishlistLogic, WishlistState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GetItems) {
            wishlistItems = state.items;
          }

          if (state is LoadingWish) {
            return const Center(child: CircularProgressIndicator());
          }
          WhishlistLogic wishobj = BlocProvider.of(context);
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              title: Text(
                'Wishlist',
                style: GoogleFonts.voces(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
            ),
            body: SafeArea(
              child: wishlistItems.isEmpty
                  ? Center(
                      child: Text(
                        "Your Wishlist is Empty",
                        style: GoogleFonts.voces(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(15),
                      itemCount: wishlistItems.length,
                      itemBuilder: (context, index) {
                        final product = wishlistItems[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                // Product Image
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child:
                                      product['image'].toString().contains(
                                        'assets',
                                      )
                                      ? Image.asset(
                                          product["image"],
                                          height: 80,
                                          width: 80,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.network(
                                          product["image"],
                                          height: 80,
                                          width: 80,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                                const SizedBox(width: 15),

                                // Product Info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product["name"],
                                        style: GoogleFonts.voces(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        product["category"],
                                        style: GoogleFonts.voces(
                                          fontSize: 14,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Column(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        goTo(
                                          context: context,
                                          page: ProductDetails(
                                            product: product,
                                          ),
                                          routed: true,
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                          0xFF9C27B0,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 10,
                                        ),
                                      ),
                                      child: const Text(
                                        "Details",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    ElevatedButton(
                                      onPressed: () async {
                                        await wishobj.removeItem(
                                          product['docId'],
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 10,
                                        ),
                                      ),
                                      child: const Text(
                                        "Remove",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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



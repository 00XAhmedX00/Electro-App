import 'package:electrocart/Widgets/product_cart.dart';
import 'package:electrocart/Widgets/showSnackbar.dart';
import 'package:electrocart/cubit/cart/cart_logic.dart';
import 'package:electrocart/cubit/cart/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartLogic()..getCartItems(),
      child: BlocConsumer<CartLogic, CartState>(
        listener: (context, state) {},
        builder: (context, state) {
          CartLogic cartObj = BlocProvider.of(context);

          List<Map<String, dynamic>> cartProducts = [];
          if (state is LoadingCartItem) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is GetCartItems) {
            cartProducts = state.cartItems;
          }

          //  Calculate total price
          double totalPrice = 0.0;
          for (var item in cartProducts) {
            totalPrice += (item['price'] * item['quantity'] ?? 0.0);
          }

          return SafeArea(
            child: Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text(
                      'View Cart',
                      style: GoogleFonts.voces(
                        color: const Color(0xFF9C27B0),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: cartProducts.isEmpty
                        ? Center(
                            child: Text(
                              'Cart Is Empty',
                              style: GoogleFonts.voces(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: cartProducts.length,
                            itemBuilder: (context, index) {
                              return ProductCart(
                                product: cartProducts[index],
                                onDelete: () async {
                                  await cartObj.deleteCartItem(
                                    cartProducts[index]['docId'],
                                  );
                                },
                                onAdd: () async {
                                  await cartObj.increaseCartItem(
                                    cartProducts[index]['docId'],
                                  );
                                },
                                onRemove: () async {
                                  await cartObj.decreaseCartItem(
                                    cartProducts[index]['docId'],
                                  );
                                },
                              );
                            },
                          ),
                  ),

                  //  Total Price Box + Checkout Button
                  cartProducts.isEmpty
                      ? SizedBox()
                      : Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 25,
                          ),
                          decoration: const BoxDecoration(
                            color: Color(0xFF9C27B0), // purple theme
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 8,
                                offset: Offset(0, -2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Total Price
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Total:',
                                    style: GoogleFonts.voces(
                                      color: Colors.white70,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "\$${totalPrice.toStringAsFixed(2)}",
                                    style: GoogleFonts.voces(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),

                              // Checkout Button
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 30,
                                    vertical: 15,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 4,
                                ),
                                onPressed: () {
                                  showSnackbar(
                                    message: 'Procedding To checkout',
                                    context: context,
                                  );
                                },
                                child: Text(
                                  "Checkout",
                                  style: GoogleFonts.voces(
                                    color: Color(0xFF9C27B0), // match theme
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
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
  }
}

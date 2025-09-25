import 'package:electrocart/Widgets/product_cart.dart';
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
            if (cartProducts.isEmpty) {
              return Center(
                child: Text(
                  'Cart Is Empty',
                  style: GoogleFonts.voces(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
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
                    child: ListView.builder(
                      itemCount: cartProducts.length,
                      itemBuilder: (context, index) {
                        return ProductCart(
                          product: cartProducts[index],
                          onDelete: () async {
                            await cartObj.deleteCartItem(
                              cartProducts[index]['docId'],
                            );
                          }, // your callbacks
                          onAdd: () {},
                          onRemove: () {},
                        );
                      },
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

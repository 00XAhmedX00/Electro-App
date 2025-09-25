import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electrocart/Widgets/curved_Navigator.dart';
import 'package:electrocart/Widgets/go_to.dart';
import 'package:electrocart/cubit/cart/cart_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartLogic extends Cubit<CartState> {
  CartLogic() : super(InitCartItem());

  CollectionReference cartObj = FirebaseFirestore.instance.collection('cart');
  final user = FirebaseAuth.instance.currentUser!.uid;

  void showSuccessfulDialog({
    required BuildContext context,
    required String message,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap a button
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Success Icon
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.green.shade100,
                  child: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 60,
                  ),
                ),
                const SizedBox(height: 20),

                // Title
                const Text(
                  "Success!",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),

                // Message
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 20),

                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: const Text("Continue Shopping"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        goTo(
                          context: context,
                          page: CurvedNavigator(index: 3),
                        ); // your cart route
                      },
                      child: const Text("Go to Cart"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> addCartItem(String productId, BuildContext context) async {
    await cartObj
        .doc(user)
        .collection('products')
        .add({'id': productId, 'quantity': 1})
        .then((value) {
          emit(AddCartItem());
          showSuccessfulDialog(
            context: context,
            message: 'Product Added Successfuly to Cart',
          );
        })
        .catchError(((err) => print('Error : $err')));
  }

  Future<List<Map<String, dynamic>>> getCartItems() async {
    List<Map<String, dynamic>> cartItems = [];
    emit(LoadingCartItem());

    try {
      // Get all cart items for the user
      final cartSnapshot = await cartObj.doc(user).collection('products').get();

      // Extract all productIds from the cart
      List<String> productIds = cartSnapshot.docs
          .map((doc) => doc['id'] as String)
          .toList();

      if (productIds.isEmpty) {
        emit(GetCartItems([]));
        return [];
      }

      // Fetch all product details in a single query
      final productsSnapshot = await FirebaseFirestore.instance
          .collection('products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();

      // Map productId -> productData for fast lookup
      Map<String, Map<String, dynamic>> productMap = {
        for (var doc in productsSnapshot.docs) doc.id: doc.data(),
      };

      // Combine cart info with product details
      cartItems = cartSnapshot.docs.map((doc) {
        final productId = doc['id'] as String;
        final quantity = doc['quantity'] as int;

        final productData = productMap[productId];

        return {
          'docId': doc.id,
          'id': productId,
          'quantity': quantity,
          'name': productData?['name'] ?? '',
          'price': productData?['priceAfterDiscount'] ?? 0,
          'category': productData?['category'] ?? 'Accessories',
          'image':
              productData?['image'] ?? 'assets/images/products/smart_watch.png',
        };
      }).toList();

      emit(GetCartItems(cartItems));
      return cartItems;
    } catch (err) {
      print('Error: $err Cart ERROR');
      return [];
    }
  }

  Future<void> deleteCartItem(String cartItemId) async {
    await cartObj
        .doc(user)
        .collection('products')
        .doc(cartItemId)
        .delete()
        .then((val) async {
          emit(DeleteCartItem());
          await getCartItems();
        })
        .catchError((err) => print('Error : $err'));
  }

  Future<void> increaseCartItem(String cartItemId) async {
    await cartObj
        .doc(user)
        .collection('products')
        .doc(cartItemId)
        .update({'quantity': FieldValue.increment(1)})
        .then((value) async{
          emit(AddCartItem());
          await getCartItems();
        });
  }


Future<void> decreaseCartItem(String cartItemId) async {
  final docRef = cartObj.doc(user).collection('products').doc(cartItemId);

  final snapshot = await docRef.get();
  if (snapshot.exists) {
    final currentQuantity = snapshot.data()?['quantity'] ?? 0;

    if (currentQuantity > 1) {
      // Just decrement
      await docRef.update({'quantity': FieldValue.increment(-1)});
    } else {
      // If quantity will be 0 → delete the product
      await docRef.delete();
    }

    emit(RemoveCartItem());
    await getCartItems();
  }
}
}

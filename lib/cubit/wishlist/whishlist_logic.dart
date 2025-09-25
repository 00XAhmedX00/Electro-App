import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electrocart/Screens/whishlist.dart';
import 'package:electrocart/Widgets/go_to.dart';
import 'package:electrocart/cubit/wishlist/wishlist_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WhishlistLogic extends Cubit<WishlistState> {
  WhishlistLogic() : super(InitState());

  CollectionReference wishlistObj = FirebaseFirestore.instance.collection(
    'wishlist',
  );

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
                        goTo(context: context, page: Whishlist() , routed: true);
                      },
                      child: const Text("Go to WishList"),
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



  Future<List<Map<String, dynamic>>> getAllItems() async {
  List<Map<String, dynamic>> items = [];
  emit(LoadingWish());

  try {
    final snapshot = await wishlistObj
        .doc(user)
        .collection('items')
        .get();

    items = snapshot.docs.map((doc) {
      final data = doc.data();
      return {
        ...data,        // keep all fields
        'docId': doc.id // add document id
      };
    }).toList();

    emit(GetItems(items));
  } catch (err) {
    print('Error: $err');
  }

  return items;
}


  Future<void> addItem(Map<String, dynamic> product , BuildContext context) async {
    
    await wishlistObj
        .doc(user)
        .collection('items')
        .add({
          'id': product['id'],
          'image' : product['image'],
          'name': product['name'],
          'price': product['price'],
          'priceAfterDiscount': product['priceAfterDiscount'],
          'category': product['category'] ?? 'Empty',
          'description': product['description'] ?? 'Empty',
          'rate' : product['rate']
        })
        .then((val) async {
          emit(AddItem());
          showSuccessfulDialog(context: context, message: 'Product Added Successfuly to WishList');
        })
        .catchError((err) => print('ERROR : $err'));
  }

  Future<void> removeItem(String docId) async {
    try {
      await wishlistObj
          .doc(user)
          .collection('items')
          .doc(docId)
          .delete();
      emit(RemoveItem()); 
      await getAllItems(); // refresh
    } catch (e) {
      print('Error removing item: $e');
    }
}
}

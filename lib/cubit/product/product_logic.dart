import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electrocart/cubit/product/product_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductLogic extends Cubit<ProductState> {
  
  ProductLogic() : super(InitProduct());
  CollectionReference productObj = FirebaseFirestore.instance.collection('products');

 Future<List<Map<String,dynamic>>> getAllProducts() async {
    List<Map<String,dynamic>> products = [];
    emit(LoadingProduct());
    await productObj.get()
    .then((snapshot) {
      products = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      emit(GetProduct(products));
    }).catchError((err) => print('Error : $err'));

    return products;
  }



}
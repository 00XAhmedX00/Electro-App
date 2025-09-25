import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electrocart/cubit/product/product_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bloc/bloc.dart';

class ProductLogic extends Cubit<ProductState> {
  
  ProductLogic() : super(InitProduct());
  CollectionReference productObj = FirebaseFirestore.instance.collection('products');

 Future<List<Map<String,dynamic>>> getAllProducts() async {
    List<Map<String,dynamic>> products = [];
    emit(LoadingProduct());
    await productObj.get()
    .then((snapshot) {
     products = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return {
        'id': doc.id,  // <-- add productId
        ...data,       // <-- spread the rest of the fields
      };
    }).toList();
      emit(GetProduct(products));
    }).catchError((err) => print('Error : $err'));

    return products;
  }



}
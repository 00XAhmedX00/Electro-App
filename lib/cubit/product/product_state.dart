abstract class ProductState {}

class InitProduct extends ProductState {}

class LoadingProduct extends ProductState {}

class AddProduct extends ProductState {}

class EditProduct extends ProductState {}

class GetProduct extends ProductState {
  final List<Map<String,dynamic>> products;
  GetProduct(this.products);

}

class DeleteProduct extends ProductState {}


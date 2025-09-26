abstract class ProductState {}

class InitProduct extends ProductState {}

class LoadingProduct extends ProductState {}

class AddProduct extends ProductState {}

class EditProduct extends ProductState {}

class GetProduct extends ProductState {
  final List<Map<String, dynamic>> products;
  GetProduct(this.products);
}

class GetDiscountProducts extends ProductState {
  final List<Map<String, dynamic>> discountedProducts;
  GetDiscountProducts(this.discountedProducts);
}

class DeleteProduct extends ProductState {}

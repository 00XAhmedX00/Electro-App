abstract class CartState {}

class GetCartItems extends CartState {
  final  List<Map<String,dynamic>> cartItems;
  GetCartItems(this.cartItems); 
}

class InitCartItem extends CartState {}

class LoadingCartItem extends CartState {}

class DeleteCartItem extends CartState {}

class AddCartItem extends CartState {}

class RemoveCartItem extends CartState {}

 

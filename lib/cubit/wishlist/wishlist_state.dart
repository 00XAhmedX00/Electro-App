abstract class WishlistState {}

class InitState extends WishlistState {}

class LoadingWish extends WishlistState {}

class AddItem extends WishlistState {}

class RemoveItem extends WishlistState {}

class GetItems extends WishlistState {
  final List<Map<String,dynamic>> items;
  GetItems(this.items);
}


class WishlistCheck extends WishlistState {
  final bool exists;
  WishlistCheck(this.exists);
}


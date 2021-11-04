import 'package:cloud_firestore/cloud_firestore.dart';

import 'cart_item.dart';

class User {
  static const NAME = "name";
  static const EMAIL = "email";
  static const ID = "id";
  static const STRIPE_ID = "stripeid";

  String _name;
  String _email;
  String _id;
  List _likedRestaurents;
  List _likedFoods;
  List<CartItemModel> cart = [];

  List<CartItemModel> addProductToCart(CartItemModel item) {
    cart.add(item);
  }

  String get name => _name;
  String get email => _email;
  String get id => _id;
  List get likedFood => _likedFoods;
  List get likedRestaurents => _likedRestaurents;

  User.fromSnapshot(DocumentSnapshot snapshot) {
    _name = snapshot.data[NAME];
    _email = snapshot.data[EMAIL];
    _id = snapshot.data[ID];
  }
}

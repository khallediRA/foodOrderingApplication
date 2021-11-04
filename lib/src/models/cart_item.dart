class CartItemModel {
  static const ID = "id";
  static const NAME = "name";
  static const IMAGE = "image";
  static const PRODUCT_ID = "productId";
  static const QUANTITY = "quantity";
  static const PRICE = "price";

  String id;
  String name;
  String image;
  String productId;
  int restaurantId;
  String restaurantName;
  int quantity;
  double price;
  CartItemModel({
    this.id,
    this.name,
    this.image,
    this.productId,
    this.restaurantId,
    this.restaurantName,
    this.quantity,
    this.price,
  });

  // String get id => _id;
  // String get name => _name;
  // String get image => _image;
  // String get productId => _productId;
  // int get quantity => _quantity;
  // double get price => _price;

}

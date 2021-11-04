import 'package:FoodOrderingApp/src/models/products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductServies {
  String collection = "products";
  Firestore _firestore = Firestore.instance;
  Future<List<ProductModel>> getproducts() async =>
      _firestore.collection(collection).getDocuments().then((result) {
        List<ProductModel> products = [];
        for (DocumentSnapshot product in result.documents) {
          products.add(ProductModel.fromSnapshot(product));
        }
        return products;
      });

  Future<List<ProductModel>> getProductByCategory(
          {String categoryName}) async =>
      _firestore
          .collection(collection)
          .where("category", isEqualTo: categoryName)
          .getDocuments()
          .then((result) {
        List<ProductModel> productsByCategory = [];
        for (DocumentSnapshot productByCategory in result.documents) {
          productsByCategory.add(ProductModel.fromSnapshot(productByCategory));
        }
        return productsByCategory;
      });
  Future<List<ProductModel>> getProductByRestaurant(
          {int resautaurantId}) async =>
      _firestore
          .collection(collection)
          .where("restaurantId", isEqualTo: resautaurantId)
          .getDocuments()
          .then((result) {
        List<ProductModel> productsByRestaurant = [];
        for (DocumentSnapshot productByRestaurant in result.documents) {
          productsByRestaurant
              .add(ProductModel.fromSnapshot(productByRestaurant));
        }
        return productsByRestaurant;
      });

  Future<List<ProductModel>> searchProducts({String productName}) {
    String searchKey = productName[0].toUpperCase() + productName.substring(1);
    return _firestore
        .collection(collection)
        .orderBy("name")
        .startAt([searchKey])
        .endAt([searchKey + "\uf8ff"])
        .getDocuments()
        .then((result) {
          List<ProductModel> products = [];
          for (DocumentSnapshot product in result.documents) {
            products.add(ProductModel.fromSnapshot(product));
          }
          return products;
        });
  }
}

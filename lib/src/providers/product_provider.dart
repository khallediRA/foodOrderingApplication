import 'package:FoodOrderingApp/src/helpers/product_service.dart';
import 'package:FoodOrderingApp/src/models/products.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  ProductServies _productService = ProductServies();
  List<ProductModel> products = [];
  List<ProductModel> productsByCategory = [];
  List<ProductModel> productsByRestaurant = [];
  List<ProductModel> productsSearched = [];

  ProductProvider.initialize() {
    _loadProdcuts();
    search(productName: "b");
  }
  _loadProdcuts() async {
    products = await _productService.getproducts();
    notifyListeners();
  }

  Future loadProdcutsByCategorie({String categoryName}) async {
    productsByCategory =
        await _productService.getProductByCategory(categoryName: categoryName);
    notifyListeners();
  }

  Future loadProdcutsByRestaurant({int restaurantId}) async {
    productsByRestaurant = await _productService.getProductByRestaurant(
        resautaurantId: restaurantId);
    notifyListeners();
  }

  Future search({String productName}) async {
    productsSearched =
        await _productService.searchProducts(productName: productName);
    print("the length of search is ${productsSearched.length}");
    print("the length of search is ${productsSearched.length}");
    print("the length of search is ${productsSearched.length}");
    notifyListeners();
  }
}

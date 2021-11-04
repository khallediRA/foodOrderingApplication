import 'package:flutter/material.dart';

enum SearchBy { PRODUCT, RESTAURANT }

class AppProvider with ChangeNotifier {
  bool isloading = false;
  SearchBy search = SearchBy.PRODUCT;
  String filterBy = "Products";
  void changeLoadingState() {
    isloading = !isloading;
    notifyListeners();
  }

  void changeSearchBy({SearchBy newsearchBy}) {
    search = newsearchBy;
    if (newsearchBy == SearchBy.PRODUCT) {
      filterBy = "Products";
    } else {
      filterBy = "Restaurants";
    }

    notifyListeners();
  }
}

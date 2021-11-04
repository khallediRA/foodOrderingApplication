import 'package:FoodOrderingApp/src/helpers/category_service.dart';
import 'package:FoodOrderingApp/src/models/category.dart';
import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier {
  CategoryServices _categoryServices = CategoryServices();
  List<CategoryModel> categories = [];

  CategoryProvider.initialize() {
    _loadCategories();
  }

  _loadCategories() async {
    categories = await _categoryServices.getcategories();
    notifyListeners();
  }
}

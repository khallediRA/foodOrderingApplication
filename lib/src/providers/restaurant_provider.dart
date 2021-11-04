import 'package:FoodOrderingApp/src/helpers/restaurant_service.dart';
import 'package:FoodOrderingApp/src/models/restaurent.dart';
import 'package:flutter/cupertino.dart';

class RestaurantProvider with ChangeNotifier {
  RestaurantServices _restaurantServices = RestaurantServices();
  RestaurantModel _restaurantModelById;
  RestaurantModel restaurant;
  List<RestaurantModel> restaurants = [];
  List<RestaurantModel> restaurantsSearched = [];

  RestaurantProvider.initialize() {
    _loadRestaurants();
    searchRestaurant();
  }

  _loadRestaurants() async {
    restaurants = await _restaurantServices.getRestaurants();
    notifyListeners();
  }

  _loadRestaurantById({int restaurantid}) async {
    _restaurantModelById =
        await _restaurantServices.getRestaurantById(id: restaurantid);
    notifyListeners();
  }

  loadSingleRestaurant({int restaurantid}) async {
    restaurant = await _restaurantServices.getRestaurantById(id: restaurantid);
    notifyListeners();
  }

  Future searchRestaurant({String restaurantName}) async {
    restaurantsSearched = await _restaurantServices.searchRestaurants(
        restaurantName: restaurantName);

    notifyListeners();
  }
}

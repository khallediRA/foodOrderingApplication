import 'package:FoodOrderingApp/src/models/cart_item.dart';
import 'package:FoodOrderingApp/src/models/user.dart';
import 'package:FoodOrderingApp/src/providers/user_provider.dart';
import 'package:FoodOrderingApp/src/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class UserService {
  String collection = "users";
  Firestore _firestore = Firestore.instance;

  void createUser(Map<String, dynamic> values) {
    String id = values["id"];
    _firestore.collection(collection).document(id).setData(values);
  }

  void updateUserData(Map<String, dynamic> values) {
    _firestore.collection(collection).document(values['id']).updateData(values);
  }

  Future<User> getUserById(String id) =>
      _firestore.collection(collection).document(id).get().then((doc) {
        return User.fromSnapshot(doc);
      });

  Future<void> createOrder({
    List<CartItemModel> items,
    String userid,
  }) async {
    final orderDetails = Map<String, Map<String, int>>();

    double totalprice = 0;
    int foodCount = items.length;

    for (CartItemModel item in items) {
      dynamic foodDetails = Map<String, int>();
      String restoName = item.restaurantName;
      int quantity = 0;

      for (CartItemModel itemM in items) {
        if (itemM.restaurantName == restoName) {
          quantity = quantity + itemM.quantity;
          foodDetails.putIfAbsent(itemM.name, () => quantity);
          foodDetails.update(itemM.name, (int value) => quantity);
          print(foodDetails);
          print("quantity is " + quantity.toString());
        }
      }
      if (item.restaurantName == restoName) {
        orderDetails.putIfAbsent(restoName, () => foodDetails);
      }
      print(orderDetails);

      if (item.quantity != 1) {
        foodCount += item.quantity - 1;
      }

      if (item.quantity == 1) {
        totalprice = totalprice + (item.quantity * item.price);
      } else {
        totalprice = totalprice + item.price;
      }
      print(totalprice);
    }

    DocumentReference ref = await _firestore.collection("orders").add({
      'userid': userid,
      'orderDetails': orderDetails,
      'FoodCount': foodCount,
      'totalPrice': totalprice
    });

    print(ref.documentID);
  }
}

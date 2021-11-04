import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantModel {
  static const ID = "id";
  static const NAME = "name";
  static const AVG_PRICE = "avgPrice";
  static const RATING = "rating";
  static const RATES = "rates";

  static const IMAGE = "image";
  static const POPULAR = "popular";

  int _id;
  String _name;
  String _image;
  int _rates;

  double _rating;
  double _avgPrice;
  bool _popular;

//  getters
  int get id => _id;

  String get name => _name;

  String get image => _image;

  double get avgPrice => _avgPrice;

  double get rating => _rating;
  int get rates => _rates;

  bool get popular => _popular;

  // public variable

  RestaurantModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data[ID];
    _name = snapshot.data[NAME];
    _image = snapshot.data[IMAGE];
    _avgPrice = snapshot.data[AVG_PRICE];
    _rating = snapshot.data[RATING];
    _rates = snapshot.data[RATES];
    _popular = snapshot.data[POPULAR];
  }
}

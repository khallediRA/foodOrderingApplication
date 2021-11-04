import 'package:FoodOrderingApp/src/helpers/user_services.dart';
import 'package:FoodOrderingApp/src/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum Status { Uninitialazed, Unauthenticated, Authenticating, Authenticated }

class UserProvider with ChangeNotifier {
  FirebaseAuth _auth;
  FirebaseUser _user;
  User get userModel => _userModel;
  Status _status = Status.Uninitialazed;
  Firestore _firestore = Firestore.instance;
  UserService _userService = UserService();
  User _userModel;

//getters
  Status get status => _status;
  FirebaseUser get user => _user;
  final formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  UserProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onStateChanged);
  }
  Future<bool> signIn() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
      return true;
    } catch (e) {
      return _onError(e.toString());
    }
  }

  Future<void> singOut() {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<bool> singUp() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((user) {
        Map<String, dynamic> values = {
          "name": name.text.trim(),
          "email": email.text.trim(),
          "id": user.user.uid,
          "likedFood": [],
          "likedRestaurent": [],
        };
        _userService.createUser(values);
      });
      return true;
    } catch (e) {
      return _onError(e.toString());
    }
  }

  Future<void> _onStateChanged(FirebaseUser fireBaseUser) async {
    if (fireBaseUser == null) {
      _status = Status.Uninitialazed;
    } else {
      _user = fireBaseUser;
      _status = Status.Authenticated;
      _userModel = await _userService.getUserById(fireBaseUser.uid);
    }
    notifyListeners();
  }

// catch error Methode
  bool _onError(String e) {
    _status = Status.Unauthenticated;
    notifyListeners();
    print("error" + e.toString());
    return false;
  }

//clean Controllers
  void cleanControllers() {
    email.text = "";
    password.text = "";
    name.text = "";
  }
}

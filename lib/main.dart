import 'package:FoodOrderingApp/src/providers/app.dart';
import 'package:FoodOrderingApp/src/providers/category_provider.dart';
import 'package:FoodOrderingApp/src/providers/product_provider.dart';
import 'package:FoodOrderingApp/src/providers/restaurant_provider.dart';
import 'package:FoodOrderingApp/src/providers/user_provider.dart';
import 'package:FoodOrderingApp/src/screens/details.dart';

import 'package:FoodOrderingApp/src/screens/home.dart';
import 'package:FoodOrderingApp/src/screens/login.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: UserProvider.initialize()),
      ChangeNotifierProvider.value(value: CategoryProvider.initialize()),
      ChangeNotifierProvider.value(value: RestaurantProvider.initialize()),
      ChangeNotifierProvider.value(value: ProductProvider.initialize()),
      ChangeNotifierProvider.value(value: AppProvider())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ScreenController(),
    );
  }
}

class ScreenController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserProvider>(context);
    switch (auth.status) {
      case (Status.Uninitialazed):
        return LoginScreen();
      case (Status.Unauthenticated):
      case (Status.Authenticating):
        return LoginScreen();
      case (Status.Authenticated):
        return Home();
      default:
        return LoginScreen();
    }
  }
}

import 'dart:collection';

import 'package:FoodOrderingApp/src/helpers/commons.dart';
import 'package:FoodOrderingApp/src/helpers/user_services.dart';
import 'package:FoodOrderingApp/src/models/cart_item.dart';
import 'package:FoodOrderingApp/src/models/products.dart';
import 'package:FoodOrderingApp/src/providers/user_provider.dart';
import 'package:FoodOrderingApp/src/widgets/bag_item_widget.dart';
import 'package:FoodOrderingApp/src/widgets/customtext.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingBag extends StatefulWidget {
  @override
  _ShoppingBagState createState() => _ShoppingBagState();
}

class _ShoppingBagState extends State<ShoppingBag> {
  final _key = GlobalKey<ScaffoldState>();
  // ProductModel product = ProductModel(
  //     name: "Cereals",
  //     price: 5.99,
  //     rating: 4.2,
  //     vendor: "GoodFood",
  //     wishList: true,
  //     imageURL: "images/cereals.jpg");
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    UserService userService = UserService();
    final List<CartItemModel> items = userProvider.userModel.cart;
    final databaseReference = Firestore.instance;
    return Scaffold(
        key: _key,
        appBar: AppBar(
          iconTheme: IconThemeData(color: black),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: black,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          backgroundColor: white,
          elevation: 0,
          centerTitle: true,
          title: CustomText(
            text: "Shopping Bag",
            size: 20.0,
            fontweight: FontWeight.w500,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 1,
                    right: 5,
                    child: Container(
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: grey,
                                offset: Offset(2, 1),
                                blurRadius: 3,
                              )
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: CustomText(
                            text: items.length.toString(),
                            color: red,
                            size: 18,
                            fontweight: FontWeight.bold,
                          ),
                        )),
                  ),
                  // padding: const EdgeInsets.all(8.0),

                  IconButton(
                      icon: Icon(Icons.shopping_cart_outlined),
                      color: black,
                      onPressed: null),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: white,
        body: Column(
          children: [
            Column(
              children: items
                  .map(
                    (item) => Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        setState(() {
                          items.remove(item);
                        });
                        _key.currentState.showSnackBar(
                          SnackBar(
                            content: Text("${item.name} dismissed",
                                textAlign: TextAlign.center),
                          ),
                        );
                      },
                      child: ItemCartWidget(
                        itemModel: item,
                      ),
                    ),
                  )
                  .toList(),
            ),
            items.length != 0
                ? GestureDetector(
                    onTap: () async {
                      showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text("Command Confirmation"),
                          content:
                              Text("Do you want to confirm your command ?"),
                          actions: [
                            FlatButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("No")),
                            FlatButton(
                                onPressed: () async {
                                  await userService.createOrder(
                                      items: items,
                                      userid: userProvider.userModel.id);
                                  Navigator.pop(context);
                                  _key.currentState.showSnackBar(
                                    SnackBar(
                                      content: Text("Command Confirmed !",
                                          textAlign: TextAlign.center),
                                    ),
                                  );
                                },
                                child: Text("Yes"))
                          ],
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF000000).withAlpha(60),
                              blurRadius: 6.0,
                              spreadRadius: 0.0,
                              offset: Offset(
                                0.0,
                                3.0,
                              ),
                            ),
                          ]),
                      child: CustomText(
                        text: "Add to firestore",
                        color: Colors.red[300],
                        designedtext: true,
                        size: 30.0,
                      ),
                    ),
                  )
                : Center(
                    heightFactor: 5.0,
                    child: Column(
                      children: [
                        CustomText(
                          color: grey,
                          designedtext: true,
                          text: "Your Bag is empty",
                          size: 30.0,
                        ),
                        Icon(
                          Icons.search,
                          size: 40.0,
                          color: grey,
                        )
                      ],
                    ),
                  )
          ],
        ));
  }
}

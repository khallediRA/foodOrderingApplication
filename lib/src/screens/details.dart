import 'package:FoodOrderingApp/src/helpers/screen_navigation.dart';
import 'package:FoodOrderingApp/src/helpers/user_services.dart';
import 'package:FoodOrderingApp/src/models/cart_item.dart';
import 'package:FoodOrderingApp/src/models/products.dart';
import 'package:FoodOrderingApp/src/helpers/commons.dart';
import 'package:FoodOrderingApp/src/providers/user_provider.dart';
import 'package:FoodOrderingApp/src/widgets/customtext.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bag.dart';

class Details extends StatefulWidget {
  final ProductModel product;

  const Details({Key key, this.product}) : super(key: key);
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final _key = GlobalKey<ScaffoldState>();
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    CartItemModel item = CartItemModel(
        id: widget.product.id,
        image: widget.product.image,
        name: widget.product.name,
        price: quantity * widget.product.price.toDouble(),
        productId: widget.product.id,
        restaurantId: widget.product.restaurantId,
        restaurantName: widget.product.restaurant,
        quantity: quantity);
    return Scaffold(
        key: _key,
        backgroundColor: white,
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: black),
          backgroundColor: white,
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                changeScreen(context, ShoppingBag());
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 30.0,
              ),
              Center(
                child: CircleAvatar(
                    radius: 120.0,
                    backgroundImage: NetworkImage(widget.product.image)),
              ),
              SizedBox(height: 20.0),
              CustomText(
                text: widget.product.name,
                designedtext: true,
                size: 30.0,
              ),
              CustomText(
                text: "\$" + (widget.product.price * quantity).toString(),
                size: 20.0,
              ),
              SizedBox(height: 18),
              CustomText(
                text: "Description",
                fontweight: FontWeight.w500,
                size: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(
                  text: widget.product.description,
                  fontweight: FontWeight.w300,
                  color: grey,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 8, 30, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        if (quantity != 1) {
                          setState(() {
                            quantity -= 1;
                          });
                        }
                      },
                      color: red,
                      iconSize: 50.0,
                    ),
                    Container(
                      height: 50.0,
                      width: 210,
                      decoration: BoxDecoration(
                        color: red,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          userProvider.userModel.addProductToCart(item);
                          print(userProvider.userModel.cart.length);
                          _key.currentState.showSnackBar(SnackBar(
                              duration: Duration(seconds: 1),
                              content: Text(
                                "Item Added",
                                textAlign: TextAlign.center,
                              )));
                        },
                        child: Center(
                          child: CustomText(
                            text: "Add $quantity To Bag",
                            designedtext: true,
                            color: white,
                            size: 30.0,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          quantity += 1;
                        });
                      },
                      color: black,
                      iconSize: 50.0,
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

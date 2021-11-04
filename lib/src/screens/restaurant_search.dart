import 'package:FoodOrderingApp/src/helpers/commons.dart';
import 'package:FoodOrderingApp/src/helpers/screen_navigation.dart';
import 'package:FoodOrderingApp/src/providers/app.dart';
import 'package:FoodOrderingApp/src/providers/product_provider.dart';
import 'package:FoodOrderingApp/src/providers/restaurant_provider.dart';
import 'package:FoodOrderingApp/src/screens/product_by_restaurant.dart';
import 'package:FoodOrderingApp/src/widgets/customtext.dart';
import 'package:FoodOrderingApp/src/widgets/loading.dart';

import 'package:FoodOrderingApp/src/widgets/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: CustomText(
              text: "Restaurants",
              designedtext: true,
              size: 30.0,
            ),
          ),
          backgroundColor: white,
          iconTheme: IconThemeData(color: black),
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {},
            )
          ],
        ),
        body: appProvider.isloading
            ? Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Loading(),
                  ],
                ),
              )
            : restaurantProvider.restaurantsSearched.length < 1
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search, color: grey, size: 30),
                        ],
                      ),
                      SizedBox(height: 15.0),
                      CustomText(
                          color: grey,
                          fontweight: FontWeight.w300,
                          text: "No Restaurant Found",
                          designedtext: true,
                          size: 30.0)
                    ],
                  )
                : ListView.builder(
                    itemCount: restaurantProvider.restaurantsSearched.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          appProvider.changeLoadingState();
                          await productProvider.loadProdcutsByRestaurant(
                              restaurantId: restaurantProvider
                                  .restaurantsSearched[index].id);

                          changeScreen(
                              context,
                              ProductsByRestaurantScreen(
                                restaurantModel: restaurantProvider
                                    .restaurantsSearched[index],
                              ));
                          appProvider.changeLoadingState();
                        },
                        child: RestaurantWidget(
                          restaurantModel:
                              restaurantProvider.restaurantsSearched[index],
                        ),
                      );
                    }));
  }
}

import 'package:FoodOrderingApp/src/helpers/screen_navigation.dart';
import 'package:FoodOrderingApp/src/providers/app.dart';
import 'package:FoodOrderingApp/src/providers/category_provider.dart';
import 'package:FoodOrderingApp/src/providers/product_provider.dart';
import 'package:FoodOrderingApp/src/providers/restaurant_provider.dart';
import 'package:FoodOrderingApp/src/providers/user_provider.dart';
import 'package:FoodOrderingApp/src/screens/bag.dart';
import 'package:FoodOrderingApp/src/screens/product_by_category_screen.dart';

import 'package:FoodOrderingApp/src/screens/product_by_restaurant.dart';
import 'package:FoodOrderingApp/src/screens/product_search.dart';
import 'package:FoodOrderingApp/src/screens/restaurant_search.dart';
import 'package:FoodOrderingApp/src/widgets/bottom_nav_icon.dart';
import 'package:FoodOrderingApp/src/widgets/categories.dart';
import 'package:FoodOrderingApp/src/helpers/commons.dart';
import 'package:FoodOrderingApp/src/widgets/customtext.dart';
import 'package:FoodOrderingApp/src/widgets/featured_products.dart';
import 'package:FoodOrderingApp/src/widgets/loading.dart';
import 'package:FoodOrderingApp/src/widgets/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool loading = true;
  @override
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);
    setState(() {
      if (userProvider.name != null && userProvider.email != null) {
        loading = false;
      }
      ;
    });
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: white),
              elevation: 0.5,
              backgroundColor: black,
              title: CustomText(
                text: "FoodApplication",
                size: 30.0,
                color: white,
                designedtext: true,
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    changeScreen(context, ShoppingBag());
                  },
                  color: white,
                ),
                Stack(
                  children: [
                    IconButton(
                      icon: Icon(Icons.notifications_none),
                      onPressed: () => print("hello"),
                      color: white,
                    ),
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          color: red,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            drawer: Drawer(
              child: ListView(
                children: [
                  UserAccountsDrawerHeader(
                    decoration: BoxDecoration(color: black),
                    accountName: CustomText(
                      text: "userProvider.userModel.name",
                      designedtext: true,
                      size: 30.0,
                      color: white,
                    ),
                    accountEmail: CustomText(
                      text: "userProvider.userModel.email",
                      color: grey[400],
                    ),
                  ),
                  ListTile(
                      onTap: () => null,
                      leading: Icon(
                        Icons.home,
                        color: black,
                      ),
                      title: CustomText(
                        size: 30,
                        text: "Home",
                        designedtext: true,
                      )),
                  ListTile(
                      onTap: () async => userProvider.singOut(),
                      leading: Icon(
                        Icons.person,
                        color: black,
                      ),
                      title: CustomText(
                        size: 30,
                        text: "Sign out",
                        designedtext: true,
                      )),
                  ListTile(
                      onTap: () {
                        changeScreen(context, ShoppingBag());
                      },
                      leading: Icon(
                        Icons.shopping_cart,
                        color: black,
                      ),
                      title: CustomText(
                        size: 30,
                        text: "Cart",
                        designedtext: true,
                      )),
                ],
              ),
            ),
            backgroundColor: white,
            body: appProvider.isloading
                ? Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Loading(),
                      ],
                    ),
                  )
                : SafeArea(
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 10.0,
                          child: Container(
                            color: black,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: black,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20.0),
                                  bottomRight: Radius.circular(20.0))),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(20.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color: grey[400],
                                        offset: Offset(1, 1),
                                        blurRadius: 4),
                                  ]),
                              child: ListTile(
                                leading: Icon(Icons.search, color: red),
                                title: TextField(
                                  textInputAction: TextInputAction.search,
                                  onSubmitted: (pattern) async {
                                    appProvider.changeLoadingState();
                                    if (appProvider.search ==
                                        SearchBy.PRODUCT) {
                                      await productProvider.search(
                                          productName: pattern);
                                      changeScreen(
                                          context, ProductSearchScreen());
                                    } else {
                                      await restaurantProvider.searchRestaurant(
                                          restaurantName: pattern);
                                      changeScreen(
                                          context, RestaurantSearchScreen());
                                    }
                                    appProvider.changeLoadingState();
                                  },
                                  decoration: InputDecoration(
                                      hintText: "Find a food or a restaurant",
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomText(
                              text: "Search By:",
                            ),
                            DropdownButton<String>(
                                value: appProvider.filterBy,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.primaries[0],
                                  fontWeight: FontWeight.w300,
                                ),
                                icon: Icon(
                                  Icons.filter_list,
                                  color: red,
                                ),
                                elevation: 0,
                                onChanged: (value) {
                                  if (value == "Products") {
                                    appProvider.changeSearchBy(
                                        newsearchBy: SearchBy.PRODUCT);
                                  } else {
                                    appProvider.changeSearchBy(
                                        newsearchBy: SearchBy.RESTAURANT);
                                  }
                                },
                                items: <String>[
                                  "Products",
                                  "Restaurants"
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem(
                                      value: value, child: Text(value));
                                }).toList()),
                          ],
                        ),
                        Divider(
                          color: black,
                          indent: 60.0,
                          endIndent: 60,
                          thickness: 3.0,
                        ),
                        SizedBox(height: 5),
                        Container(
                          height: 100,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: categoryProvider.categories.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () async {
                                    await productProvider
                                        .loadProdcutsByCategorie(
                                            categoryName: categoryProvider
                                                .categories[index].name);
                                    changeScreen(
                                        context,
                                        CategoryScreen(
                                          category: categoryProvider
                                              .categories[index],
                                        ));
                                  },
                                  child: CategoryWidget(
                                    categoryModel:
                                        categoryProvider.categories[index],
                                  ),
                                );
                              }),
                        ),
                        // Categories(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomText(
                            text: "Featured",
                            size: 20,
                            color: grey,
                          ),
                        ),
                        Featured(
                          productModels: productProvider.products,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomText(
                            text: "Popular Restaurants",
                            size: 20,
                            color: grey,
                          ),
                        ),

                        Column(
                          children: restaurantProvider.restaurants
                              .map(
                                (item) => GestureDetector(
                                  onTap: () async {
                                    await productProvider
                                        .loadProdcutsByRestaurant(
                                            restaurantId: item.id);
                                    ;
                                    changeScreen(
                                        context,
                                        ProductsByRestaurantScreen(
                                          restaurantModel: item,
                                        ));
                                  },
                                  child: RestaurantWidget(
                                    restaurantModel: item,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
          );
  }
}

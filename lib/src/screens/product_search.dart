import 'package:FoodOrderingApp/src/helpers/commons.dart';
import 'package:FoodOrderingApp/src/helpers/screen_navigation.dart';
import 'package:FoodOrderingApp/src/providers/app.dart';
import 'package:FoodOrderingApp/src/providers/product_provider.dart';
import 'package:FoodOrderingApp/src/screens/details.dart';
import 'package:FoodOrderingApp/src/widgets/customtext.dart';
import 'package:FoodOrderingApp/src/widgets/product_byCategory.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: CustomText(
              text: "Products",
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
        body: productProvider.productsSearched.length < 1
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
                      text: "No product Found",
                      designedtext: true,
                      size: 30.0)
                ],
              )
            : ListView.builder(
                itemCount: productProvider.productsSearched.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      appProvider.changeLoadingState();

                      changeScreen(
                          context,
                          Details(
                            product: productProvider.productsSearched[index],
                          ));
                      appProvider.changeLoadingState();
                    },
                    child: ProductWidget(
                        product: productProvider.productsSearched[index]),
                  );
                }));
  }
}

import 'package:FoodOrderingApp/src/helpers/commons.dart';
import 'package:FoodOrderingApp/src/helpers/screen_navigation.dart';
import 'package:FoodOrderingApp/src/models/products.dart';
import 'package:FoodOrderingApp/src/providers/product_provider.dart';
import 'package:FoodOrderingApp/src/providers/restaurant_provider.dart';
import 'package:FoodOrderingApp/src/screens/product_by_restaurant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import 'customtext.dart';

class ProductWidget extends StatelessWidget {
  final ProductModel product;

  const ProductWidget({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    return Container(
      height: 130,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 130,
          width: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: grey[300], style: BorderStyle.solid),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 130,
                width: 140,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      topLeft: Radius.circular(20.0)),
                  child: FadeInImage.memoryNetwork(
                    fit: BoxFit.cover,
                    image: product.image,
                    placeholder: kTransparentImage,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: product.name,
                            designedtext: true,
                            size: 30.0,
                          ),
                          Icon(Icons.favorite_border_outlined),
                        ],
                      ),
                      Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CustomText(
                                    text: "From: ", color: grey, size: 14.0),
                                GestureDetector(
                                  onTap: () async {
                                    await productProvider
                                        .loadProdcutsByRestaurant(
                                            restaurantId: product.restaurantId);
                                    await restaurantProvider
                                        .loadSingleRestaurant(
                                            restaurantid: product.restaurantId);
                                    changeScreen(
                                        context,
                                        ProductsByRestaurantScreen(
                                          restaurantModel:
                                              restaurantProvider.restaurant,
                                        ));
                                  },
                                  child: CustomText(
                                      text: product.restaurant,
                                      color: red[800]),
                                )
                              ],
                            ),
                            SizedBox(height: 5.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CustomText(
                                        text: product.rating.toString(),
                                        color: grey,
                                        size: 14.0),
                                    Icon(
                                      Icons.star,
                                      color: Colors.orange,
                                      size: 20.0,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.orange,
                                      size: 20.0,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.orange,
                                      size: 20.0,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.orange,
                                      size: 20.0,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: grey,
                                      size: 20.0,
                                    ),
                                  ],
                                ),
                                CustomText(
                                  text: "\$${product.price}",
                                  fontweight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

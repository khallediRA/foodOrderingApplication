import 'package:FoodOrderingApp/src/helpers/screen_navigation.dart';
import 'package:FoodOrderingApp/src/models/products.dart';

import 'package:FoodOrderingApp/src/screens/details.dart';
import 'package:flutter/material.dart';

import 'package:transparent_image/transparent_image.dart';

import '../helpers/commons.dart';
import 'customtext.dart';
import 'loading.dart';

class Featured extends StatelessWidget {
  final List<ProductModel> productModels;

  const Featured({Key key, @required this.productModels}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: productModels.length,
          itemBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(12, 14, 16, 12),
              child: GestureDetector(
                onTap: () {
                  changeScreen(
                    _,
                    Details(product: productModels[index]),
                  );
                },
                child: Container(
                  height: 220,
                  width: 200.0,
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                            color: grey[300],
                            offset: Offset(-2, -1),
                            blurRadius: 5),
                      ]),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Loading(),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Center(
                              child: FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image: productModels[index].image,
                                fit: BoxFit.cover,
                                height: 126,
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomText(
                              text: productModels[index].name,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(20.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color: grey[300],
                                        offset: Offset(1, 1),
                                        blurRadius: 4),
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  productModels[index].featured
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  size: 18,
                                  color: red,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: CustomText(
                                  text: productModels[index].rating.toString(),
                                  color: grey,
                                  size: 14.0,
                                ),
                              ),
                              SizedBox(width: 5.0),
                              Icon(
                                Icons.star,
                                color: red,
                                size: 16.0,
                              ),
                              Icon(
                                Icons.star,
                                color: red,
                                size: 16.0,
                              ),
                              Icon(
                                Icons.star,
                                color: red,
                                size: 16.0,
                              ),
                              Icon(
                                Icons.star,
                                color: red,
                                size: 16.0,
                              ),
                              Icon(
                                Icons.star,
                                color: grey,
                                size: 16.0,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: CustomText(
                              text:
                                  "\$${productModels[index].price.toDouble()}",
                              fontweight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

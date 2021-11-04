import 'package:FoodOrderingApp/src/helpers/commons.dart';
import 'package:FoodOrderingApp/src/models/restaurent.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'customtext.dart';
import 'loading.dart';

class RestaurantWidget extends StatelessWidget {
  final RestaurantModel restaurantModel;

  const RestaurantWidget({Key key, @required this.restaurantModel})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0, left: 2, right: 2, bottom: 4),
      child: Stack(
        children: [
          Stack(
            children: [
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Container(height: 120.0, child: Loading()),
                ),
              ),
              Center(
                child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: restaurantModel.image),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    width: 50.0,
                    decoration: BoxDecoration(
                      color: red,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.favorite,
                        color: white,
                        size: 20.0,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: white, borderRadius: BorderRadius.circular(5.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.orange,
                            size: 20.0,
                          ),
                          CustomText(
                            text: restaurantModel.rating.toString(),
                            color: black,
                            size: 15.0,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0)),
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.black.withOpacity(0.7),
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.4),
                        Colors.black.withOpacity(0.1),
                        Colors.black.withOpacity(0.05),
                        Colors.black.withOpacity(0.025),
                      ]),
                ),
              ),
            ),
          ),
          Positioned.fill(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(12.0, 8.0, 8.0, 8),
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: "${restaurantModel.name} \n",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                            color: white),
                      ),
                      TextSpan(
                        text: "Average Meal Price \n",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      TextSpan(
                        text: "\$${restaurantModel.avgPrice}DT\n",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}

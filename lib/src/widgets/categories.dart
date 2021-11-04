import 'package:FoodOrderingApp/src/models/category.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../helpers/commons.dart';
import 'customtext.dart';
import 'loading.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryModel categoryModel;

  const CategoryWidget({Key key, @required this.categoryModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            width: 140.0,
            height: 160,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Loading(),
                    ),
                  ),
                  Center(
                    child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: categoryModel.image),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: 140.0,
            height: 160,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.4),
                    Colors.black.withOpacity(0.1),
                    Colors.black.withOpacity(0.05),
                    Colors.black.withOpacity(0.025),
                  ],
                )),
          ),
          Positioned.fill(
              child: Align(
            alignment: Alignment.center,
            child: CustomText(
                text: categoryModel.name,
                designedtext: true,
                color: grey[300],
                size: 30.0),
          )),
        ],
      ),
    );
  }
}

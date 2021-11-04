import 'package:FoodOrderingApp/src/helpers/commons.dart';
import 'package:FoodOrderingApp/src/helpers/screen_navigation.dart';
import 'package:FoodOrderingApp/src/models/category.dart';
import 'package:FoodOrderingApp/src/models/products.dart';
import 'package:FoodOrderingApp/src/providers/product_provider.dart';
import 'package:FoodOrderingApp/src/screens/details.dart';
import 'package:FoodOrderingApp/src/widgets/customtext.dart';
import 'package:FoodOrderingApp/src/widgets/loading.dart';
import 'package:FoodOrderingApp/src/widgets/product_byCategory.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class CategoryScreen extends StatelessWidget {
  final CategoryModel category;

  const CategoryScreen({
    Key key,
    this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      extendBody: true,
      backgroundColor: white,
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 300,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0)),
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 300,
                        child: FadeInImage.memoryNetwork(
                          fit: BoxFit.cover,
                          image: category.image,
                          placeholder: kTransparentImage,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 300,
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
                child: Padding(
                  padding: const EdgeInsets.only(top: 140.0),
                  child: CustomText(
                      text: category.name,
                      designedtext: true,
                      color: grey[300],
                      size: 60.0),
                ),
              )),
            ],
          ),
          SizedBox(height: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: productProvider.productsByCategory
                .map(
                  (item) => GestureDetector(
                    onTap: () => print("f"),
                    child: GestureDetector(
                      onTap: () =>
                          changeScreen(context, Details(product: item)),
                      child: ProductWidget(
                        product: item,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

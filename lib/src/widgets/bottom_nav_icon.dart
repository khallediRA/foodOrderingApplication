import 'package:flutter/material.dart';

import 'customtext.dart';

class BottomNavIcon extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function onTap;

  const BottomNavIcon({Key key, this.name, this.icon, this.onTap})
      : super(key: key);

  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: onTap ?? null,
            child: Column(
              children: [
                Icon(icon),
                CustomText(
                  text: name,
                  size: 13.0,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

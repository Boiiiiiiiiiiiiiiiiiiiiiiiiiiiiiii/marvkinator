import 'package:flutter/material.dart';

class KTextStyle {
  static const TextStyle titleTealText = TextStyle(
    color: Color.fromARGB(255, 0, 197, 177),
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle descriptionText = TextStyle(
    color: Color.fromARGB(255, 0, 197, 177),
    fontSize: 16,
  );
}

class CardTextStyle {
    static TextStyle cardTitleText(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.teal[300]
          : Colors.teal,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle cardDataText(BuildContext context) {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.teal[300]
          : Colors.teal,
    );
  }
}


class KConstant{
  static const String isDarkThemeKey = 'isDarkThemeKey';
}
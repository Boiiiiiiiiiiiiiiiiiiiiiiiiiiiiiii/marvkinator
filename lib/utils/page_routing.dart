import 'package:akinator/data/notifiers.dart';
import 'package:akinator/views/pages/welcome_page.dart';
import 'package:akinator/views/widget_tree.dart';
import 'package:flutter/material.dart';

void restart(BuildContext context){
  selectedPageNotifier.value = 0;
  Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => WelcomePage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
        opacity: animation,
        child: child,
        );
      },
      transitionDuration: Duration(milliseconds: 300),
    ),
  );           
}

void toResults(BuildContext context, String result, String resultTitle){
  selectedPageNotifier.value = 2;
  Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => WidgetTree(result: result, resultTitle: resultTitle,),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
        opacity: animation,
        child: child,
        );
      },
      transitionDuration: Duration(milliseconds: 300),
    ),
  );           
}
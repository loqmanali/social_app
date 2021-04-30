import 'package:flutter/material.dart';

class AppNavigator {
  static void navigatorTo(BuildContext context, bool back, Widget widget) {
    MaterialPageRoute route = MaterialPageRoute(builder: (context) => widget);
    if (back) {
      Navigator.of(context).push(route);
    } else {
      Navigator.of(context).pushReplacement(route);
    }
  }
}

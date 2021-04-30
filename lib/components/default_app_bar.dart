import 'package:flutter/material.dart';
import 'package:social_app/styles/icon_broken.dart';

Widget defaultAppBar({
  @required BuildContext context,
  String title,
  List<Widget> actions,
}) =>
    AppBar(
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(IconBroken.Arrow___Left_2),
      ),
      titleSpacing: 5.0,
      title: Text(title),
      actions: actions,
    );

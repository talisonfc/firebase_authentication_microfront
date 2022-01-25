import 'package:flutter/material.dart';

class AppInfoMedia extends StatelessWidget {
  final bool visible;

  AppInfoMedia({this.visible = true});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: ListView(
        shrinkWrap: true,
        primary: false,
        children: [
          Container(
            width: 100,
            height: 100,
            child: Placeholder(),
          ),
          Text(
            'App Name',
            style: Theme.of(context).textTheme.headline3,
          ),
        ],
      ),
    );
  }
}

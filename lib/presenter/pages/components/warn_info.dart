import 'package:flutter/material.dart';

enum WarnType { INFO, ERROR }

class WarnInfo extends StatelessWidget {
  final WarnType warnType;
  final String text;
  final bool visible;

  WarnInfo({Key? key, this.warnType = WarnType.ERROR, required this.text, this.visible = true})
      : super(key: key);

  final tinyBorder = BorderSide(
    color: Colors.redAccent.withOpacity(.9),
  );

  final strongBoder = BorderSide(
    color: Colors.redAccent.withOpacity(.9),
    width: 4,
  );

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.redAccent.withOpacity(.1),
            border: Border(
                left: strongBoder,
                right: tinyBorder,
                top: tinyBorder,
                bottom: tinyBorder)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

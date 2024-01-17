import 'package:flutter/material.dart';

class CustomTextSpan extends StatelessWidget {
  final String title, value;
  final Color titleColor, valueColor;

  const CustomTextSpan(
      {Key key, this.title, this.value, this.titleColor, this.valueColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft, //TODO,local,
      padding: EdgeInsets.only(top: 15),
      child: RichText(
          textDirection: TextDirection.ltr, //TODO:;local
          text: TextSpan(
              text: title,
              style: Theme.of(context).textTheme.headline6.copyWith(
                  fontSize: 20,
                  color: titleColor ?? Colors.indigo,
                  shadows: [
                    Shadow(blurRadius: 1.2, color: titleColor ?? Colors.red)
                  ]),
              children: [
                TextSpan(
                    text: value,
                    style: TextStyle(
                        color: valueColor ?? Colors.red[700],
                        shadows: [
                          Shadow(offset: Offset(.15, -.1), color: Colors.black)
                        ])),
              ])),
    );
  }
}

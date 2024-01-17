import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final TextStyle textStyle;
  final int maxLines;
  final TextAlign textAlign;
  final TextDirection textDirection;
  final Locale locale;
  final String fontFamily;
  final EdgeInsets padding;
  final Color textColor;
  final FontWeight fontWeight;

  const CustomText(
      {Key key,
      @required this.text,
      this.fontSize,
      this.textStyle,
      this.maxLines,
      this.textAlign,
      this.textDirection,
      this.locale,
      this.textColor,
      this.padding,
      this.fontFamily,
      this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Text(
        text,
        style: textStyle ??
            Theme.of(context).textTheme.headline5.copyWith(
                  fontFamily: fontFamily ?? '',
                  fontWeight: fontWeight ?? FontWeight.w400,
                  fontSize:
                      fontSize ?? MediaQuery.of(context).size.width * .050,
                  //  fontSize ?? 20,
                  color: textColor ?? Theme.of(context).scaffoldBackgroundColor,
                ),
        overflow: TextOverflow.ellipsis,
        maxLines: maxLines ?? 3,
        softWrap: true,
        textAlign: textAlign ?? TextAlign.left,
        textDirection: textDirection ?? TextDirection.ltr,
        locale: locale,
      ),
    );
  }
}

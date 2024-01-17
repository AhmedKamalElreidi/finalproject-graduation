import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatefulWidget {
  final IconData icon;
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final Function validate;
  final bool hasValidate;
  final Color fieldColor;
  final Widget suffixWidget;
  final double radius;
  final Widget iconWidget;
  final TextInputType keyBoardType;
  final double border;
  final bool isFilled;
  final Color textColor;

  const CustomTextFormField(
      {Key key,
      this.icon,
      this.isFilled = false,
      @required this.controller,
      @required this.hintText,
      this.fieldColor,
      this.textColor,
      this.isPassword = false,
      @required this.validate(String value),
      this.border,
      this.radius,
      @required this.keyBoardType,
      this.suffixWidget,
      this.iconWidget,
      this.hasValidate = false})
      : super(key: key);

  @override
  CustomTextFormFieldState createState() => CustomTextFormFieldState();
}

class CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isSecured = true;
  bool iconValidation = false;
  @override
  Widget build(BuildContext context) {
    changeValidateIcon();
    final Color defaultColor = widget.fieldColor ?? Colors.white;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        onTap: () => changeValidateIcon(),

        //TODo: checking
        onChanged: (value) => changeValidateIcon(),

        textAlign: TextAlign.left, //TODO:
        controller: widget.controller,
        keyboardType: widget.keyBoardType ?? TextInputType.text,
        obscureText: isSecured && widget.isPassword ? true : false,
        style: TextStyle(
          color: widget.textColor ?? Theme.of(context).scaffoldBackgroundColor,
        ),

        decoration: InputDecoration(
          suffix: widget.suffixWidget,
          contentPadding: EdgeInsets.symmetric(horizontal: 15),
          //TODO:
          filled: true,
          prefixIcon: widget.iconWidget ??
              Icon(
                widget.icon ??
                    (iconValidation ? Icons.check_circle : Icons.circle),
                color: iconValidation ? Colors.green : Colors.grey,
              ),
          enabledBorder: _border(),
          focusedBorder: _border(),
          border: _border(defaultColor),
          disabledBorder: _border(defaultColor),
          errorBorder: _border(defaultColor),
          focusedErrorBorder: _border(defaultColor),
          focusColor: defaultColor,
          fillColor: defaultColor,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: widget.textColor ?? Colors.red,
            fontSize: 18,
          ),
          hoverColor: defaultColor,
          suffixIcon: widget.isPassword
              ? Visibility(
                  visible: widget.isPassword,
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          isSecured = !isSecured;
                        });
                      },
                      child: Icon(
                        isSecured ? Icons.visibility_off : Icons.visibility,
                        color: widget.textColor,
                      )),
                )
              : null,
        ),
        validator: widget.validate,
        cursorColor: widget.textColor,
      ),
    );
  }

  void changeValidateIcon() {
    if (widget.hasValidate == null) {
      if (widget.controller.text.isEmpty) {
        iconValidation = false;
      } else if (widget.controller.text.length >= 10) {
        if (widget.keyBoardType == TextInputType.phone) {
          if (widget.controller.text.length == 11)
            iconValidation = true;
          else
            iconValidation = false;
        } else {
          iconValidation = true;
        }
      } else {
        final _value = widget.hintText.toLowerCase();
        if (_value == 'price' ||
            _value == 'area in meters' ||
            _value == 'bathrooms' ||
            _value == 'bedrooms' ||
            _value == 'level') {
          widget.controller.text.isNotEmpty
              ? iconValidation = true
              : iconValidation = false;
        } else
          iconValidation = false;
      }
    } else {
      if (widget.validate(widget.controller.text) == null)
        iconValidation = true;
      else
        iconValidation = false;
    }

    setState(() {});
  }

  InputBorder _border([Color color]) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(widget.radius ?? 55),
        borderSide: BorderSide(
            color: color ?? Colors.purple.withOpacity(widget.border ?? .1),
            style: BorderStyle.solid),
      );

}

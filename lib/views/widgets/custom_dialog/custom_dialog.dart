import 'package:final_project_ecommerce/data/constants/material_data.dart';
import 'package:final_project_ecommerce/views/widgets/custom_text/custom_text.dart';
import 'package:flutter/material.dart';

class CustomDialog {
  const CustomDialog({this.errorText});
  final String errorText;
  static void showAlertDialog(BuildContext context, String message,
      {bool isReset = false, Widget content, List<Widget> actions}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(
            child: CustomText(
          text: 'Alert',
          textColor: MaterialData.kPrimaryColor,
        )),
        content: content ??
            CustomText(
              text: message.trim(),
              textColor: Colors.indigo,
              textAlign: TextAlign.center,
            ),
        actions: actions ??
            [
              TextButton(
                  onPressed: () {
                    if (isReset == true) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/LoginScreen', (route) => false);
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Okay'))
            ],
      ),
    );
  }
}

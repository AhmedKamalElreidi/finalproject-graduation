import 'package:flutter/material.dart';
import 'package:icon_shadow/icon_shadow.dart';

import 'custom_text/custom_text.dart';

class HeaderRow extends StatelessWidget {
  final String title;
  final IconData icon;
  final String fontFamily;

  const HeaderRow({@required this.title, @required this.icon, this.fontFamily});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              CustomText(
                text: title,
                fontFamily: fontFamily ?? 'Akaya',
                fontWeight: FontWeight.bold,
                textColor: Colors.blue.shade900,
              ),
              IconShadowWidget(
                Icon(
                  icon,
                  color: Colors.blue.shade900,
                ),
                shadowColor: Colors.white,
                // Icon(Icons.recommend)
              )
            ],
          )),
    );
  }
}

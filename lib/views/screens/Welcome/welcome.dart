import 'package:final_project_ecommerce/data/constants/material_data.dart';
import 'package:final_project_ecommerce/views/screens/Welcome/rounded_button.dart';
import 'package:final_project_ecommerce/views/screens/login/login_main_file.dart';
import 'package:final_project_ecommerce/views/screens/register/register_main_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

part 'body.dart';

part 'background.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}

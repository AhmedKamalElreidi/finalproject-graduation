import 'dart:io';
import 'dart:math';

import 'package:final_project_ecommerce/data/models/units/location.dart';
import 'package:final_project_ecommerce/views/widgets/custom_text_field.dart';
import 'package:final_project_ecommerce/data/constants/enums.dart';
import 'package:final_project_ecommerce/data/models/units/units_model.dart';
import 'package:final_project_ecommerce/data/models/user/user_data_model.dart';
import 'package:final_project_ecommerce/logic/blocs/products_bloc/products_bloc.dart';
import 'package:final_project_ecommerce/logic/cubits/signing/signing_cubit.dart';
import 'package:final_project_ecommerce/views/router/route_imports.dart';
import 'package:final_project_ecommerce/views/widgets/custom_appbar.dart';
import 'package:final_project_ecommerce/views/widgets/custom_dialog/custom_dialog.dart';
import 'package:final_project_ecommerce/views/widgets/custom_text/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_ui_builder/responsive_ui_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

part 'add_unit.dart';

part 'image_picker.dart';
part 'add_unit_helper.dart';
part 'add_unit_custom_tile.dart';
part 'row_of_added_images.dart';
part 'input_field_tile.dart';
///custom text field for resell or add unit screen
class ResellTextField extends StatelessWidget {
  final TextInputType keyBoardType;
  final IconData icon;
  final TextEditingController controller;
  final String title;

  const ResellTextField(
      {Key key,
      this.keyBoardType,
      this.icon,
      @required this.controller,
      @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .95,
      height: MediaQuery.of(context).size.height * .09,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: CustomTextFormField(
        radius: 0,
        border: 0,
        keyBoardType: keyBoardType,
        hintText: title,
        textColor: Colors.indigo,
        fieldColor: Colors.white,
        controller: controller,
        icon: icon,

        validate: keyBoardType == TextInputType.emailAddress
            ? context.watch<SigningCubit>().emailValidation
            : keyBoardType == TextInputType.phone
                ? context.watch<SigningCubit>().validateMobile
                : context.watch<SigningCubit>().defaultValidation,
      ),
    );
  }
}

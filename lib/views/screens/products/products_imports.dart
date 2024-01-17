import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_project_ecommerce/data/constants/enums.dart';
import 'package:final_project_ecommerce/data/models/units/units_model.dart';
import 'package:final_project_ecommerce/logic/blocs/products_bloc/products_bloc.dart';
import 'package:final_project_ecommerce/logic/methods/number_convert/number_converter.dart';
import 'package:final_project_ecommerce/views/router/route_imports.dart';
import 'package:final_project_ecommerce/views/widgets/custom_appbar.dart';
import 'package:final_project_ecommerce/views/widgets/custom_text/custom_text.dart';
import 'package:final_project_ecommerce/views/widgets/header_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:responsive_ui_builder/responsive_ui_builder.dart';

part 'productsScreen.dart';
part 'product_card.dart';
part 'products_list_body.dart';

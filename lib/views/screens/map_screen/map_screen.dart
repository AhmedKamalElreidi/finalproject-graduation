import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:final_project_ecommerce/data/constants/enums.dart';
import 'package:final_project_ecommerce/data/models/compounds/compounds_model.dart';
import 'package:final_project_ecommerce/generated/assets.dart';
import 'package:final_project_ecommerce/logic/blocs/products_bloc/products_bloc.dart';
import 'package:final_project_ecommerce/logic/cubits/urls_launcher/urls_cubit.dart';
import 'package:final_project_ecommerce/views/router/route_imports.dart';
import 'package:final_project_ecommerce/views/widgets/custom_appbar.dart';
import 'package:final_project_ecommerce/views/widgets/custom_text/custom_text.dart';
import 'package:responsive_ui_builder/responsive_ui_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
part 'MyMapViewWidget.dart';
part 'botom_sheet.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyCustomAppBar(
        showDrawer: false,
        elevation: 10,
        textColor: Color(0xff6200EE),
        title: 'Compounds Map',
        showLeading: true,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Container(
        color: Colors.white,
        child: FutureBuilder(
            //TODO : add seconds
            future: Future.delayed(Duration(seconds: 2)),
            builder: (context, snapshot) {
              /// filter compounds to catch only the housing compounds
              final compounds = context
                  .read<ProductsBloc>()
                  .compounds
                  .where((_compound) => _compound.distinct != 'Governmental')
                  .toList();
              if (snapshot.connectionState == ConnectionState.done)
                return MyMapViewWidget(
                  compounds: compounds,
                );
              else
                return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}

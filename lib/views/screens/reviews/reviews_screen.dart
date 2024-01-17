import 'package:final_project_ecommerce/data/constants/enums.dart';
import 'package:final_project_ecommerce/data/models/compounds/compounds_model.dart';
import 'package:final_project_ecommerce/logic/blocs/products_bloc/products_bloc.dart';
import 'package:final_project_ecommerce/views/router/route_imports.dart';
import 'package:final_project_ecommerce/views/screens/products/products_imports.dart';
import 'package:final_project_ecommerce/views/widgets/custom_appbar.dart';
import 'package:final_project_ecommerce/views/widgets/header_row.dart';
import 'package:responsive_ui_builder/responsive_ui_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
part 'review_body.dart';

class ReviewsScreen extends StatelessWidget {
  final defaultColor = Colors.blue.shade900;
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
        builder: (context, deviceInfo) => Scaffold(
              appBar: MyCustomAppBar(
                title: 'Review',
                showLeading: false,
                color: Theme.of(context).scaffoldBackgroundColor,
                textColor: defaultColor,
                elevation: 5,
                shadowColor: defaultColor,
              ),
              floatingActionButton: CupertinoButton(
                padding: EdgeInsets.zero,
                child: Container(
                    height: 70,
                    width: 70,
                    margin: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue.shade800,
                        boxShadow: [
                          BoxShadow(
                            color: defaultColor,
                            blurRadius: 4,
                          ),
                          BoxShadow(
                            color: defaultColor,
                            blurRadius: 4,
                          )
                        ]),
                    child: Icon(
                      LineIcons.alternateMapMarked,
                      size: 40,
                      color: Colors.white,
                    )),
                onPressed: () => NavigationServices.navigateTo(MapScreenRoute),
              ),
              body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: BlocBuilder<ProductsBloc, ProductsState>(
                  builder: (context, state) {
                     if (state is ErrorState)
                      return Center(child: Text('Error occurs'));
                    else if (state is CompoundsLoaded) {
                      return PreviewBody(
                          compounds: state.compoundsList,
                          deviceInfo: deviceInfo);
                    } else {
                      return Center(
                          child: CircularProgressIndicator.adaptive(
                        valueColor: AlwaysStoppedAnimation(defaultColor),
                      ));
                    }
                  },
                ),
              ),
            ));
  }
}

import 'package:final_project_ecommerce/logic/blocs/products_bloc/products_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_project_ecommerce/logic/cubits/signing/signing_cubit.dart';
import 'package:final_project_ecommerce/views/router/route_imports.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'logic/cubits/recommendation/recommendation_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //initialize firebase
  await Firebase.initializeApp();

  //Set the status bar background color.
  FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
  runApp(NewCapital());
}

class NewCapital extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Used to allow us use multiple bloc or cubit state management in the same project
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SigningCubit(),
        ),
        BlocProvider(
          create: (context) => RecommendationCubit(),
        ),
        BlocProvider(
          create: (context) => ProductsBloc()..add(LoadAllCompounds()),
        )
      ],
      child: MaterialApp(
        title: 'Aqar Broker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.indigo,
            primarySwatch: Colors.indigo,
            hoverColor: Colors.deepPurple),

        //The route generator callback used when the app is navigated to a named route.
        onGenerateRoute: AppRouter.onGeneratedRoute,
        //Navigation key passed here to let us use navigation without using ".of(context)"
        navigatorKey: NavigationServices.navigationKey,
      ),
    );
  }
}


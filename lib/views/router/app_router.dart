part of 'route_imports.dart';

class AppRouter {
  //The route generator callback used when the app is navigated to a named route.
  static Route onGeneratedRoute(RouteSettings routeSettings) {
    //object of Arguments to be used while passing data to name Navigation
    final Arguments args = routeSettings.arguments;
    //switch on route name and return corresponding screen
    switch (routeSettings.name) {

      case AuthenticateRoute:
        return _getRouteName(Authenticate());


      case MainScreenRoute:
        return _getRouteName(MainScreen());


      case LoginScreenRoute:
        return _getRouteName(LoginScreen());


      case RegisterScreenRoute:
        return _getRouteName(RegisterScreen());


      case VerificationScreenRoute:
        return _getRouteName(VerificationScreen());


      case ResetPasswordRoute:
        return _getRouteName(ResetPassword());


      case HomeScreenRoute:
        return _getRouteName(HomeScreen());


      case MapScreenRoute:
        return _getRouteName(MapScreen());


      case RecommendRoute:
        return _getRouteName(Recommend());


        case ResellRoute:
        return _getRouteName(ResellProducts());


      case AddUnitRoute:
        return _getRouteName(AddUnit(args.addingType));


      case DetailScreenRoute:
        return _getRouteName(DetailScreen(
          args.type,
          unit: args.unit,
          heroTag: args.heroTag,
        ));


        case RatingScreenRoute:
        return _getRouteName(RateScreen());


      case ProductsScreenRoute:
        return _getRouteName(ProductsScreen());


      case ReviewsScreenRoute:
        return _getRouteName(ReviewsScreen());


      case FullScreenImageView:
        return _getRouteName(ImageViewerScreen(
          providers: args.providers,
          initialPage: args.initialPage,
        ));
      default:
        return null;
    }
  }
}

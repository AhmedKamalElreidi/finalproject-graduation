part of 'route_imports.dart';

class NavigationServices {
  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  ///navigate to new screen using named routing and pass parameters.
  static Future<dynamic> navigateTo(String routeName, {Arguments arguments}) =>
      navigationKey.currentState.pushNamed(routeName, arguments: arguments);


  ///navigate to new screen using named routing and pass parameters,
  ///but this used when we need to remove the current screen from widget tree or stack
  static Future<dynamic> navigateWithReplacementTo(String routeName,
          {Arguments arguments}) =>
      navigationKey.currentState
          .pushReplacementNamed(routeName, arguments: arguments);

  ///navigate to new screen using named routing and pass parameters,
  ///but this used when we need to remove all the previous screens or widgets.
  static Future<dynamic> navigateToWithReplacementRemovedUntil(String routeName,
          {Arguments arguments}) =>
      navigationKey.currentState.pushNamedAndRemoveUntil(
          routeName, (route) => false,
          arguments: arguments);

  //navigate back to the previous screen
  static void back() => navigationKey.currentState.pop();
}

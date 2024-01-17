part of 'route_imports.dart';

///function that takes widget (screen) and return route (Material page route),
/// used to simplify the navigation
Route _getRouteName(Widget child) =>
    MaterialPageRoute(builder: (context) => child);

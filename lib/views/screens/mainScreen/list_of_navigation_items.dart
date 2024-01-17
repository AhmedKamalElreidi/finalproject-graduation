part of 'main_screen_main_file.dart';

class MainScreenData {
  static getItem(IconData iconData, String title) =>
      PersistentBottomNavBarItem(
        icon: Icon(
          iconData,
          size: 30,
        ),
        title: title,
        activeColorPrimary: Colors.blue.shade500,
        activeColorSecondary: Colors.blue.shade500,
        inactiveColorPrimary: Colors.grey.shade500,
        inactiveColorSecondary: Colors.purple,
      );

  static List<PersistentBottomNavBarItem> navBarsItems = [
    getItem(Icons.home, "Home"),
    getItem(LineIcons.globeWithAfricaShown, "Reviews"),
    getItem(LineIcons.certificate, "recommend"),
    getItem(LineIcons.ad, "Properties"),
    // getItem(LineIcons.mapMarked, "Map"),
  ];

  static List<Widget> screens = [
    HomeScreen(),
    ReviewsScreen(),
    Recommend(),
    ResellProducts(),
    // MapScreen(),
  ];
}

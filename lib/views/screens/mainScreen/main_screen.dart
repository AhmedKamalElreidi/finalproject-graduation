part of 'main_screen_main_file.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      bottomScreenMargin: 50, /////////////////////////////////////
      // screens: _buildScreens(),

      handleAndroidBackButtonPress: true,
      //Items
      items: MainScreenData.navBarsItems,
      //Screens
      screens: MainScreenData.screens,
      onItemSelected: (value) {
        //0 : home , 1:review, 2-recommend, 3-resell , 4- map
        if (value == 1) context.read<ProductsBloc>().add(LoadAllCompounds());
        if (value == 3) context.read<ProductsBloc>().add(LoadResellUnits());
      },
      decoration: NavBarDecoration(
          colorBehindNavBar: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
      popAllScreensOnTapOfSelectedTab: true,
      itemAnimationProperties: ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.fastLinearToSlowEaseIn,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.decelerate,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style4,

      backgroundColor: Color(0xebf7f9fa),

      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
    );
  }
}

part of 'home_assets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(
        Theme.of(context).scaffoldBackgroundColor,
        animate: true);
    return Scaffold(
      appBar: MyCustomAppBar(
        // showDrawer: false,
        showLeading: false,
        title: 'Home',
        textColor: Colors.blue.shade900,
        shadowColor: Colors.blue.shade900,
        elevation: 8,
        actions: [
          IconButton(
              onPressed: () {
                context.read<SigningCubit>().logout();
              },
              icon: IconShadowWidget(LineIcon(
                LineIcons.alternateSignOut,
                color: Colors.blue.shade900,
                size: 25,
              )))
        ],
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      
      floatingActionButton: Visibility(
        visible: false,
    
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          child: FloatingActionButton(
              heroTag: 'home',
              child: Icon(Icons.add),

              onPressed: () => NavigationServices.navigateTo(AddUnitRoute,
                  arguments: Arguments(addingType: UnitType.NormalUnit))
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Container(
          height: MediaQuery.of(context).size.height * .89,
          width: MediaQuery.of(context).size.width,
          child: LoadedListImages(),
        ),
      ),
    );
  }
}

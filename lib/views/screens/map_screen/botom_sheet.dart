part of 'map_screen.dart';

void showCompoundBottomSheet(
    {@required BuildContext context,
    @required CompoundModel compound,
    VoidCallback function}) {
  final defaultColor = Color(0xff6200EE);
  showModalBottomSheet(
      context: context,
      elevation: 0,
      isDismissible: true,
      routeSettings: RouteSettings(
        name: 'bottom_sheet',
      ),
      backgroundColor: Colors.transparent,
      builder: (context) => WillPopScope(
            onWillPop: () async {
              return true;
            },
            child: ResponsiveBuilder(
              builder: (context, deviceInfo) => Container(
                  height: deviceInfo.localHeight * .4,
                  width: deviceInfo.localWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: defaultColor,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          ),
                        ),
                        child: ListTile(
                          selected: true,
                          enabled: true,
                          horizontalTitleGap: 0,
                          minLeadingWidth: 0,
                          trailing: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Icon(
                              Icons.time_to_leave,
                              color: defaultColor,
                            ),
                          ),
                          title: Align(
                            alignment: Alignment.center,
                            child: CustomText(
                              text: compound.name,
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(color: Colors.white, blurRadius: 5)
                                  ],
                                  fontSize: 22),
                            ),
                          ),
                        ),
                      ),
                      customTile("${compound.rate} / 5.0",
                          Icons.star_rate_rounded, defaultColor),
                      customTile(
                        "Show all details",
                        Icons.info,
                        defaultColor,
                        function: () {
                          context.read<ProductsBloc>().compoundData = compound;
                          NavigationServices.back();
                          NavigationServices.navigateTo(DetailScreenRoute,
                              arguments: Arguments(
                                  type: DetailsNavigationType.Compound));
                        },
                      ),
                      customTile(
                        "Show In Google Maps",
                        Icons.map_rounded,
                        defaultColor,
                        function: () => UrlsCubit.launchMaps(
                            double.parse(compound.location.lat),
                            double.parse(compound.location.long)),
                      ),
                    ],
                  )),
            ),
          ),
      barrierColor: Colors.transparent,
      isScrollControlled: true);
}

Widget customTile(String title, IconData iconData, Color defaultColor,
        {VoidCallback function}) =>
    ListTile(
      leading: Icon(
        iconData,
        color: defaultColor,
        size: 30,
      ),
      onTap: function,
      title: CustomText(
        text: title,
        textColor: defaultColor,
      ),
    );

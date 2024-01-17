part of 'resell_products_screen_imports.dart';

class ResellBody extends StatelessWidget {
  final List<UnitsModel> resellsUnit;

  const ResellBody({this.resellsUnit});
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, deviceInfo) => Container(
        // height: deviceInfo.localHeight*5,
        margin: EdgeInsets.only(bottom: 50),
        child: ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: resellsUnit.length ?? 0,
          itemBuilder: (context, index) => GestureDetector(
            child: ProductCard(
              shadowColor: Colors.blue.shade900,
              image: resellsUnit[index].image1,
              deviceInfo: deviceInfo,
              productTitle: resellsUnit[index].title.trim(),
              elevation: 5,
              productPrice: numberConverter(resellsUnit[index].price + ' EGP'),
            ),
            onTap: () {
              NavigationServices.navigateTo(DetailScreenRoute,
                  arguments: Arguments(
                      unit: resellsUnit[index],
                      type: DetailsNavigationType.Unit));
            },
          ),
        ),
      ),
    );
  }
}

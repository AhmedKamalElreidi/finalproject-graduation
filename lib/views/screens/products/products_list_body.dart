part of 'products_imports.dart';

class ProductsListBody extends StatelessWidget {
  final List<UnitsModel> units;

  const ProductsListBody(this.units);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, deviceInfo) {
        final recommendList = <UnitsModel>[];
        units.forEach((element) {
          if (recommendList.length < 2) recommendList.add(element);
        });

        return Visibility(
          visible: units.isNotEmpty,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: HeaderRow(
                    title: 'Recommendation  ',
                    icon: CupertinoIcons.checkmark_seal_fill),
              ),
              buildColumn(recommendList, deviceInfo),
              Visibility(
                  visible: recommendList.length != units.length,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: HeaderRow(
                            title: 'All Units  ',
                            icon: CupertinoIcons.sparkles),
                      ),
                      buildColumn(
                          units
                              .where(
                                  (element) => !recommendList.contains(element))
                              .toList(),
                          deviceInfo,
                          isShuffled: false),
                    ],
                  ))
            ],
          ),
          replacement: Center(
            child: CustomText(
              text: "No results.",
              textColor: Colors.indigo,
            ),
          ),
        );
      },
    );
  }

  Widget buildColumn(List<UnitsModel> units, deviceInfo,
      {bool isShuffled = false}) {
    if (isShuffled) units.shuffle();
    return Visibility(
      replacement: Center(
        child: CustomText(
          text: "No results.",
          textColor: Colors.indigo,
        ),
      ),
      visible: units.length != 0,
      child: Column(
        children: List.generate(
            units.length,
            (index) => GestureDetector(
                  child: ProductCard(
                    shadowColor: Colors.blue.shade600,
                    image: units[index].image1,
                    deviceInfo: deviceInfo,
                    productRate: units[index].rate,
                    productTitle: units[index].title.trim(),
                    elevation: 8,
                    productPrice: numberConverter(units[index].price + ' EGP'),
                  ),
                  onTap: () {
                    NavigationServices.navigateTo(DetailScreenRoute,
                        arguments: Arguments(
                            unit: units[index],
                            category: units[index].type,
                            type: DetailsNavigationType.Unit,
                            heroTag: isShuffled
                                ? units[index].id
                                : units[index].id + 'r'));
                  },
                )),
      ),
    );
  }
}

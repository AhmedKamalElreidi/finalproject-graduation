part of 'reviews_screen.dart';

class PreviewBody extends StatelessWidget {
  final List<CompoundModel> compounds;
  final DeviceInfo deviceInfo;

  const PreviewBody(
      {Key key, @required this.compounds, @required this.deviceInfo})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height:  deviceInfo.screenHeight,
      margin: EdgeInsets.only(bottom: 15),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            //all compounds Text
            HeaderRow(
              title: 'All Compounds ',
              icon: CupertinoIcons.smallcircle_circle_fill,
            ),
            compoundsColumn(context, compounds, shuffle: true)
          ],
        ),
      ),
    );
  }

  Widget compoundsColumn(
      BuildContext bodyContext, List<CompoundModel> compounds,
      {bool shuffle = false}) {
    return Column(
      children: List.generate(compounds.length ?? 0, (index) {
        var compound = compounds[index];
        if (shuffle) {
          final list = compounds;
          compound = list[index];
        }
        return GestureDetector(
          onTap: () {
            bodyContext.read<ProductsBloc>().compoundData = compound;
            NavigationServices.navigateTo(DetailScreenRoute,
                arguments: Arguments(type: DetailsNavigationType.Compound));
          },
          child: ProductCard(
              image: compound.image1,
              shadowColor: Colors.blue.shade900,
              textStyle: TextStyle(
                color: Colors.blue.shade900,
                shadows: [Shadow(color: Colors.blue.shade700, blurRadius: 5)],
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
              elevation: 5,
              deviceInfo: deviceInfo,
              cardHeight: deviceInfo.localHeight * .2,
              fontSize: 18,
              productTitle: compound.name),
        );
      }),
    );
  }
}

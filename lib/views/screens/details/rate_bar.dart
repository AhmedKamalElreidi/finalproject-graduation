part of 'detail_screen_imports.dart';

class CompoundRatingWidget extends StatelessWidget {
  final CompoundModel compound;
  final DeviceInfo deviceInfo;

  static var numberOfRates = 0;

  ///widget of rating contains rate of compound
  CompoundRatingWidget(this.compound, this.deviceInfo);
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: compound.distinct.toLowerCase() == 'housing',
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            customRow(
                title: 'Rating',
                widget: Visibility(
                    visible: compound.population
                        .contains(FirebaseAuth.instance.currentUser.uid),
                    child: GestureDetector(
                        onTap: () async {
                          if (compound != null) {
                            context
                                .read<ProductsBloc>()
                                .add(LoadCompoundById(compound.id));
                            context.read<ProductsBloc>().compoundData =
                                compound;
                            NavigationServices.navigateTo(RatingScreenRoute);
                            context
                                .read<ProductsBloc>()
                                .add(LoadAllCompounds());
                          }
                        },
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.black,
                          size: 32,
                        )))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              //widget displays row of title and other widget
              child: customRow(
                title: compound.rate.toStringAsFixed(2),
                fontSize: 40,
                widget: Container(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomText(
                      text: "Total Reviews: ${compound.numberOfRates}",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      textColor: Colors.black,
                    ),
                    RatingBarIndicator(
                      rating: compound.rate ?? 0,
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 25,
                      direction: Axis.horizontal,
                    ),
                  ],
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
//widget displays row of title and other widget
  Widget customRow({String title, Widget widget, double fontSize}) {
    return Container(
      height: deviceInfo.localHeight * .09,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          CustomText(
            text: title,
            textColor: Colors.black,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
          widget
        ]),
      ),
    );
  }
}

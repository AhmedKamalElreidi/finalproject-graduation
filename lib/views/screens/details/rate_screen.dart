part of 'detail_screen_imports.dart';

class RateScreen extends StatefulWidget {
  @override
  _RateScreenState createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {
  var _rate = 0.0;
  var _ignoreRate = true;
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyCustomAppBar(
        color: Colors.white,
        title: 'Rate',
      ),
      body: Container(
        child: ResponsiveBuilder(
          builder: (context, deviceInfo) =>
              BlocBuilder<ProductsBloc, ProductsState>(
                  builder: (context, state) {
            if (state is ProductsLoadingState)
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            else
              return Container(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 8),
                height: deviceInfo.localHeight * .7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    HeaderRow(
                      title: "Choose your rate and click send Review ",
                      icon: Icons.rate_review,
                    ),
                    Align(
                      // alignment:Alignment.centerLeft,
                      child: CustomText(
                        text:
                            'Total Rate: ${context.watch<ProductsBloc>().compoundData.rate.toStringAsPrecision(3)}',
                        fontWeight: FontWeight.bold,
                        textColor: Colors.black54,
                      ),
                    ),
                    Card(
                      child: Container(
                        alignment: Alignment.center,
                        height: deviceInfo.localHeight * .2,
                        width: deviceInfo.localWidth * .9,
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RatingBar.builder(
                              initialRating: _rate ?? 4,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                _rate = rating;
                                _ignoreRate = false;
                                setState(() {});
                              },
                            ),
                            Visibility(
                              visible: _rate != 0.0,
                              child: Text(
                                "Your rate is:  ${_rate.toStringAsPrecision(3)}",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    IgnorePointer(
                      ignoring: _ignoreRate,
                      child: CupertinoButton(
                        color: Colors.indigo,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 3.0, horizontal: 15),
                          child: CustomText(
                            text: "Send Review",
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            // textColor: Colors.blue.shade900,
                          ),
                        ),
                        onPressed: () {
                          ///1-get compound data from the global stored in products bloc
                          ///2-calculate the new rate average
                          ///3-send updates to firebase fire-store
                          ///4-show dialog to notify user that something is happening
                          final compound =
                              context.read<ProductsBloc>().compoundData;
                          var totalRate =
                              compound.rate * compound.numberOfRates;
                          totalRate = (totalRate + _rate) /
                              (compound.numberOfRates + 1);

                          if (compound.rate == 5.0) {
                            totalRate = 5;
                          }

                          context.read<ProductsBloc>()
                            ..add(AddRatingToCompound(
                                rate: totalRate,
                                compoundId: compound.id,
                                numberOfRates: compound.numberOfRates + 1));
                          showRatingDialog(context, compoundID: compound.id,
                              okPressed: () {
                            context.read<ProductsBloc>()
                              ..add(LoadCompoundById(
                                compound.id,
                              ))
                              ..add(LoadAllCompounds());
                            NavigationServices.back();
                          });
                        },
                      ),
                    )
                  ],
                ),
              );
          }),
        ),
      ),
    );
  }
}

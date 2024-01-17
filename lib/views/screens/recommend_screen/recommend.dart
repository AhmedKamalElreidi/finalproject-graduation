part of 'recommend_imports.dart';

class Recommend extends StatelessWidget {
  static bool _isVilla = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(
        showDrawer: false,
        showLeading: false,
        title: 'Recommend',
        color: Theme.of(context).scaffoldBackgroundColor,
        textColor: Colors.blue.shade900,
      ),
      body: BlocBuilder<RecommendationCubit, RecommendationState>(
        builder: (context, state) => Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ResponsiveBuilder(
            builder: (context, deviceInfo) {
              return SingleChildScrollView(
                child: Container(
                  height: deviceInfo.localHeight,
                  width: deviceInfo.localWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: CustomText(
                          text:
                              'When you choose your budget that help us to recommend you better choices without any extra effort from you.',
                          maxLines: 5,
                          textStyle: TextStyle(fontSize: 20, shadows: [
                            Shadow(color: Colors.black, blurRadius: 1)
                          ]),
                        ),
                      ),
                      //Header of budget
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: HeaderRow(
                            title: 'Budget  ',
                            icon: CupertinoIcons.money_dollar_circle_fill),
                      ),

                      ///box of the budget

                      Container(
                        alignment: Alignment.center,
                        color: Colors.black12,
                        height: deviceInfo.localHeight * .1,
                        width: deviceInfo.localWidth * .77,
                        child: CustomText(
                          text: numberConverter(context
                              .read<RecommendationCubit>()
                              .budget
                              .toInt()
                              .toString()),
                          textColor: Colors.blue.shade900,
                        ),
                      ),

                      //Slider to choose the price or budget value
                      BudgetSlider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustomCheckBox(
                            header: 'Choose the type of unit',
                            value: _isVilla,
                            onChanged: (newValue) {
                              if (newValue) {
                                _isVilla = true;
                                context
                                    .read<RecommendationCubit>()
                                    .changeUnitType('villa');
                              } else {
                                _isVilla = false;
                                context
                                    .read<RecommendationCubit>()
                                    .changeUnitType('apartment');
                              }
                            },
                            title: 'Villa',
                            subTitle: 'Apartments'),
                      ),
                      Container(
                        height: deviceInfo.localHeight * .1,
                        width: deviceInfo.localWidth * .9,
                        child: CupertinoButton(
                          color: Colors.blue.shade900,
                          child: CustomText(
                            text: 'Show Me',
                            textColor: Colors.white,
                          ),
                          onPressed: () {
                            context.read<ProductsBloc>().add(LoadAllUnits(
                                type: _isVilla ? 'villa' : 'apartment',
                                budget: context
                                    .read<RecommendationCubit>()
                                    .budget));
                            NavigationServices.navigateTo(ProductsScreenRoute);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

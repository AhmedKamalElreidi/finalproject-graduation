part of 'detail_screen_imports.dart';

class DetailScreen extends StatelessWidget {
  final UnitsModel unit;
  final String heroTag;
  final DetailsNavigationType type;

  DetailScreen(
    this.type, {
    this.heroTag,
    this.unit,
  });

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          final imageList = <String>[];
          switch (type) {
            case DetailsNavigationType.Compound:
              final compound = context.read<ProductsBloc>().compoundData;
              imageList.add(compound.image1);
              if (compound.image2 != null) imageList.add(compound.image2);
              if (compound.image3 != null) imageList.add(compound.image3);
              break;
            case DetailsNavigationType.Unit:
              imageList.add(unit.image1);
              if (unit.image2 != null) imageList.add(unit.image2);
              if (unit.image3 != null) imageList.add(unit.image3);
              break;
          }
          return Scaffold(
            backgroundColor: Colors.white,
            floatingActionButton: Visibility(
              visible: (type == DetailsNavigationType.Unit &&
                  unit.supplierId == FirebaseAuth.instance.currentUser.uid &&unit.compoundId == 'none'),
              child: DeleteFloatingActionButton(unit),
            ),
            body: ResponsiveBuilder(
              builder: (context, deviceInfo) {
                return Container(
                  child: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        expandedHeight:
                            MediaQuery.of(context).size.height / 2.2,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Stack(
                            children: [
                              // list of scroll screens
                              ScrollImageList(
                                deviceInfo: deviceInfo,
                                imageList: imageList,
                              ),

                              SafeArea(
                                ///separate custom appbar contains leading
                                child: CustomSliverAppBar(
                                    showEdit: false,
                                    deviceInfo: deviceInfo,
                                    type: type),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate([
                          Visibility(
                            visible: type == DetailsNavigationType.Compound,
                            //if details of compound requested to load will display this widget
                            child: CompoundsDetailsBody(deviceInfo),

                            //if details of units requested to load will display this widget
                            replacement: UnitsDetailsBody(
                              unit,
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

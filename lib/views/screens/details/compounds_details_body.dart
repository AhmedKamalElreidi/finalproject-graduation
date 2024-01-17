part of 'detail_screen_imports.dart';

///Compounds body widget displays custom view for compounds
class CompoundsDetailsBody extends StatelessWidget {
  final DeviceInfo deviceInfo;
  CompoundsDetailsBody(this.deviceInfo);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            ///details of compound or overview widget
            child: DetailsCard(
              title: '',
              objectName: context.watch<ProductsBloc>().compoundData.name,
              subTitle: context.watch<ProductsBloc>().compoundData.details,
            ),
          ),
          ///widget of rating contains rate of compound
          CompoundRatingWidget(
              context.watch<ProductsBloc>().compoundData, deviceInfo),
        ],
      ),
    );
  }
}

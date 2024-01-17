part of 'detail_screen_imports.dart';


class CustomSliverAppBar extends StatelessWidget {
  final DeviceInfo deviceInfo;
  final bool showEdit;
  final DetailsNavigationType type;
///separate custom appbar
  const CustomSliverAppBar(
      {Key key, this.deviceInfo, this.type, this.showEdit = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: deviceInfo.localHeight * .07,
      padding: EdgeInsets.symmetric(horizontal: 4),
      alignment: Alignment.topCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: IconShadowWidget(
              Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.white,
                size: 30,
              ),
              shadowColor: Colors.black,
              showShadow: true,
            ),
            onPressed: () {
              if (type == DetailsNavigationType.Compound) {
                context.read<ProductsBloc>().add(LoadAllCompounds());
              }
              NavigationServices.back();
            },
          ),
          // Visibility(
          //   visible: showEdit,
          //   child: IconButton(
          //       icon: IconShadowWidget(
          //         Icon(
          //           Icons.edit,
          //           color: Colors.white,
          //           size: 30,
          //         ),
          //         shadowColor: Colors.black,
          //         showShadow: true,
          //       ),
          //       onPressed: () {}),
          // ),
        ],
      ),
    );
  }
}

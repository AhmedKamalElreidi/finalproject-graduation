part of 'route_imports.dart';

///this class used to help us while navigate and pass
/// data between screen using name routing,
///by take an object of it inside app routing class and pass
///its variables to suitable parameter of screen each screen
class Arguments {
  //model to store and handle the data of units
  final UnitsModel unit;

  //type of adding it's an enum just used to check
  // while adding the type of adding if it
  // ResellUnit or new unit(used inside add units
  // screen and functions of adding data to firebase at ProductsBloc)
  final UnitType addingType;

  //model to store and handle the data of compounds
  final CompoundModel compound;

  //it's an enum => type of Navigation used to discrimination
  // between Displayed data in the details screen
 //
  final DetailsNavigationType type;
  final String productName;
  final String productPrice;
  //villa or apartment
  final String category;
  final String heroTag;
  //cached providers pass to full screen images preview to avoid loading
  final List<CachedNetworkImageProvider> providers;

  //first image displayed of product or unit images
  final int initialPage;

  Arguments(
      {this.compound,
      this.productName,
      this.initialPage,
      this.type,
      this.heroTag,
      this.providers,
      this.productPrice,
      this.category,
      this.addingType,
      this.unit});
}

part of 'products_bloc.dart';

@immutable
abstract class ProductsEvent {}

class AddNewProduct extends ProductsEvent {
  final UnitsModel unit;
  final File image;
  final File image2;
  final File image3;

  AddNewProduct(
      {@required this.unit, @required this.image, this.image2, this.image3});
}

class AddNewResellUnit extends ProductsEvent {
  final UnitsModel unit;
  final File image;
  final File image2;
  final File image3;

  AddNewResellUnit(
      {@required this.unit, @required this.image, this.image2, this.image3});
}

class AddNewCompound extends ProductsEvent {
  final CompoundModel compound;
  final File image;

  AddNewCompound({@required this.compound, @required this.image});
}

class DeleteProduct extends ProductsEvent {
  final UnitsModel unit;
  final UnitType unitType;

  DeleteProduct(this.unit, this.unitType);
}

class UpdateProduct extends ProductsEvent {
  final UnitsModel unit;
  final File image;
  final File image2;
  final File image3;

  UpdateProduct(this.unit, this.image, {this.image2, this.image3});
}

class LoadUnitsOfCompound extends ProductsEvent {
  final String compoundId;
  final String category;

  LoadUnitsOfCompound(this.compoundId, this.category);
}

class LoadResellUnits extends ProductsEvent {}

class LoadUnitById extends ProductsEvent {
  final String unitId;
  final String compoundID;

  LoadUnitById({@required this.compoundID, @required this.unitId});
}

class LoadAllCompounds extends ProductsEvent {}

class LoadCompoundById extends ProductsEvent {
  final String compoundID;

  LoadCompoundById(this.compoundID);
}

class LoadAllUnits extends ProductsEvent {
  final double budget;
  final String type;

  LoadAllUnits({@required this.budget, @required this.type});
}

class AddRatingToCompound extends ProductsEvent {
  final double rate;
  final int numberOfRates;
  final String compoundId;

  AddRatingToCompound({this.rate, this.numberOfRates, this.compoundId});
}

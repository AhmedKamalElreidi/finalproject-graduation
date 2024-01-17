part of 'products_bloc.dart';

@immutable
abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoadingState extends ProductsState {}

class NewProductAdded extends ProductsState {}

class SuccessState extends ProductsState {}

class ProductDeleted extends ProductsState {}

class ProductUpdated extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<UnitsModel> productList;

  ProductsLoaded(this.productList);
}

class CompoundsLoaded extends ProductsState {
  final List<CompoundModel> compoundsList;

  CompoundsLoaded(this.compoundsList);
}

class NewCompoundAdded extends ProductsState {}

class SpecificUnitLoaded extends ProductsState {
  final UnitsModel unit;

  SpecificUnitLoaded(this.unit);
}

class SpecificCompoundLoaded extends ProductsState {
  final CompoundModel compound;

  SpecificCompoundLoaded(this.compound);
}

class ErrorState extends ProductsState {
  final String error;

  ErrorState(this.error);
}

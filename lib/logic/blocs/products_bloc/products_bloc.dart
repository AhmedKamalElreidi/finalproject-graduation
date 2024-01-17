import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_ecommerce/data/constants/enums.dart';
import 'package:final_project_ecommerce/data/models/compounds/compounds_model.dart';
import 'package:final_project_ecommerce/data/models/units/location.dart';
import 'package:final_project_ecommerce/data/models/units/units_model.dart';
import 'package:final_project_ecommerce/data/models/user/user_data_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:meta/meta.dart';

part 'products_event.dart';

part 'products_state.dart';
part 'products_repository.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ///instance of firebase fire-store database
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  List<UnitsModel> units = <UnitsModel>[];
  List<CompoundModel> compounds = <CompoundModel>[];
  CompoundModel compoundData = CompoundModel();

  final ProductsRepository repository = ProductsRepository();

  ProductsBloc() : super(ProductsInitial());

  @override
  Stream<ProductsState> mapEventToState(
    ProductsEvent event,
  ) async* {
    yield ProductsLoadingState();
    try {
      if (event is AddNewProduct) {
        repository.addNewProduct(
            file: event.image,
            addingType: UnitType.NormalUnit,
            unit: event.unit,
            file2: event.image2,
            file3: event.image3);
        yield NewProductAdded();


      }

      else if (event is DeleteProduct) {
        repository.deleteProduct(product: event.unit,type: event.unitType);
        yield ProductDeleted();
      }


      else if (event is UpdateProduct) {
        repository.addNewProduct(
            file: event.image,
            addingType: UnitType.NormalUnit,
            unit: event.unit,
            file2: event.image2,
            file3: event.image3);
        yield ProductUpdated();
      }


      else if (event is LoadUnitsOfCompound) {
        units =
            await repository.getUnitsByCompoundId(compoundId: event.compoundId);
        yield ProductsLoaded(units);
      }


      else if (event is LoadUnitById) {
        final unit = await repository.loadProductByID(
            prodId: event.unitId, compoundId: event.compoundID);
        yield SpecificUnitLoaded(unit);
      }


      else if (event is LoadAllCompounds) {
        compounds = await repository.getCompoundsData();
        yield CompoundsLoaded(compounds);
      }


      else if (event is AddNewCompound) {
        await repository.addCompound(event.compound, event.image);
        yield NewCompoundAdded();
      }


      else if (event is AddNewResellUnit) {
        await repository.addNewProduct(
            file: event.image,
            file3: event.image3,
            file2: event.image2,
            unit: event.unit,
            addingType: UnitType.ResellUnit);
        yield NewProductAdded();
      }


      else if (event is LoadResellUnits) {
        units = await repository.loadResellUnits();
        yield ProductsLoaded(units);
      }



      else if (event is LoadCompoundById) {
        compoundData = await repository.loadCompoundById(event.compoundID);
        yield SpecificCompoundLoaded(compoundData);
      }


      else if (event is AddRatingToCompound) {
        await repository.addRatingToCompound(
            compoundId: event.compoundId,
            rate: event.rate,
            totalNumberOfRates: event.numberOfRates);
        yield ProductUpdated();
      }


      else if (event is LoadAllUnits) {
        units = await repository.loadAllUnits(event.type);
        units.removeWhere(
            (element) => double.parse(element.price) > event.budget);
        units.sort((a, b) => b.rate.compareTo(a.rate));
        yield (ProductsLoaded(units));
      }
    } catch (error) {
      //print(error);
      yield ErrorState(error.toString());
    }
  }
}

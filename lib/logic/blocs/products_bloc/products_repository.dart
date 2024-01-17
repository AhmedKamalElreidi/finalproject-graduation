part of 'products_bloc.dart';

///repository of all functions and loaded data
class ProductsRepository {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  ///
  //add image to firebase storage
  Future<String> addImageToStorage(
      {@required File file, @required String type, @required String id}) async {
    String url;
    ///get reference (path) of the image to add image reference ..
    final storageRef = getReference(type, id);
    //add or put file image
    final newRef = await storageRef.putFile(file);
    //get url and return it as string to add it to unit data
    url = await newRef.ref.getDownloadURL();
    return url;
  }


///add new product
  Future<void> addNewProduct({
    @required UnitsModel unit,
    @required UnitType addingType,
    @required File file,
    File file2,
    File file3,
  }) async {
    if (unit.id == null) {
      ///get new random id to use this id later for store image and id of unit document in fire store
      switch (addingType) {
        case UnitType.NormalUnit:
          unit.id = fireStore.collection('units').doc().id;
          break;
        case UnitType.ResellUnit:
          unit.id = fireStore.collection('resell').doc().id;
          break;
      }
    }
    //add image and return url then restore it in image1
    unit.image1 =
        await addImageToStorage(file: file, type: 'units', id: '${unit.id}1');
    if (file2 != null)
      unit.image2 = await addImageToStorage(
          file: file2, type: 'units', id: '${unit.id}2');
    if (file3 != null)
      unit.image3 = await addImageToStorage(
          file: file3, type: 'units', id: '${unit.id}3');

    switch (addingType) {
      case UnitType.NormalUnit:
        unit.rate = await getCompoundRate(unit.compoundId);
        await fireStore.collection('units').doc(unit.id).set(unit.toJson());
        break;
      case UnitType.ResellUnit:
        await fireStore.collection('resell').doc(unit.id).set(unit.toJson());
        break;
    }
  }



  //delete product
  Future<void> deleteProduct({@required UnitsModel product , @required UnitType type }) async {
  //delete image in storage first then delete doc
     if(product.image1!=null)
    await FirebaseStorage.instance.refFromURL(product.image1).delete();
    if(product.image2!=null)
      await  FirebaseStorage.instance.refFromURL(product.image2).delete();
    if(product.image3!=null)
      await  FirebaseStorage.instance.refFromURL(product.image3).delete();

    switch(type){
     case UnitType.NormalUnit:
       await fireStore.collection('units').doc(product.id).delete();
       break;

     case UnitType.ResellUnit:
       await fireStore.collection('resell').doc(product.id).delete();
       break;
   }

  }


  //get user data
  Future<UserDataModel> getUserData(String userId) async {
    UserDataModel user = UserDataModel();
    try {
      ///DocumentSnapshot is spacial type  of firebase document
      final documentSnapShot =
          await fireStore.collection('users').doc(userId).get();
      user = UserDataModel.fromJson(documentSnapShot.data());
    } catch (error) {
       //empty model
      user = UserDataModel();
    }
    return user;
  }


  //add compound
  Future addCompound(CompoundModel compound, File image,
      {File image2, File image3}) async {
    if (compound.id == null) {
      compound.id = fireStore.collection('products').doc().id;
    }
    compound.image1 = await addImageToStorage(
        file: image, type: 'compounds', id: '${compound.id}1');
    if (image2 != null)
      compound.image2 = await addImageToStorage(
          file: image2, type: 'compounds', id: '${compound.id}2');
    if (image3 != null)
      compound.image3 = await addImageToStorage(
          file: image3, type: 'compounds', id: '${compound.id}3');
    await fireStore
        .collection('products')
        .doc(compound.id)
        .set(compound.toJson());
  }

  //get all compounds from fire store
  Future<List<CompoundModel>> getCompoundsData() async {
    List<CompoundModel> compounds = <CompoundModel>[];
    final querySnapshot = await fireStore.collection('products').get();
    querySnapshot.docs.forEach((_compound) {
      compounds.add(CompoundModel.fromJson(_compound.data()));
    });

    return compounds;
  }

  //get all compounds from fire store
  Future<List<CompoundModel>> getHousingCompounds() async {
    List<CompoundModel> compounds = <CompoundModel>[];
    final querySnapshot = await fireStore
        .collection('products')
        .where('distinct', isEqualTo: 'Housing')
        .get();
    querySnapshot.docs.forEach((_compound) {
      compounds.add(CompoundModel.fromJson(_compound.data()));
    });

    return compounds;
  }

  ///Get rate of compound to insert it in the unit
  Future<double> getCompoundRate(String compoundId) async {
    final querySnapshot =
        await fireStore.collection('products').doc(compoundId).get();
    return double.parse(querySnapshot.data()['rate']);
  }

  ///Get location of compound to insert it in the unit
  Future<LocationModel> getCompoundLocation(String compoundId) async {
    final querySnapshot =
        await fireStore.collection('products').doc(compoundId).get();
    return querySnapshot.data()['location'];
  }

  ///get only one compound by its id
  Future<CompoundModel> loadCompoundById(String id) async {
    final documentQuerySnapshot =
        await fireStore.collection('products').doc(id).get();
    return CompoundModel.fromJson(documentQuerySnapshot.data());
  }

  ///Add rating to compound
  Future addRatingToCompound(
      {String compoundId, double rate, int totalNumberOfRates}) async {
    await fireStore
        .collection('products')
        .doc(compoundId)
        .update({"numberOfRates": totalNumberOfRates, "rate": rate.toString()});
  }

///load all units data from fire-store
  Future<List<UnitsModel>> loadAllUnits(String type) async {
    List<UnitsModel> housingUnits = <UnitsModel>[];

    final querySnapShot =
        await getQuerySnapshot(LoadingType.LoadAllUnits, type: type);
    for (var _unit in querySnapShot.docs) {
      final compound = await loadCompoundById(_unit.data()['compound_id']);
      if (compound.distinct == 'Housing') {
        _unit.data()['location'] = compound.location;
        _unit.data()['rate'] = compound.rate;
      }
      housingUnits.add(UnitsModel.fromJson(_unit.data()));
    }
    return housingUnits;
  }

  ///get units of specific compound by compound id and sort by category....
  Future<List<UnitsModel>> getUnitsByCompoundId({
    @required String compoundId,
  }) async {
    List<UnitsModel> housingUnits = <UnitsModel>[];
    final querySnapshot = await getQuerySnapshot(
        LoadingType.LoadUnitsByCompoundID,
        compoundId: compoundId);
    final rate = await getCompoundRate(compoundId);
    querySnapshot.docs.forEach((_unit) {
      _unit.data()['rate'] = rate;
      housingUnits.add(UnitsModel.fromJson(_unit.data()));
    });
    return housingUnits;
  }

  ///Get specific unit by unit id ...
  Future<UnitsModel> loadProductByID(
      {@required String prodId, @required String compoundId}) async {
    final querySnapshot = await getQuerySnapshot(LoadingType.LoadProductById,
        compoundId: compoundId, productId: prodId);
    return UnitsModel.fromJson(querySnapshot.docs.first.data());
  }

  ///
  ///
  Future<QuerySnapshot<Map<String, dynamic>>> getQuerySnapshot(
      LoadingType loadingType,
      {String compoundId,
      String productId,
      type}) async {
    QuerySnapshot querySnapShot;
    switch (loadingType) {
      case LoadingType.LoadUnitsByCompoundID:
        querySnapShot = await fireStore
            .collection('units')
            .where("compound_id", isEqualTo: compoundId)
            .get();
        break;
      case LoadingType.LoadResellUnits:
        querySnapShot = await fireStore.collection('resell').get();
        break;
      case LoadingType.LoadProductById:
        querySnapShot = await fireStore
            .collection('units')
            .where('id', isEqualTo: productId)
            .get();
        break;
      case LoadingType.LoadAllUnits:
        querySnapShot = await fireStore
            .collection('units')
            .where('type', isEqualTo: type)
            .get();
        break;
    }
    return querySnapShot;
  }

  ///load all resell units from fire store
  Future<List<UnitsModel>> loadResellUnits() async {
    var resellUnits = <UnitsModel>[];
    final querySnapShot = await getQuerySnapshot(LoadingType.LoadResellUnits);
    querySnapShot.docs.forEach((element) {
      resellUnits.add(UnitsModel.fromJson(element.data()));
    });
    return resellUnits;
  }

  ///get image url to use it and use url later to add in firebase storage
  Future<String> getImageUrl(
      {@required String type, @required String id}) async {
    final storageRef = getReference(type, id);
    return await storageRef.getDownloadURL();
  }

  ///get reference (path) of the image to add image reference ..
  Reference getReference(String type, String id) =>
      FirebaseStorage.instance.ref().child('images').child(type).child(id);



}

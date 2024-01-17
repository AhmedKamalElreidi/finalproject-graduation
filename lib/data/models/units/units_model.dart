import 'package:final_project_ecommerce/data/models/units/location.dart';

class UnitsModel {
  String id;
  String title;
  String image1;
  String image2;
  String image3;
  String type;
  List<String> amenities;
  String price;
  String supplierPhone;
  String compoundId;
  String supplierName;
  String supplierEmail;
  String supplierId;
  String description;
  double rate;

  String area;
  String compoundName;
  LocationModel location;
  int bedRooms;
  int bathRooms;
  bool furnishes;
  int level;

  UnitsModel({
    this.id,
    this.title,
    this.description,
    this.image1,
    this.image2,
    this.image3,
    this.amenities,
    this.type,
    this.supplierName,
    this.rate,
    this.price,
    this.location,
    this.supplierPhone,
    this.compoundId,
    this.supplierEmail,
    this.supplierId,
    this.compoundName,
    this.area,
    this.bathRooms,
    this.bedRooms,
    this.furnishes,
    this.level,
  });

  UnitsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image1 = json['image1'];
    image2 = json['image2'];
    image3 = json['image3'];
    rate = double.parse(json['rate']);
    price = json['price'];
    supplierPhone = json['supplier_phone'];
    compoundId = json['compound_id'];
    supplierEmail = json['supplier_email'];
    supplierId = json['supplier_id'];
    description = json['description'];
    supplierName = json['supplier_name'];
    type = json['type'];
    compoundName = json['compound_name'];
    area = json['area'];
    bathRooms = json['bath_rooms'];
    bedRooms = json['bed_rooms'];
    furnishes = json['is_furnishes'];
    level = json['level'];
    amenities =
        json['amenities'] != null ? json['amenities'].cast<String>() : [];

    location = json['location'] != null
        ? new LocationModel.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image1'] = this.image1;
    data['image2'] = this.image2;
    data['image3'] = this.image3;
    data['rate'] = this.rate.toString();
    data['price'] = this.price;
    data['supplier_phone'] = this.supplierPhone;
    data['supplier_name'] = this.supplierName;
    data['compound_id'] = this.compoundId;
    data['type'] = this.type;
    data['supplier_email'] = this.supplierEmail;
    data['supplier_id'] = this.supplierId;
    data['description'] = this.description;
    data['location'] = this.location.toJson();
    data['compound_name'] = this.compoundName;
    data['area'] = this.area;
    data['amenities'] = this.amenities;
    data['bath_rooms'] = this.bathRooms;
    data['bed_rooms'] = this.bedRooms;
    data['is_furnishes'] = this.furnishes;
    data['level'] = this.level;
    return data;
  }
}

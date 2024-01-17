import 'package:final_project_ecommerce/data/models/units/location.dart';

class CompoundModel {
  String name;
  String id;
  String area;
  double rate;
  String image1;
  String image2;
  String image3;
  String distinct;
  String details;
  LocationModel location;
  int numberOfRates;
  List<String> population;

  CompoundModel(
      {this.name,
      this.id,
      this.area,
      this.location,
      this.rate,
      this.image1,
      this.image2,
      this.image3,
      this.distinct,
      this.details,
      this.numberOfRates,
      this.population});

  CompoundModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    image1 = json['image1'];
    image2 = json['image2'];
    image3 = json['image3'];
    area = json['area'];
    rate = double.parse(json['rate']);
    distinct = json['distinct'];
    details = json['details'];
    numberOfRates = json['numberOfRates'];
    population =
        json['population'] != null ? json['population'].cast<String>() : [];
    location = json['location'] != null
        ? new LocationModel.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['image1'] = this.image1;
    data['image2'] = this.image2;
    data['image3'] = this.image3;
    data['area'] = this.area;
    data['rate'] = this.rate.toString();
    data['location'] = this.location.toJson();
    data['distinct'] = this.distinct;
    data['details'] = this.details;
    data['numberOfRates'] = this.numberOfRates;
    data['population'] = this.population;
    return data;
  }
}

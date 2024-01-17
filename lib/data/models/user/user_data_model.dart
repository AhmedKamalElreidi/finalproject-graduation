class UserDataModel {
  String id;
  String image;
  String address;
  String lastName;
  String firstName;
  String phone;
  String description;
  String long;
  String email;
  String lat;
  double rate;
  String error;
  UserDataModel(
      {this.id,
      this.image,
      this.address,
      this.lastName,
      this.firstName,
      this.phone,
      this.description,
      this.long,
      this.email,
      this.lat,
      this.rate,
      this.error});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    address = json['address'];
    lastName = json['last name'];
    firstName = json['first name'];
    phone = json['phone'];
    description = json['description'];
    long = json['long'];
    email = json['email'];
    lat = json['lat'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['address'] = this.address;
    data['last name'] = this.lastName;
    data['first name'] = this.firstName;
    data['phone'] = this.phone;
    data['description'] = this.description;
    data['long'] = this.long;
    data['email'] = this.email;
    data['lat'] = this.lat;
    data['rate'] = this.rate;
    return data;
  }

  UserDataModel.error(this.error);
}

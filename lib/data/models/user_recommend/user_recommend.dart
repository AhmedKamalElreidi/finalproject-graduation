class UserRecommend {
  double budget;
  String uId;

  UserRecommend({
    this.budget,
    this.uId,
  });

  UserRecommend.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    budget = json['budget'] ?? '500000';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uId'] = this.uId;
    data['budget'] = this.budget;
    return data;
  }
}

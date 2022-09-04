class Reviews {
  int? id;
  String? review;
  int? rate;
  String? userName;
  int? createdAt;

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    review = json['review'];
    rate = json['rate'];
    userName = json['user_name'];
    createdAt = json['created_at'];
  }

}
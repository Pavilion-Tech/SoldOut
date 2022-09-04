class Images {
  int? id;
  String? image;


  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}
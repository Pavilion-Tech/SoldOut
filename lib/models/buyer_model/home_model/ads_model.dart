class AdsModel {
  int? id;
  String? image;
  String? type;
  int? modelId;
  String? link;


  AdsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    type = json['type'];
    modelId = json['model_id'];
    link = json['link'];
  }

}

class Store {
  int? id;
  String? name;


  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

}
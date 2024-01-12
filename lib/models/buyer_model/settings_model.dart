class SettingsModel {
  bool? status;
  String? msg;
  SettingsData? data;


  SettingsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? new SettingsData.fromJson(json['data']) : null;
  }

}

class SettingsData {
  String? aboutUs;
  String? auctionTerms;
  String? terms;
  String? email;
  String? instagram;
  String? facebook;
  String? whatsapp;
  String? twitter;
  String? phone;
  bool? maintenance;
  List<Cities>? cities;
  List<Categories>? categories;


  SettingsData.fromJson(Map<String, dynamic> json) {
    aboutUs = json['about_us'];
    terms = json['terms'];
    auctionTerms = json['auction_terms'];
    maintenance = json['maintenance'];
    email = json['email'];
    instagram = json['instagram'];
    facebook = json['facebook'];
    whatsapp = json['whatsapp'];
    twitter = json['twitter'];
    phone = json['phone'];
    if (json['cities'] != null) {
      cities = <Cities>[];
      json['cities'].forEach((v) {
        cities!.add(new Cities.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
  }
}

class Cities {
  int? id;
  String? name;
  List<Neighborhoods>? neighborhoods;


  Cities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['neighborhoods'] != null) {
      neighborhoods = <Neighborhoods>[];
      json['neighborhoods'].forEach((v) {
        neighborhoods!.add(new Neighborhoods.fromJson(v));
      });
    }
  }

}

class Neighborhoods {
  int? id;
  String? name;


  Neighborhoods.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }


}

class Categories {
  int? id;
  String? name;
  String? logo;
  String? hexColor;


  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    hexColor = json['hex_color'];
  }

}

class SettingsModel {
  bool? status;
  String? msg;
  SettingsData? data;


  SettingsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ?  SettingsData.fromJson(json['data']) : null;
  }

}

class SettingsData {
  String? aboutUs;
  String? terms;
  List<Cities>? cities;


  SettingsData.fromJson(Map<String, dynamic> json) {
    aboutUs = json['about_us'];
    terms = json['terms'];
    if (json['cities'] != null) {
      cities = <Cities>[];
      json['cities'].forEach((v) {
        cities!.add( Cities.fromJson(v));
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
        neighborhoods!.add( Neighborhoods.fromJson(v));
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

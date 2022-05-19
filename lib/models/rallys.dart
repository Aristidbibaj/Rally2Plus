import 'package:firebase_database/firebase_database.dart';

class Rallys {
  late String rally_flag;
  late String rally_category;
  late String end_datetime;
  late String start_datetime;
  late int rally_id;
  late List<int> races_id;
  late String race_country;
  late String rallys_name;
  late bool visible;
  late String race_length;
  late String nation_race;

  Rallys(
      {required this.rally_flag,
      required this.rally_category,
      required this.end_datetime,
      required this.start_datetime,
      required this.rally_id,
      required this.races_id,
      required this.race_country,
      required this.rallys_name,
      required this.visible,
      required this.race_length,
      required this.nation_race});

  Rallys.fromJson(Map<String, dynamic> json) {
    rally_flag = json['rally_flag'];
    rally_category = json['rally_category'];
    end_datetime = json['end_datetime'];
    start_datetime = json['start_datetime'];
    rally_id = json['rally_id'];
    races_id = json['races_id'].cast<int>();
    race_country = json['race_country'];
    rallys_name = json['rallys_name'];
    visible = json['visible'];
    race_length = json['race_length'];
    nation_race = json['nation_race'];
  }

  Rallys.fromDataSnapshot(DataSnapshot snapshot) {
    (snapshot as Map<dynamic, dynamic>).forEach((key, value) {
      rally_flag = value['rally_flag'];
      rally_category = value['rally_category'];
      end_datetime = value['end_datetime'];
      start_datetime = value['start_datetime'];
      rally_id = value['rally_id'];
      races_id = value['races_id'].cast<int>();
      race_country = value['race_country'];
      rallys_name = value['rallys_name'];
      visible = value['visible'];
      race_length = value['race_length'];
      nation_race = value['nation_race'];
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rally_flag'] = rally_flag;
    data['rally_category'] = rally_category;
    data['end_datetime'] = end_datetime;
    data['start_datetime'] = start_datetime;
    data['rally_id'] = rally_id;
    data['races_id'] = races_id;
    data['race_country'] = race_country;
    data['rallys_name'] = rallys_name;
    data['visible'] = visible;
    data['race_length'] = race_length;
    data['nation_race'] = nation_race;
    return data;
  }
}

/*class DBRally {
  List<Rally> rally;

  DBRally({this.rally});

  DBRally.fromJson(Map<String, dynamic> json) {
    if (json['rally'] != null) {
      rally = new List<Rally>();
      json['rally'].forEach((v) {
        rally.add(new Rally.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rally != null) {
      data['rally'] = this.rally.map((v) => v.toJson()).toList();
    }
    return data;
  }
}*/

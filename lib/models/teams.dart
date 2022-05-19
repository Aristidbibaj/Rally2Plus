import 'package:firebase_database/firebase_database.dart';

class Teams {
  late String teams_flag;
  late String teams_category;
  late String classe;
  late List<int> id_drivers;
  late String teams_car;
  late int teams_id;
  late String teams_name;

  Teams(
      {required this.teams_flag,
      required this.teams_category,
      required this.classe,
      required this.id_drivers,
      required this.teams_car,
      required this.teams_id,
      required this.teams_name});

  Teams.fromJson(Map<String, dynamic> json) {
    teams_flag = json['teams_flag'];
    teams_category = json['teams_category'];
    classe = json['classe'];
    id_drivers = json['id_drivers'];
    teams_car = json['teams_car'];
    teams_id = json['teams_id'];
    teams_name = json['teams_name'];
  }

  Teams.fromDataSnapshot(DataSnapshot snapshot) {
    (snapshot as Map<dynamic, dynamic>).forEach((key, value) {
      teams_flag = value['teams_flag'];
      teams_category = value['teams_category'];
      classe = value['classe'];
      id_drivers = value['id_drivers'];
      teams_car = value['teams_car'];
      teams_id = value['teams_id'];
      teams_name = value['teams_name'];
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['teams_flag'] = teams_flag;
    data['teams_category'] = teams_category;
    data['classe'] = classe;
    data['id_drivers'] = id_drivers;
    data['teams_car'] = teams_car;
    data['teams_id'] = teams_id;
    data['teams_name'] = teams_name;
    return data;
  }
}

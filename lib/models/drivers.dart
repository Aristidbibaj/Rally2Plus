import 'package:firebase_database/firebase_database.dart';

class Drivers {
  late String driver_flag;
  late String driver_category;
  late String classe;
  late int driver_id;
  late bool m;
  late String driver_car;
  late String navigator;
  late String driver_name;
  late String number;
  late String team;

  Drivers(
      {required this.driver_flag,
      required this.driver_category,
      required this.classe,
      required this.driver_id,
      required this.m,
      required this.driver_car,
      required this.navigator,
      required this.driver_name,
      required this.number,
      required this.team});

  Drivers.fromJson(Map<String, dynamic> json) {
    driver_flag = json['driver_flag'];
    driver_category = json['driver_category'];
    classe = json['classe'];
    driver_id = json['driver_id'];
    m = json['m'];
    driver_car = json['driver_car'];
    navigator = json['navigator'];
    driver_name = json['nome'];
    number = json['number'];
    team = json['team'];
  }

  Drivers.fromDataSnapshot(DataSnapshot snapshot) {
    (snapshot as Map<dynamic, dynamic>).forEach((key, value) {
      driver_flag = value['driver_flag'];
      driver_category = value['driver_category'];
      classe = value['classe'];
      driver_id = value['driver_id'];
      m = value['m'];
      driver_car = value['driver_car'];
      navigator = value['navigator'];
      driver_name = value['nome'];
      number = value['number'];
      team = value['team'];
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['driver_flag'] = driver_flag;
    data['driver_category'] = driver_category;
    data['classe'] = classe;
    data['driver_id'] = driver_id;
    data['m'] = m;
    data['driver_car'] = driver_car;
    data['navigator'] = navigator;
    data['nome'] = driver_name;
    data['number'] = number;
    data['team'] = team;
    return data;
  }
}

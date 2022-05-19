import 'package:firebase_database/firebase_database.dart';

class Races {
  late String race_datetime;
  late int race_id;
  late String race_length;
  late String races_name;
  late List<int> race_drivers;
  late List<String> race_times;

  Races(
      {required this.race_datetime,
      required this.race_id,
      required this.race_length,
      required this.races_name,
      required this.race_drivers,
      required this.race_times});

  factory Races.fromRTDB(Map<String, dynamic> json) {
    return Races(
      race_datetime: json['race_datetime'],
      race_id: json['race_id'],
      race_length: json['race_length'],
      races_name: json['races_name'],
      race_drivers: json['race_drivers'].cast<int>(),
      race_times: json['race_times'].cast<String>(),
    );
  }

  Races.fromDataSnapshot(DataSnapshot snapshot) {
    (snapshot as Map<dynamic, dynamic>).forEach((key, value) {
      race_datetime = value['race_datetime'];
      race_id = value['race_id'];
      race_length = value['race_length'];
      races_name = value['races_name'];
      race_drivers = value['race_drivers'].cast<int>();
      race_times = value['race_times'].cast<String>();
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['race_datetime'] = race_datetime;
    data['race_id'] = race_id;
    data['race_length'] = race_length;
    data['races_name'] = races_name;
    data['race_drivers'] = race_drivers;
    data['race_times'] = race_times;
    return data;
  }
}

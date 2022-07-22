class Standings {
  late List<Map<String, dynamic>> wrc_drivers;
  late List<Map<String, dynamic>> wrc_manufactures;
  late List<Map<String, dynamic>> wrc2_drivers;
  late List<Map<String, dynamic>> wrc2_teams;

  Standings({
    required this.wrc_drivers,
    required this.wrc_manufactures,
    required this.wrc2_drivers,
    required this.wrc2_teams,
  });

  factory Standings.fromRTDB(var json) {
    List<Map<String, dynamic>> tmp_wrc_drivers = [];
    for (var tmp_map in json[0]) {
      tmp_wrc_drivers.add(Map.from(tmp_map));
    }
    List<Map<String, dynamic>> tmp_wrc_manufactures = [];
    for (var tmp_map in json[1]) {
      tmp_wrc_manufactures.add(Map.from(tmp_map));
    }
    List<Map<String, dynamic>> tmp_wrc2_drivers = [];
    for (var tmp_map in json[2]) {
      tmp_wrc2_drivers.add(Map.from(tmp_map));
    }
    List<Map<String, dynamic>> tmp_wrc2_teams = [];
    for (var tmp_map in json[3]) {
      tmp_wrc2_teams.add(Map.from(tmp_map));
    }
    return Standings(
      wrc_drivers: tmp_wrc_drivers,
      wrc_manufactures: tmp_wrc_manufactures,
      wrc2_drivers: tmp_wrc2_drivers,
      wrc2_teams: tmp_wrc2_teams,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> temp_standings = <String, dynamic>{};
    temp_standings['wrc_drivers'] = wrc_drivers;
    temp_standings['wrc_manufactures'] = wrc_manufactures;
    temp_standings['wrc2_drivers'] = wrc2_drivers;
    temp_standings['wrc2_teams'] = wrc2_teams;
    return temp_standings;
  }
}

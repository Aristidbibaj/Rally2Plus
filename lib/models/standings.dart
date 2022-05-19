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

  factory Standings.fromJson(Map<String, dynamic> json) {
    return Standings(
      wrc_drivers: json[0] as List<Map<String, dynamic>>,
      wrc_manufactures: json[1] as List<Map<String, dynamic>>,
      wrc2_drivers: json[2] as List<Map<String, dynamic>>,
      wrc2_teams: json[3] as List<Map<String, dynamic>>,
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

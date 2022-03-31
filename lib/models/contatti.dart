import 'package:firebase_database/firebase_database.dart';

class Contatti {
  late String sviluppatori;
  late String collaboratori;
  late String linkInstagramWRCTVITALY;

  Contatti({
    required this.sviluppatori,
    required this.collaboratori,
    required this.linkInstagramWRCTVITALY,
  });

  Contatti.fromJson(Map<String, dynamic> json) {
    sviluppatori = json['sviluppatori'];
    collaboratori = json['collaboratori'];
    linkInstagramWRCTVITALY = json['linkinstagram'];
  }

  Contatti.fromDataSnapshot(DataSnapshot snapshot){
    (snapshot as Map<dynamic, dynamic>).forEach((key, value) {
      sviluppatori = value['sviluppatori'];
      collaboratori = value['collaboratori'];
      linkInstagramWRCTVITALY = value['linkinstagramwrc'];
    });
}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['sviluppatori'] = sviluppatori;
    data['collaboratori'] = collaboratori;
    data['linkinstagramwrc'] = linkInstagramWRCTVITALY;
    return data;
  }

}

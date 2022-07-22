import 'package:firebase_database/firebase_database.dart';

class Contacts {
  String collaborators =
      "Marco Racing\n(photographer)\nhttps://www.instagram.com/marco_racing_/\nNicola Scognamillo\n(photographer)\nhttps://www.instagram.com/nicola_scognamillo/\nLucas Martineza\n(photographer)\nhttps://www.instagram.com/lucasmartineza/";
  String rally2plus_web_link = "https://www.instagram.com/wrc_tv_italy/";
  String developers =
      "Andrea Gambardella\n(owner/creator)\nandre.gamba.95@gmail.com\nAristid Bibaj\n(Full-stack developer)\naristid.bibaj@gmail.com\nGiovanni Bernacchini\n(collaborator)\nhttps://www.instagram.com/bernacchinigiovanni/";

  Contacts({
    required this.developers,
    required this.collaborators,
    required this.rally2plus_web_link,
  });

  Contacts.fromRTDB(Map<String, dynamic> json) {
    (json as Map<String, dynamic>).forEach((key, value) {
      developers = json['developers'];
      collaborators = json['collaborators'];
      rally2plus_web_link = json['rally2plus_web_link'];
    });
  }

  Contacts.fromDataSnapshot(DataSnapshot snapshot) {
    (snapshot as Map<String, dynamic>).forEach((key, value) {
      developers = value['developers'];
      collaborators = value['collaborators'];
      rally2plus_web_link = value['rally2plus_web_link'];
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['developers'] = developers;
    data['collaborators'] = collaborators;
    data['rally2plus_web_link'] = rally2plus_web_link;
    return data;
  }
}

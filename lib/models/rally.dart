import 'package:firebase_database/firebase_database.dart';

class Rally {
  late String bandiera;
  late String categoria;
  late String dataOraFine;
  late String dataOraInizio;
  late int id;
  late List<int> idProve;
  late String luogo;
  late String nome;
  late bool visibile;
  late String lunghezza;
  late String nazione;

  Rally({required this.bandiera,
    required this.categoria,
    required this.dataOraFine,
    required this.dataOraInizio,
    required this.id,
    required this.idProve,
    required this.luogo,
    required this.nome,
    required this.visibile,
    required this.lunghezza,
    required this.nazione});

  Rally.fromJson(Map<String, dynamic> json) {
    bandiera = json['bandiera'];
    categoria = json['categoria'];
    dataOraFine = json['dataOraFine'];
    dataOraInizio = json['dataOraInizio'];
    id = json['id'];
    idProve = json['idProve'].cast<int>();
    luogo = json['luogo'];
    nome = json['nome'];
    visibile = json['visibile'];
    lunghezza = json['lunghezza'];
    nazione = json['nazione'];
  }

  Rally.fromDataSnapshot(DataSnapshot snapshot){
    (snapshot as Map<dynamic, dynamic>).forEach((key, value) {
      bandiera = value['bandiera'];
      categoria = value['categoria'];
      dataOraFine = value['dataOraFine'];
      dataOraInizio = value['dataOraInizio'];
      id = value['id'];
      idProve = value['idProve'].cast<int>();
      luogo = value['luogo'];
      nome = value['nome'];
      visibile = value['visibile'];
      lunghezza = value['lunghezza'];
      nazione = value['nazione'];
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bandiera'] = bandiera;
    data['categoria'] = categoria;
    data['dataOraFine'] = dataOraFine;
    data['dataOraInizio'] = dataOraInizio;
    data['id'] = id;
    data['idProve'] = idProve;
    data['luogo'] = luogo;
    data['nome'] = nome;
    data['visibile'] = visibile;
    data['lunghezza'] = lunghezza;
    data['nazione'] = nazione;
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

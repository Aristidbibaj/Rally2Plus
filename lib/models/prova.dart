import 'package:firebase_database/firebase_database.dart';

class Prova {
  late String dataOra;
  late int id;
  late String lunghezza;
  late String nome;
  late List<int> piloti;
  late List<String> tempi;

  Prova(
      {required this.dataOra,
        required this.id,
        required this.lunghezza,
        required this.nome,
        required this.piloti,
        required this.tempi});

  factory Prova.fromRTDB(Map<String, dynamic> json) {
    return Prova(
    dataOra : json['dataOra'],
    id : json['id'],
    lunghezza : json['lunghezza'],
    nome : json['nome'],
    piloti : json['piloti'].cast<int>(),
    tempi : json['tempi'].cast<String>(),
    );
  }

  Prova.fromDataSnapshot(DataSnapshot snapshot){
    (snapshot as Map<dynamic, dynamic>).forEach((key, value) {
      dataOra = value['dataOra'];
      id = value['id'];
      lunghezza = value['lunghezza'];
      nome = value['nome'];
      piloti = value['piloti'].cast<int>();
      tempi = value['tempi'].cast<String>();
      });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['dataOra'] = dataOra;
    data['id'] = id;
    data['lunghezza'] = lunghezza;
    data['nome'] = nome;
    data['piloti'] = piloti;
    data['tempi'] = tempi;
    return data;
  }
}

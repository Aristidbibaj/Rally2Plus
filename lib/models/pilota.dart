import 'package:firebase_database/firebase_database.dart';

class Pilota {
  late String bandiera;
  late String categoria;
  late String classe;
  late int id;
  late bool m;
  late String macchina;
  late String navigatore;
  late String nome;
  late String numero;
  late String team;

  Pilota(
      {required this.bandiera,
        required this.categoria,
        required this.classe,
        required this.id,
        required this.m,
        required this.macchina,
        required this.navigatore,
        required this.nome,
        required this.numero,
        required this.team});

  Pilota.fromJson(Map<String, dynamic> json) {
    bandiera = json['bandiera'];
    categoria = json['categoria'];
    classe = json['classe'];
    id = json['id'];
    m = json['m'];
    macchina = json['macchina'];
    navigatore = json['navigatore'];
    nome = json['nome'];
    numero = json['numero'];
    team = json['team'];
  }

  Pilota.fromDataSnapshot(DataSnapshot snapshot){
    (snapshot as Map<dynamic, dynamic>).forEach((key, value) {
      bandiera = value['bandiera'];
      categoria = value['categoria'];
      classe = value['classe'];
      id = value['id'];
      m = value['m'];
      macchina = value['macchina'];
      navigatore = value['navigatore'];
      nome = value['nome'];
      numero = value['numero'];
      team = value['team'];
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['bandiera'] = bandiera;
    data['categoria'] = categoria;
    data['classe'] = classe;
    data['id'] = id;
    data['m'] = m;
    data['macchina'] = macchina;
    data['navigatore'] = navigatore;
    data['nome'] = nome;
    data['numero'] = numero;
    data['team'] = team;
    return data;
  }
}

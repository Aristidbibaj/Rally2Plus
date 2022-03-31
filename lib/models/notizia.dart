import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:rally2plus/controls/local_storage.dart';

class Notizia {
  late String bandiera;
  late String categoria;
  late String dataOra;
  late String fonte;
  late bool fromLink;
  late int id;
  late String img;
  late bool isVideo;
  late String sottotitolo;
  late String sottotitoloEn;
  late List<String> tag;
  late List<String> tagEn;
  late String testo;
  late String testoEn;
  late String titolo;
  late String titoloEn;
  late String video;
  late bool isMultiFoto;
  late List<String> multiFoto;

  Notizia({
    required this.bandiera,
    required this.categoria,
    required this.dataOra,
    required this.fonte,
    required this.fromLink,
    required this.id,
    required this.img,
    required this.isVideo,
    required this.sottotitolo,
    required this.sottotitoloEn,
    required this.tag,
    required this.tagEn,
    required this.testo,
    required this.testoEn,
    required this.titolo,
    required this.titoloEn,
    required this.video,
    required this.isMultiFoto,
    required this.multiFoto,
  });

  factory Notizia.fromRTDB(Map<String, dynamic> json) {
    return Notizia(
        bandiera: json['bandiera'] ?? 'sconsciuto',
        categoria: json['categoria'] ?? 'sconsciuto',
        dataOra: json['dataOra'] ?? 'sconsciuto',
        fonte: json['fonte'] ?? 'sconsciuto',
        fromLink: json['fromLink'] ?? false,
        id: json['id'] ?? 0,
        img: json['img'] ?? 'sconsciuto',
        isVideo: json['isVideo'] ?? false,
        sottotitolo: json['sottotitolo'] ?? 'sconsciuto',
        sottotitoloEn: json['sottotitoloEn'] ?? 'sconsciuto',
        tag: json['tag'].cast<String>() ?? [],
        tagEn: json['tagEn'].cast<String>() ?? [],
        testo: json['testo'] ?? 'sconsciuto',
        testoEn: json['testoEn'] ?? 'sconsciuto',
        titolo: json['titolo'] ?? 'sconsciuto',
        titoloEn: json['titoloEn'] ?? 'sconsciuto',
        video: json['video'] ?? 'sconsciuto',
        isMultiFoto: json['isMultiFoto'] ?? false,
        multiFoto: json['multiFoto'].cast<String>() ?? []);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bandiera'] = bandiera;
    data['categoria'] = categoria;
    data['dataOra'] = dataOra;
    data['fonte'] = fonte;
    data['fromLink'] = fromLink;
    data['id'] = id;
    data['img'] = img;
    data['isVideo'] = isVideo;
    data['sottotitolo'] = sottotitolo;
    data['sottotitoloEn'] = sottotitoloEn;
    data['tag'] = tag;
    data['tagEn'] = tagEn;
    data['testo'] = testo;
    data['testoEn'] = testoEn;
    data['titolo'] = titolo;
    data['titoloEn'] = titoloEn;
    data['video'] = video;
    data['isMultiFoto'] = isMultiFoto;
    data['multiFoto'] = multiFoto;
    return data;
  }

  bool containTestoCitato() {
    if ((testo).contains('&&')) return true;
    return false;
  }

  int getYear() {
    return int.parse((dataOra).split('-')[0].split('/')[0]);
  }

  //ritorna 3 stringhe, di cui la stringa[1] è il testo citato
  List<String> getTestoFormattato() {
    return LocalStorage.instance.getString('lingua')!.compareTo('it') == 0
        ? (testo).split('&&')
        : (testoEn).split('&&');
  }

}
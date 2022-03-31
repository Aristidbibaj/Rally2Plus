import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CategoriaHome {
  late String nomeIt;
  late String nomeEn;

  CategoriaHome({
    required this.nomeEn,
    required this.nomeIt,
  });

  factory CategoriaHome.fromRTDB(Map<String, dynamic> json) {
    return CategoriaHome(
    nomeIt : json['it'] ?? 'wrc',
    nomeEn : json['en'] ?? 'wrc',
    );
  }

  CategoriaHome.fromDataSnapshot(DataSnapshot snapshot) {
    (snapshot as Map<dynamic, dynamic>).forEach((key, value) {
      nomeIt = value['it'];
      nomeEn = value['en'];
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['it'] = nomeIt;
    data['en'] = nomeEn;
    return data;
  }
}

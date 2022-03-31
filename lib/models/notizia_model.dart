import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rally2plus/models/notizia.dart';

class NotiziaModel extends ChangeNotifier{

  Notizia? _notizia;

  static const NOTIZIE_DB_PATH = 'notizie';
  final _db = FirebaseDatabase.instance.ref(NOTIZIE_DB_PATH);
  late StreamSubscription _notizieStream;
  Notizia? get notizia => _notizia;

  NotiziaModel(){
    _listenNotizie();
  }

  void _listenNotizie(){
    _db.child(NOTIZIE_DB_PATH).onValue.listen((event) {
      for(final notiz in event.snapshot.children)
      _notizia = Notizia.fromRTDB(notiz as Map<String, dynamic>);
      notifyListeners();
    });
  }

  @override
  void dispose(){
    _notizieStream.cancel();
    super.dispose();
  }

}
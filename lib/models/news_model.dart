import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rally2plus/models/news.dart';

class NewsModel extends ChangeNotifier {
  News? _notizia;

  static const NEWS_DB_PATH = 'news';
  final _db = FirebaseDatabase.instance.ref(NEWS_DB_PATH);
  late StreamSubscription _notizieStream;

  List<News>? get newsList => _newsList;
  late List<News> _newsList;

  NewsModel() {
    _newsList = [];
    _newsListen();
  }

  void _newsListen() {
    _notizieStream = _db.child(NEWS_DB_PATH).onValue.listen((event) {
      final allNews = event.snapshot.value as List;
      for (var value in allNews) {
        print(value);
        _newsList.add(News.fromRTDB(Map.from(value)));
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _notizieStream.cancel();
    super.dispose();
  }
}

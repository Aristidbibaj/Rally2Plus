import 'package:firebase_database/firebase_database.dart';
import 'package:rally2plus/models/category_home.dart';
import 'package:rally2plus/models/contatti.dart';
import 'package:rally2plus/models/notizia.dart';
import 'package:rally2plus/models/pilota.dart';
import 'package:rally2plus/models/prova.dart';

import '../models/rally.dart';

class DatabaseService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  late DatabaseReference _raceRef;
  late DatabaseReference _newsRef;
  late DatabaseReference _rallyRef;
  late DatabaseReference _driverRef;
  late DatabaseReference _contactsRef;
  late DatabaseReference _homeCategoryRef;

  late Query _newsQuery;
  late Query _raceQuery;
  late Query _rallyQuery;
  late Query _driverQuery;
  late Query _contactsQuery;
  late Query _homeCategoryQuery;

  List<Notizia> newsList = [];
  List<Prova> raceList = [];
  List<Rally> rallyList = [];
  List<Pilota> driverList = [];
  List<CategoriaHome> homeCategoryList = [];
  late Contatti contacts;

  DatabaseService(){
    initDBState();
  }

  void initDBState() async {
    print("Initialize util for database");
    _database.setPersistenceEnabled(true);
    _database.setPersistenceCacheSizeBytes(10000000);
    _newsRef = _database.ref().child('notizie');
    _rallyRef = _database.ref().child('rally');
    _raceRef = _database.ref().child('prove');
    _driverRef = _database.ref().child('piloti');
    _contactsRef = _database.ref().child('contatti');
    _homeCategoryRef = _database.ref().child('home').child('fissi');

    _newsQuery = _newsRef.orderByChild('dataOra');
    _rallyQuery = _rallyRef.orderByChild("dataOraInizio");
    _raceQuery = _raceRef.orderByChild("dataOra");
    _driverQuery = _driverRef.orderByChild("id");
    _contactsQuery = _contactsRef;
    _homeCategoryQuery = _homeCategoryRef;
  }

  Future<List<Notizia>> getNews() async {
    newsList = [];
    return await _newsQuery.once().then((value) {
      List list = value.snapshot.value as List;
      for (var value in list) {
        newsList.add(Notizia.fromRTDB(Map.from(value)));
      }
      print('news db service: ${newsList.first.tag}');
      return newsList;
    });
  }

  Future<List<Prova>> getRace() async {
    raceList = [];
    return await _raceQuery.once().then((value) {
      List list = value.snapshot.value as List;
      for (var value in list) {
        raceList.add(Prova.fromRTDB(Map.from(value)));
      }
      return raceList;
    });
  }

  Future<List<CategoriaHome>> getHomeCategory() async {
    homeCategoryList = [];
    return await _homeCategoryQuery.once().then((value) {
      List list = value.snapshot.value as List;
      for (var value in list) {
        homeCategoryList.add(CategoriaHome.fromRTDB(Map.from(value)));
      }
      print('home category: $homeCategoryList');
      return homeCategoryList;
    });
  }

}

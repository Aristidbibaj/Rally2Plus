import 'package:firebase_database/firebase_database.dart';
import 'package:rally2plus/models/category_home.dart';
import 'package:rally2plus/models/contacts.dart';
import 'package:rally2plus/models/drivers.dart';
import 'package:rally2plus/models/news.dart';
import 'package:rally2plus/models/races.dart';

import '../models/rallys.dart';

class DatabaseService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  late DatabaseReference _newsRef;
  late DatabaseReference _originalsRef;
  late DatabaseReference _rallyRef;
  late DatabaseReference _raceRef;
  late DatabaseReference _driverRef;
  late DatabaseReference _teamsRef;
  late DatabaseReference _standingsRef;
  late DatabaseReference _contactsRef;
  late DatabaseReference _homeCategoryRef;
  late DatabaseReference _homeCategoryHiddenRef;

  late Query _newsQuery;
  late Query _originalsQuery;
  late Query _rallyQuery;
  late Query _raceQuery;
  late Query _driverQuery;
  late Query _teamsQuery;
  late Query _standingsQuery;
  late Query _contactsQuery;
  late Query _homeCategoryQuery;
  late Query _homeCategoryHiddenQuery;

  List<News> _newsList = [];
  List<News> _originalsList = [];
  List<Rallys> _rallyList = [];
  List<Races> _raceList = [];
  List<Drivers> _driverList = [];
  List<Drivers> _teamsList = [];
  List<Drivers> _standingsList = [];
  List<HomeCategory> _homeCategoryList = [];
  List<HomeCategoryHidden> _homeCategoryHiddenList = [];
  late Contacts _contacts;
  bool _init = false;

  DatabaseService() {
    initDBState();
  }

  void initDBState() async {
    _newsRef = _database.ref().child('news');
    _originalsRef = _database.ref().child('originals');
    _rallyRef = _database.ref().child('rallys');
    _raceRef = _database.ref().child('races');
    _driverRef = _database.ref().child('drivers');
    _teamsRef = _database.ref().child('teams');
    _standingsRef = _database.ref().child('standings');
    _contactsRef = _database.ref().child('contacts');
    _homeCategoryRef = _database.ref().child('home').child('base');
    _homeCategoryHiddenRef = _database.ref().child('home').child('hidden');

    _newsQuery = _newsRef.orderByKey();
    _originalsQuery = _originalsRef.orderByKey();
    _rallyQuery = _rallyRef.orderByChild("start_datetime");
    _raceQuery = _raceRef.orderByChild("race_date");
    _driverQuery = _driverRef.orderByChild("driver_id");
    _contactsQuery = _contactsRef;
    _homeCategoryQuery = _homeCategoryRef;
    _homeCategoryHiddenQuery = _homeCategoryHiddenRef;
  }

  populateDB() async {
    await getHomeCategory();
    await getHomeCategoryHidden();
    await getNews();
    await getContacts();
    await getRace();
    _init = true;
  }

  void prova() {
    _newsQuery.onChildAdded.forEach((element) {});
  }

  Future<List<News>> getNews() async {
    _newsList = [];
    return await _newsQuery.once().then((value) {
      List list = value.snapshot.value as List;
      for (var value in list) {
        _newsList.add(News.fromRTDB(Map.from(value)));
      }
      return _newsList;
    });
  }

  Future<Contacts> getContacts() async {
    return await _contactsQuery.once().then((value) {
      return Contacts.fromJson(
          Map<String, dynamic>.from(value.snapshot.value as Map));
    });
  }

  Future<List<Races>> getRace() async {
    _raceList = [];
    return await _raceQuery.once().then((value) {
      List list = value.snapshot.value as List;
      for (var value in list) {
        _raceList.add(Races.fromRTDB(Map.from(value)));
      }
      return _raceList;
    });
  }

  Future<List<HomeCategory>> getHomeCategory() async {
    _homeCategoryList = [];
    return await _homeCategoryQuery.once().then((value) {
      List list = value.snapshot.value as List;
      for (var value in list) {
        _homeCategoryList.add(HomeCategory.fromRTDB(Map.from(value)));
      }
      return _homeCategoryList;
    });
  }

  Future<List<HomeCategoryHidden>> getHomeCategoryHidden() async {
    _homeCategoryHiddenList = [];
    return await _homeCategoryHiddenQuery.once().then((value) {
      List list = value.snapshot.value as List;
      for (var value in list) {
        _homeCategoryHiddenList
            .add(HomeCategoryHidden.fromRTDB(Map.from(value)));
      }
      return _homeCategoryHiddenList;
    });
  }
}

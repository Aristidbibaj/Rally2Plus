import 'package:firebase_database/firebase_database.dart';
import 'package:rally2plus/controls/globals.dart';
import 'package:rally2plus/models/category_home.dart';
import 'package:rally2plus/models/contacts.dart';
import 'package:rally2plus/models/drivers.dart';
import 'package:rally2plus/models/news.dart';
import 'package:rally2plus/models/originals.dart';
import 'package:rally2plus/models/races.dart';
import 'package:rally2plus/models/rallys.dart';
import 'package:rally2plus/models/standings.dart';
import 'package:rally2plus/models/teams.dart';

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
  late Query _rallysQuery;
  late Query _racesQuery;
  late Query _driversQuery;
  late Query _teamsQuery;
  late Query _standingsQuery;
  late Query _contactsQuery;
  late Query _homeCategoryQuery;
  late Query _homeCategoryHiddenQuery;

  List<News> _newsList = [];
  List<Originals> _originalsList = [];
  List<Rallys> _rallysList = [];
  List<Races> _raceList = [];
  List<Drivers> _driverList = [];
  List<Teams> _teamsList = [];
  List<HomeCategory> _homeCategoryList = [];
  List<HomeCategoryHidden> _homeCategoryHiddenList = [];
  late Standings _standings;
  late Contacts _contacts;
  bool _init = false;

  DatabaseService() {
    _initDBState();
  }

  List<News> get newsList => _newsList;

  void _initDBState() async {
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
    _rallysQuery = _rallyRef.orderByChild("start_datetime");
    _racesQuery = _raceRef.orderByChild("race_date");
    _driversQuery = _driverRef.orderByChild("driver_id");
    _teamsQuery = _teamsRef.orderByChild("teams_id");
    _standingsQuery = _standingsRef;
    _contactsQuery = _contactsRef;
    _homeCategoryQuery = _homeCategoryRef;
    _homeCategoryHiddenQuery = _homeCategoryHiddenRef;
    await populateDB();
  }

  populateDB() async {
    _newsList = await getNews();
    _originalsList = await getOriginals();
    _rallysList = await getRallys();
    _raceList = await getRaces();
    _driverList = await getDrivers();
    _teamsList = await getTeams();
    _standings = await getStandings();
    _homeCategoryList = await getHomeCategory();
    _homeCategoryHiddenList = await getHomeCategoryHidden();
    _contacts = await getContacts();
    _init = true;
  }

  Future<Contacts> getContacts() async {
    return await _contactsQuery.once().then((value) {
      return Contacts.fromRTDB(
          Map<String, dynamic>.from(value.snapshot.value as Map));
    });
  }

  Future<Standings> getStandings() async {
    return await _standingsQuery.once().then((value) {
      return Standings.fromRTDB(value.snapshot.value);
    });
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

  Future<List<Originals>> getOriginals() async {
    _originalsList = [];
    return await _originalsQuery.once().then((value) {
      List list = value.snapshot.value as List;
      for (var value in list) {
        _originalsList.add(Originals.fromRTDB(Map.from(value)));
      }
      return _originalsList;
    });
  }

  Future<List<Rallys>> getRallys() async {
    _rallysList = [];
    return await _rallysQuery.once().then((value) {
      List list = value.snapshot.value as List;
      for (var value in list) {
        _rallysList.add(Rallys.fromRTDB(Map.from(value)));
      }
      return _rallysList;
    });
  }

  Future<List<Races>> getRaces() async {
    _raceList = [];
    return await _racesQuery.once().then((value) {
      List list = value.snapshot.value as List;
      for (var value in list) {
        _raceList.add(Races.fromRTDB(Map.from(value)));
      }
      return _raceList;
    });
  }

  Future<List<Drivers>> getDrivers() async {
    _driverList = [];
    return await _driversQuery.once().then((value) {
      List list = value.snapshot.value as List;
      for (var value in list) {
        _driverList.add(Drivers.fromRTDB(Map.from(value)));
      }
      return _driverList;
    });
  }

  Future<List<Teams>> getTeams() async {
    _teamsList = [];
    return await _teamsQuery.once().then((value) {
      List list = value.snapshot.value as List;
      for (var value in list) {
        _teamsList.add(Teams.fromRTDB(Map.from(value)));
      }
      return _teamsList;
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

  bool get init => _init;

  List<Originals> get originalsList {
    return _init ? _originalsList : [];
  }

  List<Rallys> get rallysList {
    return _init ? _rallysList : [];
  }

  List<Races> get raceList {
    return _init ? _raceList : [];
  }

  List<Drivers> get driverList {
    return _init ? _driverList : [];
  }

  List<Teams> get teamsList {
    return _init ? _teamsList : [];
  }

  List<HomeCategory> get homeCategoryList {
    return _init ? _homeCategoryList : [];
  }

  List<HomeCategoryHidden> get homeCategoryHiddenList {
    return _init ? _homeCategoryHiddenList : [];
  }

  Standings get standings {
    return _init ? _standings : Standings.fromRTDB({});
  }

  Contacts get contacts {
    return _init ? _contacts : Contacts.fromRTDB(kContactsDefault);
  }
}

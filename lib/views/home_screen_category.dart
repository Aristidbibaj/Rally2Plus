import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rally2plus/controls/local_storage.dart';
import 'package:rally2plus/controls/ui.dart';
import 'package:rally2plus/models/notizia.dart';

import '../controls/database_services.dart';
import '../models/category_home.dart';
import '../models/contatti.dart';
import '../models/pilota.dart';
import '../models/prova.dart';
import '../models/rally.dart';

class HomeScreenCategory extends StatefulWidget {
  const HomeScreenCategory({Key? key}) : super(key: key);

  @override
  _HomeScreenCategoryState createState() => _HomeScreenCategoryState();
}

class _HomeScreenCategoryState extends State<HomeScreenCategory> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Future _futureSharedPreferences = LocalStorage.init();
  late DatabaseService databaseService;
  List<Notizia> newsDatabase = [];
  List<Prova> raceDatabase = [];
  List<Pilota> driverDatabase = [];
  List<CategoriaHome> homeCategoryDatabase = [];
  List<Rally> rallyDatabase = [];
  late Contatti contactsDatabase;

  //late String appLanguage;
  //late bool isIta;

  @override
  void initState() {
    super.initState();

    _initDB();
  }

  @override
  Widget build(BuildContext context) {
    final kWidth = MediaQuery.of(context).size.width;
    if (rallyDatabase.isNotEmpty) {
      log('homepage rally 0: ${rallyDatabase[0].nome}');
    }

    if (raceDatabase.isNotEmpty) {
      log('homepage prova 0: ${raceDatabase[0].nome}');
    }
    if (driverDatabase.isNotEmpty) {
      print('homepage category 0: ${homeCategoryDatabase[0].nomeIt}');
    }
    //int indexNews = 0;
    return newsDatabase.isNotEmpty
        ? Scaffold(
            backgroundColor: kWhite,
            appBar: AppBar(
              title: const Text('Rally 2 Plus'),
              centerTitle: true,
              backgroundColor: kRed,
              titleTextStyle: const TextStyle(
                  color: kWhite, fontWeight: FontWeight.bold, fontSize: 24),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(mainAxisSize: MainAxisSize.max, children: [
                      Container(
                        width: kWidth / 2,
                        height: kWidth,
                        padding: const EdgeInsets.all(4),
                        child: GestureDetector(
                          onTap: () {
                            /*Navigator.push(context, CupertinoPageRoute(builder: (context) =>
                              CategoryNewsListPage(
                                  homeCategory?.elementAt(0)?.nomeIt ?? "wrc")));*/
                          },
                          child: buildRectangle(context, 0),
                        ),
                      ),
                      Container(
                        width: kWidth / 2,
                        height: kWidth,
                        child: Column(
                          children: [
                            Container(
                              width: kWidth / 2,
                              height: kWidth / 3,
                              padding: EdgeInsets.fromLTRB(0, 4, 4, 2),
                              child: buildRectangle(context, 1),
                            ),
                            Container(
                              width: kWidth / 2,
                              height: kWidth / 3,
                              padding: EdgeInsets.fromLTRB(0, 2, 4, 2),
                              child: buildRectangle(context, 2),
                            ),
                            Container(
                              width: kWidth / 2,
                              height: kWidth / 3,
                              padding: EdgeInsets.fromLTRB(0, 2, 4, 4),
                              child: buildRectangle(context, 3),
                            ),
                          ],
                        ),
                      ),
                    ]),
                    Container(
                      width: kWidth,
                      height: kWidth / 3,
                      color: kRed,
                      padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                      child: Center(
                        child: Text(
                          'Media',
                          style: TextStyle(
                              color: kWhite,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: kWidth / 2,
                          height: kWidth / 3,
                          color: kRed,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(4, 2, 2, 2),
                            child: Center(child: Text('Work with us',
                                style: TextStyle(
                                color: kWhite,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),)),
                          ),
                        ),
                        Container(
                          width: kWidth / 2,
                          height: kWidth / 3,
                          color: kRed,
                          padding: EdgeInsets.fromLTRB(2, 2, 4, 2),
                          child: Center(child: Text('Social',
                              style: TextStyle(
                              color: kWhite,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        : Center(
            child: Container(
              height: 50.0,
              width: 50.0,
              child: const CircularProgressIndicator(
                strokeWidth: 1.0,
              ),
            ),
          );
  }

  Container buildRectangle(BuildContext context, int index) {
    return Container(
      child: newsDatabase
              .where((element) => element.tag.contains(
                    LocalStorage.isIta()
                        ? homeCategoryDatabase.elementAt(index).nomeIt
                        : homeCategoryDatabase.elementAt(index).nomeEn,
                  ))
              .isEmpty
          ? Center(
              child: Container(
                  width: 30.0,
                  height: 30.0,
                  child: const CircularProgressIndicator()))
          : Stack(
              children: [
                Positioned.fill(
                  child: CachedNetworkImage(
                    imageUrl: newsDatabase
                        .where((element) => element.tag.contains(
                              LocalStorage.isIta()
                                  ? homeCategoryDatabase.elementAt(index).nomeIt
                                  : homeCategoryDatabase
                                      .elementAt(index)
                                      .nomeEn,
                            ))
                        .first
                        .img,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                            child: Container(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress,
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(kRed)),
                      width: 30.0,
                      height: 30.0,
                    )),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                    child: Align(
                  alignment: Alignment.center,
                  child: ClipRRect(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: double.infinity,
                      color: Colors.black38,
                      child: Column(
                        children: [
                          Text(
                            LocalStorage.isIta()
                                ? homeCategoryDatabase
                                    .elementAt(index)
                                    .nomeIt
                                    .toUpperCase()
                                : homeCategoryDatabase
                                    .elementAt(index)
                                    .nomeEn
                                    .toUpperCase(),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                                fontSize: 24.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ))
              ],
            ),
    );
  }

  _initDB() async {
    databaseService = DatabaseService();
    await databaseService
        .getHomeCategory()
        .then((List<CategoriaHome> homeList) {
      setState(() {
        homeCategoryDatabase = homeList;
      });
    });
    await databaseService.getNews().then((List<Notizia> newsList) {
      setState(() {
        newsDatabase = List.from(newsList.reversed);
      });
    });
    /*await databaseService.loadRally().then((List<Rally> rallyList) {
      setState(() {
        rallyDatabase = rallyList;
      });
    });
    await databaseService.loadProva().then((List<Prova> provaList) {
      setState(() {
        provaDatabase = provaList;
      });
    });
    await databaseService.loadPilota().then((List<Pilota> pilotaList) {
      setState(() {
        pilotaDatabase = pilotaList;
      });
    });
    await databaseService.getDataContatti().then((value) {
      setState(() {
        cont = value;
      });
    });*/
  }
}

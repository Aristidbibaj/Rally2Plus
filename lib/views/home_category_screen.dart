import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rally2plus/controls/globals.dart';
import 'package:rally2plus/controls/local_storage.dart';
import 'package:rally2plus/controls/ui.dart';
import 'package:rally2plus/models/news.dart';
import 'package:rally2plus/views/news_list_screen.dart';

import '../controls/database_services.dart';
import '../models/category_home.dart';
import '../models/contacts.dart';
import '../models/drivers.dart';
import '../models/races.dart';
import '../models/rallys.dart';

class HomeScreenCategory extends StatefulWidget {
  final VoidCallback gotoPage0;
  final VoidCallback gotoPage1;
  final VoidCallback gotoPage2;

  const HomeScreenCategory(
      {required this.gotoPage0,
      required this.gotoPage1,
      required this.gotoPage2,
      Key? key})
      : super(key: key);

  @override
  _HomeScreenCategoryState createState() => _HomeScreenCategoryState();
}

class _HomeScreenCategoryState extends State<HomeScreenCategory>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late DatabaseService databaseService;
  List<News> newsDatabase = [];
  List<Races> raceDatabase = [];
  List<Drivers> driverDatabase = [];
  List<HomeCategory> homeCategoryDatabase = [];
  List<HomeCategoryHidden> homeCategoryHiddenDatabase = [];
  List<Rallys> rallyDatabase = [];
  late Contacts contactsDatabase;

  //late String appLanguage;
  //late bool isIta;

  @override
  void initState() {
    super.initState();
    LocalStorage.init();
    databaseService = DatabaseService();
    _initDB();
  }

  @override
  Widget build(BuildContext context) {
    final kWidth = MediaQuery.of(context).size.width;
    /*if (rallyDatabase.isNotEmpty) {
      log('homepage rally 0: ${rallyDatabase[0].nome}');
    }

    if (raceDatabase.isNotEmpty) {
      log('homepage prova 0: ${raceDatabase[0].nome}');
    }
    if (driverDatabase.isNotEmpty) {
      print('homepage category 0: ${homeCategoryDatabase[0].nameIT}');
    }*/
    if (homeCategoryDatabase.isNotEmpty) {
      log('home category database 0: ${homeCategoryDatabase[0].name}');
    }
    if (homeCategoryHiddenDatabase.isNotEmpty) {
      log('home category hidden database 0: ${homeCategoryHiddenDatabase[0].name}');
    }
    //int indexNews = 0;
    return newsDatabase.isNotEmpty
        ? SingleChildScrollView(
            child: buildHomeRectangle(kWidth, context),
          )
        : Center(
            child: Container(
              height: 30.0,
              width: 30.0,
              child: const CircularProgressIndicator(
                strokeWidth: 1.0,
                color: kRed,
              ),
            ),
          );
  }

  Column buildHomeRectangle(double kWidth, BuildContext context) {
    return Column(
      children: [
        Visibility(
          //hidden rectangle 0
          visible: homeCategoryHiddenDatabase[0].visible,
          child: Container(
            color: Colors.red[400],
            width: kWidth,
            height: kWidth / 3,
            padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Center(
                child: Text(
              '${homeCategoryHiddenDatabase[0].name[LocalStorage.getLingua()]}',
              style: TextStyle(
                  color: kWhite, fontSize: 34, fontWeight: FontWeight.bold),
            )),
          ),
        ),
        Row(mainAxisSize: MainAxisSize.max, children: [
          Container(
            //rectangle 0
            width: kWidth / 2,
            height: kWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewsListScreen(
                              categoryName:
                                  '${homeCategoryDatabase[0].name[LocalStorage.getLingua()]}',
                            )));
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
                  //rectangle 1
                  width: kWidth / 2,
                  height: kWidth / 3,
                  padding: EdgeInsets.fromLTRB(0, 8, 8, 4),
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewsListScreen(
                                      categoryName:
                                          '${homeCategoryDatabase[1].name[LocalStorage.getLingua()]}',
                                    )));
                      },
                      child: buildRectangle(context, 1)),
                ),
                Container(
                  //rectangle 2
                  width: kWidth / 2,
                  height: kWidth / 3,
                  padding: EdgeInsets.fromLTRB(0, 4, 8, 4),
                  child: buildRectangle(context, 2),
                ),
                Container(
                  //rectangle
                  width: kWidth / 2,
                  height: kWidth / 3,
                  padding: EdgeInsets.fromLTRB(0, 4, 8, 8),
                  child: InkWell(
                      onTap: widget.gotoPage2,
                      child: buildRectangle(context, 3)),
                ),
              ],
            ),
          ),
        ]),
        Visibility(
          //hidden rectangle 1
          visible: homeCategoryHiddenDatabase[1].visible,
          child: Container(
            color: Colors.red[400],
            width: kWidth,
            height: kWidth / 3,
            padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
            child: Center(
                child: Text(
              '${homeCategoryHiddenDatabase[1].name[LocalStorage.getLingua()]}',
              style: TextStyle(
                  color: kWhite, fontSize: 34, fontWeight: FontWeight.bold),
            )),
          ),
        ),
        Container(
          //rectangle
          width: kWidth,
          height: kWidth / 3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: kRed,
          ),
          margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: InkWell(
              onTap: widget.gotoPage1, child: buildRectangle(context, 4)),
        ),

        ///Last 5 news
        Card(
          margin: EdgeInsets.all(8),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: Container(
            //rectangle
            width: kWidth,
            height: kWidth / 1.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              gradient: LinearGradient(
                colors: [kRed, kDarkGrey],
                stops: [0, 0.2],
              ),
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    for (News tempNews in newsDatabase.getRange(0, 5).toList())
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8.0, top: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: kWidth * 0.15,
                              child: Text(
                                '${tempNews.datetime.split(' ')[1].replaceRange(4, 7, '')}',
                                style: GoogleFonts.museoModerno(
                                    color: kWhite,
                                    fontSize: 16.0,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '${tempNews.title}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.museoModerno(
                                    color: kWhite,
                                    fontSize: 16.0,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            kBlack.withOpacity(0.9),
                            kBlack.withOpacity(0.8),
                            kBlack.withOpacity(0.7),
                            Colors.transparent
                          ]),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0)),
                    ),
                    width: kWidth,
                    height: 50,
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Text(
                        '${kLastNews[LocalStorage.getLingua()]?.toUpperCase()}',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.museoModerno(
                            fontSize: 24.0,
                            color: kWhite,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),

        Visibility(
          //hidden rectangle 2
          visible: homeCategoryHiddenDatabase[2].visible,
          child: Container(
            color: Colors.red[400],
            width: kWidth,
            height: kWidth / 3,
            padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
            child: Stack(
              children: [
                Center(
                    child: Text(
                  '${homeCategoryHiddenDatabase[2].name[LocalStorage.getLingua()]}',
                  style: TextStyle(
                      color: kWhite, fontSize: 34, fontWeight: FontWeight.bold),
                )),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: kRed.withOpacity(0.6),
                      gradient: RadialGradient(
                          colors: [kRed, kRed, Colors.transparent]),
                    ),
                    child: const Icon(
                      Icons.arrow_circle_right_outlined,
                      color: kWhite,
                      size: 40,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                //rectangle 5
                height: kWidth / 3,
                margin: const EdgeInsets.fromLTRB(8.0, 8.0, 4.0, 8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: kRed,
                ),
                child: buildRectangle(context, 5),
              ),
            ),
            Expanded(
              child: Container(
                //rectangle 6
                height: kWidth / 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: kRed,
                ),
                margin: EdgeInsets.fromLTRB(4, 4, 8, 4),
                child: buildRectangle(context, 6),
              ),
            ),
          ],
        ),
        Visibility(
          //hidden rectangle 1
          visible: homeCategoryHiddenDatabase[3].visible,
          child: Container(
            color: Colors.red[400],
            width: kWidth,
            height: kWidth / 3,
            padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
            child: Center(
                child: Text(
              '${homeCategoryHiddenDatabase[3].name[LocalStorage.getLingua()]}',
              style: TextStyle(
                  color: kWhite, fontSize: 34, fontWeight: FontWeight.bold),
            )),
          ),
        ),
      ],
    );
  }

  Container buildRectangle(BuildContext context, int index) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: kRed),
      child: homeCategoryDatabase.isEmpty
          ? Center(
              child: Container(
                  width: 30.0,
                  height: 30.0,
                  child: const CircularProgressIndicator()))
          : Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(
                      imageUrl: homeCategoryDatabase[index].img,
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
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            kBlack.withOpacity(0.9),
                            kBlack.withOpacity(0.8),
                            kBlack.withOpacity(0.7),
                            Colors.transparent
                          ]),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0)),
                    ),
                    width: double.infinity,
                    height: 50,
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Text(
                        '${homeCategoryDatabase.elementAt(index).name[LocalStorage.getLingua()]?.toUpperCase()}',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.museoModerno(
                            fontSize: 24.0,
                            color: kWhite,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                /*Align(
                  alignment: Alignment.bottomRight,
                  child: Stack(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: kRed.withOpacity(0.6),
                          gradient: const RadialGradient(
                              colors: [kRed, kRed, Colors.transparent]),
                        ),
                        child: const Icon(
                          Icons.arrow_circle_right_outlined,
                          color: kWhite,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ),*/
              ],
            ),
    );
  }

  void onDotClicked(int index) {}

  @override
  bool get wantKeepAlive => true;

  _initDB() async {
    databaseService = DatabaseService();
    await databaseService.getHomeCategory().then((List<HomeCategory> homeList) {
      setState(() {
        homeCategoryDatabase = homeList;
      });
    });
    await databaseService
        .getHomeCategoryHidden()
        .then((List<HomeCategoryHidden> homeHiddenList) {
      setState(() {
        homeCategoryHiddenDatabase = homeHiddenList;
      });
    });
    await databaseService.getNews().then((List<News> newsList) {
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

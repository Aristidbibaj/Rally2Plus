import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rally2plus/controls/database_services.dart';
import 'package:rally2plus/controls/globals.dart';
import 'package:rally2plus/controls/local_storage.dart';
import 'package:rally2plus/controls/ui.dart';
import 'package:rally2plus/models/news.dart';
import 'package:rally2plus/views/widgets/news_list_widget.dart';

class BernaccaPage extends StatefulWidget {
  @override
  _BernaccaPageState createState() => _BernaccaPageState();
}

class _BernaccaPageState extends State<BernaccaPage>
    with AutomaticKeepAliveClientMixin {
  late DatabaseService databaseService;
  List<News> newsDatabase = [];
  List<News> newsDatabaseFiltered = [];
  bool _isWatching = false;
  bool _wasSearching = false;
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    LocalStorage.init();
    databaseService = DatabaseService();
    _initDB();
    searchController.addListener(_searchInDB);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final kWidth = MediaQuery.of(context).size.width;

    return newsDatabase.isNotEmpty
        ? SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  margin: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                  elevation: 4.0,
                  shadowColor: kSRed,
                  color: kLLightGrey,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        gradient: LinearGradient(colors: [kSRed, kYellow])),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    'Bernacca',
                                    style: TextStyle(
                                        color: kWhite,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 250),
                                      transitionBuilder: (child, anim) =>
                                          RotationTransition(
                                            turns: child.key ==
                                                    ValueKey('maximize')
                                                ? Tween<double>(
                                                        begin: 0.75, end: 1)
                                                    .animate(anim)
                                                : Tween<double>(
                                                        begin: 0.75, end: 1)
                                                    .animate(anim),
                                            child: FadeTransition(
                                                opacity: anim, child: child),
                                          ),
                                      child: !_isWatching
                                          ? const Icon(Icons.info_outline,
                                              key: ValueKey('maximize'),
                                              color: kRed,
                                              size: 24.0)
                                          : const Icon(
                                              Icons.cancel_outlined,
                                              key: ValueKey('minimize'),
                                              color: kRed,
                                              size: 24.0,
                                            )),
                                  onPressed: () {
                                    setState(() {
                                      _isWatching = !_isWatching;
                                    });
                                  },
                                ),
                              ],
                            ),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: IconButton(
                                icon: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 250),
                                    transitionBuilder: (child, anim) =>
                                        RotationTransition(
                                          turns: child.key ==
                                                  ValueKey('iconSearch')
                                              ? Tween<double>(
                                                      begin: 0.75, end: 1)
                                                  .animate(anim)
                                              : Tween<double>(
                                                      begin: 0.75, end: 1)
                                                  .animate(anim),
                                          child: FadeTransition(
                                              opacity: anim, child: child),
                                        ),
                                    child: !_wasSearching
                                        ? const Icon(Icons.search_outlined,
                                            key: ValueKey('iconSearch'),
                                            color: kRed,
                                            size: 30.0)
                                        : const Icon(
                                            Icons.cancel_outlined,
                                            key: ValueKey('iconArrowBack'),
                                            color: kRed,
                                            size: 30.0,
                                          )),
                                onPressed: () {
                                  searchController.clear();
                                  setState(() {
                                    _wasSearching = !_wasSearching;
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                        AnimatedContainer(
                          height: _isWatching ? kWidth / 1.8 : 0,
                          curve: Curves.easeOutCubic,
                          padding: _isWatching
                              ? EdgeInsets.only(bottom: 8)
                              : EdgeInsets.zero,
                          duration: const Duration(milliseconds: 550),
                          child: ClipRRect(
                            child: Image.asset(
                              'images/bernacca.jpg',
                              fit: BoxFit.cover,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                        AnimatedContainer(
                          height: _wasSearching ? kWidth / 8 : 0,
                          curve: Curves.ease,
                          duration: const Duration(milliseconds: 250),
                          child: Container(
                            margin: _wasSearching
                                ? const EdgeInsets.only(bottom: 8)
                                : EdgeInsets.zero,
                            child: TextField(
                              controller: searchController,
                              style: TextStyle(color: kBlack, fontSize: 18.0),
                              onChanged: (value) => setState(() {
                                searchController.text;
                              }),
                              enabled: _wasSearching,
                              autofocus: true,
                              decoration: InputDecoration(
                                hintText: kSearch[LocalStorage.getLingua()],
                                contentPadding: EdgeInsets.all(8.0),
                                enabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide:
                                        BorderSide(color: kRed, width: 1.0)),
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide:
                                        BorderSide(color: kRed, width: 1.0)),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide:
                                      BorderSide(color: kRed, width: 1.0),
                                ),
                                disabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                              ),
                              cursorColor: kRed,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                for (News notiz in newsDatabaseFiltered)
                  MaterialButton(
                    onPressed: () {},
                    child: NewsListWidget(
                      newsToView: notiz,
                    ),
                  ),
              ],
            ),
          )
        : Container();
  }

  /*List<Notizia> getNewsDBFilteredByTAG(int index) {
    List<Notizia> newsList = [];
    for (Notizia notiz in newsDatabase.reversed
        .where((element) => element.categoria == 'bernacca')
        .where((element) => LocalStorage.isIta()
        ? element.tag
        .contains(kFiltriHomeBernacca[index][getLingua()].toLowerCase())
        : element.tagEn.contains(
        kFiltriHomeBernacca[index][getLingua()].toLowerCase())))
      newsList.add(notiz);
    return newsList;
  }*/

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  _initDB() async {
    databaseService = DatabaseService();
    await databaseService.getNews().then((List<News> newsList) {
      setState(() {
        newsDatabaseFiltered = newsDatabase = List.from(newsList.reversed
            .where((element) => element.category.contains('bernacca')));
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

  void _searchInDB() {
    if (_wasSearching) {
      setState(() {
        newsDatabaseFiltered = newsDatabase
            .where((element) => element.title[LocalStorage.getLingua()]
                .trim()
                .toLowerCase()
                .contains(searchController.text.trim().toLowerCase()))
            .toList();
      });
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}

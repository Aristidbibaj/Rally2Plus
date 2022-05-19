import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:rally2plus/controls/globals.dart';
import 'package:rally2plus/controls/local_storage.dart';
import 'package:rally2plus/controls/ui.dart';
import 'package:rally2plus/models/contacts.dart';
import 'package:rally2plus/models/custom_month_peacker.dart';
import 'package:rally2plus/models/news.dart';

import '../controls/database_services.dart';

class OriginalContents extends StatefulWidget {
  const OriginalContents({Key? key}) : super(key: key);

  @override
  State<OriginalContents> createState() => _OriginalContentsState();
}

class _OriginalContentsState extends State<OriginalContents>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late DatabaseService databaseService;
  List<News> newsDatabase = [];
  List<News> newsDatabaseFiltered = [];
  late Contacts contactsDatabase;
  final searchController = TextEditingController();

  DateTime _currentDate = DateTime.now();
  final thismonth = DateTime.now().month;
  final thisyear = DateTime.now().year;
  bool _wasSearching = false;

  bool? _checkPhoto = null;
  bool? _checkVideo = null;
  bool? _checkAudio = null;
  bool? _checkNews = null;

  //late String appLanguage;
  //late bool isIta;

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
    final kWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: kWidth,
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.fromLTRB(8, 8, 8, 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              gradient: LinearGradient(colors: [
                kSRed,
                kDPurple,
              ]),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Original Contents',
                        style: const TextStyle(
                            color: kWhite,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const Spacer(),
                    Visibility(
                      visible: !(_currentDate.year == DateTime.now().year &&
                          _currentDate.month == DateTime.now().month),
                      child: Container(
                        padding: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: kRed,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${_currentDate.year}/${_currentDate.month}',
                                style: const TextStyle(
                                    color: kRed,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                                textAlign: TextAlign.right,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              InkWell(
                                  onTap: () {
                                    setState(() {
                                      _currentDate = DateTime.now();
                                    });
                                  },
                                  child: const Icon(
                                    Icons.cancel_outlined,
                                    color: kRed,
                                    size: 16.0,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: IconButton(
                          splashColor: kWhite,
                          padding: EdgeInsets.zero,
                          onPressed: () async {
                            DatePicker.showPicker(
                              context,
                              pickerModel: CustomMonthPicker(
                                minTime: DateTime(2020),
                                maxTime: DateTime.now(),
                                currentTime: _currentDate,
                                locale: LocaleType.it,
                              ),
                              theme: const DatePickerTheme(
                                backgroundColor: kLLightGrey,
                                cancelStyle:
                                    TextStyle(color: kDarkGrey, fontSize: 18.0),
                                doneStyle:
                                    TextStyle(color: kRed, fontSize: 18.0),
                                itemStyle:
                                    TextStyle(color: kDarkGrey, fontSize: 18.0),
                                headerColor: kBlack,
                                containerHeight: 150.0,
                              ),
                              showTitleActions: true,
                              onCancel: () {
                                setState(() {
                                  _currentDate = DateTime.now();
                                });
                              },
                              onChanged: (date) {
                                setState(() {
                                  _currentDate = date;
                                });
                              },
                              onConfirm: (date) {
                                setState(() {
                                  _currentDate = date;
                                });
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.filter_list,
                            color: kRed,
                            size: 30,
                          )),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: IconButton(
                        icon: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 250),
                            transitionBuilder: (child, anim) =>
                                RotationTransition(
                                  turns: child.key == ValueKey('iconSearch')
                                      ? Tween<double>(begin: 0.75, end: 1)
                                          .animate(anim)
                                      : Tween<double>(begin: 0.75, end: 1)
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
                  height: _wasSearching ? kWidth / 8 : 0,
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 250),
                  child: TextField(
                    controller: searchController,
                    style: TextStyle(color: kBlack, fontSize: 18.0),
                    onChanged: (value) => setState(() {
                      searchController.text;
                    }),
                    enabled: _wasSearching,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: kCerca[LocalStorage.getLingua()],
                      contentPadding: EdgeInsets.all(8.0),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: kRed, width: 1.0)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: kRed, width: 1.0)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: kRed, width: 1.0),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                    cursorColor: kRed,
                  ),
                ),
              ],
            ),
          ),
          /*Container(
            child: Row(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Row(
                    children: [
                      Text('Photo'),
                      Checkbox(
                          value: _checkPhoto,
                          tristate: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                          ),
                          onChanged: (value) {
                            setState(() {
                              _checkPhoto = value!;
                            });
                          }),
                    ],
                  ),
                ),
                Card(
                  child: Row(
                    children: [
                      Text('Video'),
                      Checkbox(
                          value: _checkVideo,
                          tristate: true,
                          onChanged: (value) {
                            setState(() {
                              _checkVideo = value!;
                            });
                          }),
                    ],
                  ),
                ),
                Card(
                  child: Row(
                    children: [
                      Text('Audio'),
                      Checkbox(
                          value: _checkAudio,
                          tristate: true,
                          onChanged: (value) {
                            setState(() {
                              _checkAudio = value!;
                            });
                          }),
                    ],
                  ),
                ),
                Card(
                  child: Row(
                    children: [
                      Text('News'),
                      Checkbox(
                          value: _checkNews,
                          tristate: true,
                          onChanged: (value) {
                            setState(() {
                              _checkNews = value!;
                            });
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),*/
        ],
      ),
    );
  }

  _filterDB() {
    newsDatabaseFiltered = newsDatabase
        .where((element) => element.category.contains('notizia'))
        .where(
            (news) => DateTime.parse(news.datetime).compareTo(_currentDate) < 1)
        .toList();
    if (_wasSearching) _searchInDB();
  }

  void _searchInDB() {
    if (_wasSearching) {
      if (DateTime.now().year == _currentDate.year &&
          DateTime.now().month == _currentDate.month) {
        setState(() {
          newsDatabaseFiltered = newsDatabase
              .where((element) => element.title[LocalStorage.getLingua()]
                  .trim()
                  .toLowerCase()
                  .contains(searchController.text.trim().toLowerCase()))
              .toList();
        });
      } else {
        setState(() {
          newsDatabaseFiltered = newsDatabaseFiltered
              .where((element) => element.title[LocalStorage.getLingua()]
                  .trim()
                  .toLowerCase()
                  .contains(searchController.text.trim().toLowerCase()))
              .toList();
        });
      }
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void onDotClicked(int index) {}

  @override
  bool get wantKeepAlive => true;

  _initDB() async {
    databaseService = DatabaseService();

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

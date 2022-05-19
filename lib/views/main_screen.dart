import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rally2plus/controls/globals.dart';
import 'package:rally2plus/controls/local_storage.dart';
import 'package:rally2plus/controls/ui.dart';
import 'package:rally2plus/models/news.dart';
import 'package:rally2plus/views/bernacca_screen.dart';
import 'package:rally2plus/views/contacts_screen.dart';
import 'package:rally2plus/views/contenuti_originali_screen.dart';

import '../controls/database_services.dart';
import '../models/category_home.dart';
import '../models/contacts.dart';
import '../models/drivers.dart';
import '../models/races.dart';
import '../models/rallys.dart';
import 'home_category_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late DatabaseService databaseService;
  List<News> newsDatabase = [];
  List<Races> raceDatabase = [];
  List<Drivers> driverDatabase = [];
  List<HomeCategory> homeCategoryDatabase = [];
  List<HomeCategoryHidden> homeCategoryHiddenDatabase = [];
  List<Rallys> rallyDatabase = [];
  late Contacts contactsDatabase;

  PageController pageController = PageController();
  int selectedPage = 0;
  late String selectedLanguage;

  //late String appLanguage;
  //late bool isIta;

  @override
  void initState() {
    super.initState();
    LocalStorage.init();
    selectedLanguage = LocalStorage.getLingua();
    databaseService = DatabaseService();
    contactsDatabase = Contacts(
        collaborators: '${contactsDefault['collaboratori']}',
        developers: '${contactsDefault['sviluppatori']}',
        rally2plus_web_link: '${contactsDefault['linkinstagramwrc']}');
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
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kWhite,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kRed //change your color here
            ),
        elevation: 4.0,
        shadowColor: kBlue,
        leading: Padding(
          padding: const EdgeInsets.all(14.0),
          child: MaterialButton(
            onPressed: () {
              setState(() {
                LocalStorage.instance
                    .setString('lingua', LocalStorage.isIta() ? 'en' : "it");
              });
            },
            //borderSide: BorderSide(color: kWhiteTextColor, width: 1.0),
            child: Image.asset(LocalStorage.isIta()
                ? "images/flags/italia.png"
                : "images/flags/uk.png"),
            padding: EdgeInsets.all(2.0),
            splashColor: kRed,
            //highlightedBorderColor: kBlackColor,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
            //borderSide: BorderSide(color: kWhiteTextColor, width: 1.0),
            icon: Icon(
              Icons.menu,
              color: kRed,
            ),
            splashColor: kLLightGrey,
            //highlightedBorderColor: kBlackColor,
          )
        ],
        title: Container(
          padding: EdgeInsets.only(bottom: 2.0),
          height: 65.0, //AppBar().preferredSize.height,
          child: Image.asset(
            'images/rallytwoplus.png',
            fit: BoxFit.contain,
            color: kRed,
          ),
        ),
        backgroundColor: kWhite,
      ),
      endDrawer: build_drawer(),
      bottomNavigationBar: BottomNavigationBar(
        items: _getBottomNavigationBar(),
        onTap: onBottomNavBarItemTapped,
        elevation: 4.0,
        selectedItemColor: kRed,
        unselectedItemColor: kDarkGrey,
        showUnselectedLabels: true,
        currentIndex: selectedPage,
        iconSize: 28.0,
        selectedFontSize: 14.0,
      ),
      body: newsDatabase.isEmpty
          ? SafeArea(
              child: Container(
                width: kWidth,
                height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.symmetric(vertical: kWidth / 4),
                child: Column(
                  children: [
                    Container(
                      child: ClipRRect(
                        child: Image.asset(
                          'images/rallytwoplus.png',
                          fit: BoxFit.cover,
                          color: kLLightGrey,
                        ),
                      ),
                    ),
                    LinearProgressIndicator(
                      color: kRed,
                      backgroundColor: kLLightGrey,
                      minHeight: 2,
                    ),
                  ],
                ),
              ),
            )
          : SafeArea(
              child: PageView(
                controller: pageController,
                children: <Widget>[
                  HomeScreenCategory(
                    gotoPage0: () => onBottomNavBarItemTapped(0),
                    gotoPage1: () => onBottomNavBarItemTapped(1),
                    gotoPage2: () => onBottomNavBarItemTapped(2),
                  ),
                  OriginalContents(),
                  BernaccaPage(),
                ],
                onPageChanged: onBottomNavBarItemTapped,
                physics: NeverScrollableScrollPhysics(),
              ),
            ),
    );
  }

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
    await databaseService.getContacts().then((contacts) {
      contactsDatabase = contacts;
    });
  }

  void onBottomNavBarItemTapped(int pageIndex) {
    setState(() {
      selectedPage = pageIndex;
      pageController.jumpToPage(pageIndex);
    });
  }

  List<BottomNavigationBarItem> _getBottomNavigationBar() {
    List<BottomNavigationBarItem> bnbItems = [];
    List<IconData> iconList = getBottomNavBarIcons();
    for (int i = 0; i < kBottomNavBarName.length; i++) {
      bnbItems.add(BottomNavigationBarItem(
        icon: Icon(
          iconList[i],
          size: 24.0,
        ),
        label: kBottomNavBarName[i][LocalStorage.getLingua()],
      ));
    }
    return bnbItems;
  }

  build_drawer() {
    return Drawer(
      elevation: 16,
      child: Container(
        color: kWhite,
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              child: Image.asset(
                'images/rallytwoplus.png',
                fit: BoxFit.contain,
                color: kRed,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Divider(
                color: kBlack,
                thickness: 1.0,
                height: 0.0,
              ),
            ),
            SingleChildScrollView(
              child: Container(
                color: kWhite,
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 32.0),
                      leading: Icon(
                        kBottomNavBarIcons[0],
                        color: kRed,
                      ),
                      onTap: () {
                        setState(() {
                          selectedPage = 0;
                          pageController.jumpToPage(0);
                          Navigator.pop(context);
                        });
                      },
                      title: Text(
                        '${kBottomNavBarName[0][LocalStorage.getLingua()]}',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.montserrat(
                            fontSize: 18.0, color: kBlack),
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 32.0),
                      leading: Icon(
                        kBottomNavBarIcons[1],
                        color: kRed,
                      ),
                      onTap: () {
                        setState(() {
                          selectedPage = 1;
                          pageController.jumpToPage(1);
                          Navigator.pop(context);
                        });
                      },
                      title: Text(
                        '${kBottomNavBarName[1][LocalStorage.getLingua()]}',
                        style: GoogleFonts.montserrat(
                            fontSize: 18.0, color: kBlack),
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 32.0),
                      leading: Icon(
                        kBottomNavBarIcons[2],
                        color: kRed,
                      ),
                      onTap: () {
                        setState(() {
                          selectedPage = 2;
                          pageController.jumpToPage(2);
                          Navigator.pop(context);
                        });
                      },
                      title: Text(
                        '${kBottomNavBarName[2][LocalStorage.getLingua()]}',
                        style: GoogleFonts.montserrat(
                            fontSize: 18.0, color: kBlack),
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 32.0),
                      leading: Icon(
                        Icons.phone_android,
                        color: kRed,
                      ),
                      onTap: () {
                        setState(() {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ContactsScreen(contactsDatabase)));
                        });
                      },
                      title: Text(
                        '${kContacts[LocalStorage.getLingua()]}',
                        style: GoogleFonts.montserrat(
                            fontSize: 18.0, color: kBlack),
                      ),
                    ),
                    ExpansionTile(
                      tilePadding: EdgeInsets.symmetric(horizontal: 32.0),
                      key: GlobalKey(),
                      leading: Icon(
                        Icons.language_outlined,
                        color: kRed,
                      ),
                      title: Text(
                        '${kLanguage[LocalStorage.getLingua()]}',
                        style: GoogleFonts.montserrat(
                            fontSize: 18.0, color: kBlack),
                      ),
                      //trailing: Icon(Icons.keyboard_arrow_down_outlined,color: kWhiteTextColor,),
                      childrenPadding: const EdgeInsets.only(left: 45.0),

                      children: [
                        RadioListTile(
                          value: 'it',
                          groupValue: selectedLanguage,
                          activeColor: kRed,
                          title: Text(
                            'Italiano',
                            style: GoogleFonts.montserrat(
                              color: kBlack,
                            ),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              LocalStorage.instance.setString('lingua', value!);
                              selectedLanguage = value;
                            });
                          },
                        ),
                        RadioListTile(
                          value: 'en',
                          groupValue: selectedLanguage,
                          activeColor: kRed,
                          title: Text(
                            'English',
                            style: GoogleFonts.montserrat(
                              color: kBlack,
                            ),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              LocalStorage.instance.setString('lingua', value!);
                              selectedLanguage = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

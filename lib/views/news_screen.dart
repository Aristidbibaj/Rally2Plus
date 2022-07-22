import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rally2plus/controls/database_services.dart';
import 'package:rally2plus/controls/globals.dart';
import 'package:rally2plus/controls/local_storage.dart';
import 'package:rally2plus/controls/ui.dart';
import 'package:rally2plus/models/news.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class NewsScreen extends StatefulWidget {
  News news;

  NewsScreen(this.news);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late DatabaseService databaseService;
  List<News> newsDatabase = [];
  late News news;
  late YoutubePlayerController _playerController;
  late MultiImageProvider multiImageProvider;

  void runYoutubePlayer() {
    _playerController = YoutubePlayerController(
      initialVideoId: '${YoutubePlayer.convertUrlToId(news.media_link)}',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    news = widget.news;
    if (news.is_video) runYoutubePlayer();
    databaseService = DatabaseService();
    _initDB();
  }

  _initDB() async {
    await databaseService.getNews().then((List<News> newsList) {
      setState(() {
        newsDatabase = [];
        newsDatabase = List.from(newsList.reversed
            .where((element) => element.category.contains('news')));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double kWidth = MediaQuery.of(context).size.width;
    return newsDatabase.isNotEmpty
        ? news.is_video
            ? YoutubePlayerBuilder(
                player: YoutubePlayer(
                  controller: _playerController,
                  progressIndicatorColor: kRed,
                  progressColors: ProgressBarColors(
                    backgroundColor: kWhite,
                    bufferedColor: kLLightGrey,
                    handleColor: kRed,
                    playedColor: kRed,
                  ),
                ),
                builder: (context, player) {
                  return Scaffold(
                    key: _scaffoldKey,
                    backgroundColor: kWhite,
                    body: SafeArea(
                      top: false,
                      bottom: false,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                player,
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).padding.top,
                                      left: 8.0),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      icon: Icon(
                                        Icons.arrow_back_ios_new_outlined,
                                        color: kRed,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              width: kWidth,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        4.0, 4.0, 4.0, 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        news.flag == ('spilla.png')
                                            ? Container(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Icon(
                                                  FontAwesomeIcons.thumbtack,
                                                  size: 14.0,
                                                  color: kRed,
                                                ),
                                              )
                                            : Container(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Image.asset(
                                                  'images/flags/${news.flag}',
                                                  height: 16,
                                                ),
                                              ),
                                        SizedBox(
                                          width: 4.0,
                                        ),
                                        Text(
                                          news.datetime.split('-')[0],
                                          style: GoogleFonts.roboto(
                                            color: kBlack,
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          'Fonte: ' + news.source,
                                          style: GoogleFonts.roboto(
                                            color: kBlack,
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.w300,
                                          ),
                                          softWrap: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Card(
                                    color: kWhite,
                                    elevation: 0.0,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                        vertical: 2.0,
                                      ),
                                      child: Text(
                                        news.title[LocalStorage.getLingua()]
                                            .toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                          color: kBlack,
                                          fontSize: 32.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        //maxLines: 2,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 64.0, vertical: 8.0),
                                    child: Divider(
                                      color: kRed,
                                      height: 8.0,
                                      thickness: 1.0,
                                    ),
                                  ),
                                  /*Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 64.0),
                              child: Divider(
                                color: kRed,
                                height: 8.0,
                                thickness: 1.0,
                              ),
                            ),*/
                                  Card(
                                    color: kWhite,
                                    elevation: 0.0,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                        vertical: 4.0,
                                      ),
                                      child: Text(
                                        news.subtitle[LocalStorage.getLingua()]
                                            .toUpperCase(),
                                        style: GoogleFonts.roboto(
                                          color: kBlack,
                                          height: 1.4,
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Card(
                                    color: kWhite,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                        vertical: 4.0,
                                      ),
                                      child: news.containQuotedText()
                                          ? getQuotedTextWidget(
                                              language:
                                                  LocalStorage.getLingua())
                                          : Text(
                                              news.text[
                                                  LocalStorage.getLingua()],
                                              style: GoogleFonts.roboto(
                                                color: kBlack,
                                                height: 1.4,
                                                letterSpacing: .6,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 8.0),
                              width: kWidth,
                              alignment: Alignment.center,
                              child: getRelatedNews(
                                              language:
                                                  LocalStorage.getLingua(),
                                              news: news)
                                          .length >
                                      0
                                  ? Text(
                                      '${kReadMore[LocalStorage.getLingua()]}',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 24,
                                        color: kBlack,
                                      ),
                                    )
                                  : Container(),
                            ),
                            Card(
                              color: kWhite,
                              margin: EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 30.0),
                              child: Container(
                                width: kWidth,
                                height: kWidth * 0.40,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: getRelatedNews(
                                      language: LocalStorage.getLingua(),
                                      news: news),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : Scaffold(
                key: _scaffoldKey,
                backgroundColor: kWhite,
                body: news != null
                    ? SafeArea(
                        top: false,
                        bottom: false,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: kWidth,
                                    height: kWidth * 11 / 16,
                                    child: CachedNetworkImage(
                                      imageUrl: news.title_img,
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              Center(
                                                  child: Container(
                                        child: CircularProgressIndicator(
                                            value: downloadProgress.progress,
                                            strokeWidth: 2,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    kRed)),
                                        width: 30.0,
                                        height: 30.0,
                                      )),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).padding.top,
                                    ),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        icon: Icon(
                                          Icons.arrow_back_ios_new_outlined,
                                          color: kRed,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: kWidth,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          4.0, 4.0, 4.0, 6.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          news.flag == ('spilla.png')
                                              ? Container(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Icon(
                                                    FontAwesomeIcons.thumbtack,
                                                    size: 14.0,
                                                    color: kRed,
                                                  ),
                                                )
                                              : Container(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Image.asset(
                                                    'images/flags/${news.flag}',
                                                    height: 16,
                                                  ),
                                                ),
                                          SizedBox(
                                            width: 4.0,
                                          ),
                                          Text(
                                            news.datetime.split('-')[0],
                                            style: GoogleFonts.roboto(
                                              color: kBlack,
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            'Fonte: ' + news.source,
                                            style: GoogleFonts.roboto(
                                              color: kBlack,
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.w300,
                                            ),
                                            softWrap: true,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Card(
                                      color: kWhite,
                                      elevation: 0.0,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0,
                                          vertical: 2.0,
                                        ),
                                        child: Text(
                                          news.title[LocalStorage.getLingua()]
                                              .toUpperCase(),
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.montserrat(
                                            color: kBlack,
                                            fontSize: 32.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          //maxLines: 2,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 64.0, vertical: 8.0),
                                      child: Divider(
                                        color: kRed,
                                        height: 8.0,
                                        thickness: 1.0,
                                      ),
                                    ),
                                    /*Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 64.0),
                            child: Divider(
                              color: kRed,
                              height: 8.0,
                              thickness: 1.0,
                            ),
                          ),*/
                                    Card(
                                      color: kWhite,
                                      elevation: 0.0,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0,
                                          vertical: 4.0,
                                        ),
                                        child: Text(
                                          news.subtitle[
                                                  LocalStorage.getLingua()]
                                              .toUpperCase(),
                                          style: GoogleFonts.roboto(
                                            color: kBlack,
                                            height: 1.4,
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Card(
                                      color: kWhite,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0,
                                          vertical: 4.0,
                                        ),
                                        child: news.containQuotedText()
                                            ? getQuotedTextWidget(
                                                language:
                                                    LocalStorage.getLingua())
                                            : Text(
                                                news.text[
                                                    LocalStorage.getLingua()],
                                                style: GoogleFonts.roboto(
                                                  color: kBlack,
                                                  height: 1.4,
                                                  letterSpacing: .6,
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: news.is_multi_img,
                                child: Container(
                                  width: kWidth,
                                  height: kWidth * 0.5,
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 8.0),
                                        width: kWidth,
                                        alignment: Alignment.center,
                                        child: Text(
                                          '$kMedia',
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.montserrat(
                                            fontSize: 24,
                                            color: kBlack,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount:
                                              news.multi_imgs_link.length,
                                          itemBuilder: (context, index) {
                                            return MaterialButton(
                                              padding:
                                                  EdgeInsets.only(left: 8.0),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0)),
                                              onPressed: () {
                                                if (news.is_multi_img)
                                                  multiImageProvider =
                                                      MultiImageProvider([
                                                    for (String img_link
                                                        in news.multi_imgs_link)
                                                      Image.network(img_link)
                                                          .image
                                                  ], initialIndex: index);
                                                showImageViewerPager(
                                                  context,
                                                  multiImageProvider,
                                                  backgroundColor:
                                                      Color(0XFFF4F4F4),
                                                  closeButtonColor: kRed,
                                                  onPageChanged: (page) {},
                                                  onViewerDismissed: (page) {},
                                                );
                                              },
                                              child: FittedBox(
                                                fit: BoxFit.cover,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  child: CachedNetworkImage(
                                                    imageUrl: news
                                                        .multi_imgs_link[index],
                                                    fit: BoxFit.fitHeight,
                                                    progressIndicatorBuilder:
                                                        (context, url,
                                                                downloadProgress) =>
                                                            Center(
                                                                child:
                                                                    Container(
                                                      child: CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress,
                                                          strokeWidth: 2,
                                                          valueColor:
                                                              const AlwaysStoppedAnimation<
                                                                  Color>(kRed)),
                                                      width: 30.0,
                                                      height: 30.0,
                                                    )),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: getRelatedNews(
                                            language: LocalStorage.getLingua(),
                                            news: news)
                                        .length >
                                    0,
                                child: Column(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 8.0),
                                        width: kWidth,
                                        alignment: Alignment.center,
                                        child: Text(
                                          '${kReadMore[LocalStorage.getLingua()]}',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 24,
                                            color: kBlack,
                                          ),
                                        )),
                                    Card(
                                      color: kWhite,
                                      margin: EdgeInsets.fromLTRB(
                                          4.0, 4.0, 4.0, 30.0),
                                      child: Container(
                                        width: kWidth,
                                        height: kWidth * 0.40,
                                        child: ListView(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          children: getRelatedNews(
                                              language:
                                                  LocalStorage.getLingua(),
                                              news: news),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : Center(
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            LocalStorage.isIta()
                                ? 'ERRORE, Torna Indietro!'
                                : 'ERROR, Go Back!',
                            style: GoogleFonts.frederickaTheGreat(
                              fontSize: 40.0,
                              color: kBlack,
                            ),
                          ),
                        ),
                      ),
              )
        : Container();
  }

  @override
  void deactivate() {
    if (news.is_video) _playerController.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    if (news.is_video) _playerController.dispose();
    super.dispose();
  }

  Widget getQuotedTextWidget({required String language}) {
    return Column(
      children: [
        for (int i = 0;
            i < news.getFormattedQuotedText(language: language).length;
            i++)
          i % 2 == 0
              ? Text(
                  news.getFormattedQuotedText(language: language)[i],
                  style: GoogleFonts.roboto(
                    color: kBlack,
                    height: 1.4,
                    letterSpacing: .6,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(bottom: 16.0),
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                      color: kLightGrey.withOpacity(0.50),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Text(
                    news.getFormattedQuotedText(language: language)[1],
                    style: GoogleFonts.roboto(
                      color: kBlack,
                      height: 1.4,
                      letterSpacing: .6,
                      fontSize: 15.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
      ],
    );
  }

  List<Widget> getRelatedNews({required String language, required News news}) {
    List<Widget> relatedNewsWidgetsList = [];
    List<News> relatedNewsList = [];
    bool found, complete = false;
    int j = 0, k = 3, l = 6, m = 8; //counter for creating 3 3 2 2 tag list
    for (int i = 0;
        i < newsDatabase.length || relatedNewsList.length > 10;
        i++) {
      found = false;
      if (news.id != newsDatabase[i].id) {
        if (j < 3 && !found) {
          if (newsDatabase[i]
              .tag['en']
              .toString()
              .contains(news.tag['en'][0])) {
            relatedNewsList.add(newsDatabase[i]);
            found = true;
            i++;
            j++;
          }
        }
        if (k < 6 && !found) {
          if (newsDatabase[i]
              .tag['en']
              .toString()
              .contains(news.tag['en'][1])) {
            relatedNewsList.add(newsDatabase[i]);
            found = true;
            i++;
            k++;
          }
        }
        if (l < 8 && !found) {
          if (newsDatabase[i]
              .tag['en']
              .toString()
              .contains(news.tag['en'][2])) {
            relatedNewsList.add(newsDatabase[i]);
            found = true;
            i++;
            l++;
          }
        }
        if (m < 10 && !found) {
          if (newsDatabase[i]
              .tag['en']
              .toString()
              .contains(news.tag['en'][3])) {
            relatedNewsList.add(newsDatabase[i]);
            found = true;
            i++;
            m++;
          }
        }
      }
    }
    for (News tmpNews in relatedNewsList) {
      relatedNewsWidgetsList.add(getRelatedNewsWidget(tmpNews));
    }
    return relatedNewsWidgetsList;
  }

  Widget getRelatedNewsWidget(News news) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => NewsScreen(news)));
        /*Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 400),
              pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                return NewsScreen(notiz);
              },
              transitionsBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child) {
                return Align(
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                );
              },
            ),
          );*/
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.width * 0.4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0), color: kBlack),
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    imageUrl: news.title_img,
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
                  height: 40,
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    news.title[LocalStorage.getLingua()],
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.museoModerno(
                        fontSize: 14.0,
                        color: kWhite,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5),
                  ),
                ),
              ),
              Positioned(
                  child: Align(
                alignment: Alignment.center,
                child: Visibility(
                  visible: news.is_video,
                  child: ClipRRect(
                    child: Icon(
                      Icons.play_circle_outline_outlined,
                      color: kRed,
                      size: 70.0,
                    ),
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}

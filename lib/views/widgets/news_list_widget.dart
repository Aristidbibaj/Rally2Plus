import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rally2plus/models/news.dart';

import '../../controls/local_storage.dart';
import '../../controls/ui.dart';

class NewsListWidget extends StatelessWidget {
  final News newsToView;

  NewsListWidget({required this.newsToView, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final kWidth = MediaQuery.of(context).size.width;
    return Container(
      width: kWidth,
      height: kWidth / 2.2,
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: kWhite,
          elevation: 4.0,
          shadowColor: kBlue,
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Stack(
            children: [
              Row(
                children: [
                  Spacer(),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: newsToView.title_img,
                        fit: BoxFit.fitHeight,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                                child: Container(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress,
                              strokeWidth: 2,
                              valueColor:
                                  const AlwaysStoppedAnimation<Color>(kRed)),
                          width: 30.0,
                          height: 30.0,
                        )),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      )),
                ],
              ),
              Visibility(
                visible: newsToView.is_video,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: kRed.withOpacity(0.6),
                      gradient: const RadialGradient(colors: [
                        kRed,
                        kRed,
                        kRed,
                        kRed,
                        Colors.transparent,
                        Colors.transparent,
                      ]),
                    ),
                    child: Icon(
                      Icons.play_circle_outline_outlined,
                      color: kWhite,
                      size: 40,
                    ),
                  ),
                ),
              ),
              Container(
                width: kWidth / 1.45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(colors: [
                    kLLightGrey,
                    kLLightGrey,
                    kLLightGrey,
                    kLLightGrey,
                    kLLightGrey,
                    kLLightGrey,
                    kLLightGrey,
                    kLLightGrey.withOpacity(0.9),
                    kLLightGrey.withOpacity(0.8),
                    kLLightGrey.withOpacity(0.6),
                    kLLightGrey.withOpacity(0.3),
                    kLLightGrey.withOpacity(0.1),
                    kLLightGrey.withOpacity(0.01),
                  ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: newsToView.flag == ('spilla.png')
                          ? const ClipRRect(
                              child: Icon(
                                Icons.newspaper_rounded,
                                color: kRed,
                              ), /*Image.asset(
                          'images/default_images/spilla.png',
                          height: 20.0,
                          fit: BoxFit.fitWidth,
                        ),*/
                            )
                          : ClipRRect(
                              child: Image.asset(
                                'images/flags/${newsToView.flag}',
                                height: 18,
                              ),
                            ),
                      margin: const EdgeInsets.all(8.0),
                    ),
                    Container(
                      width: kWidth / 2,
                      margin: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        newsToView.title[LocalStorage.getLingua()]
                            .toUpperCase(),
                        style: GoogleFonts.montserrat(
                          fontSize: 21.0,
                          color: kBlack,
                          height: 1.0,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    /*Container(
                      width: kWidth / 2,
                      margin: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8.0),
                      child: Text(
                        LocalStorage.isIta()
                            ? newsToView.sottotitolo
                            : newsToView.sottotitoloEn,
                        style: const TextStyle(
                          fontSize: 13.0,
                          color: kBlack,
                          height: 1,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),*/
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

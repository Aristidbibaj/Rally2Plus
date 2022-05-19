import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rally2plus/controls/database_services.dart';
import 'package:rally2plus/controls/local_storage.dart';
import 'package:rally2plus/controls/ui.dart';
import 'package:rally2plus/models/contacts.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactsScreen extends StatelessWidget {
  late Contacts contacts;
  List<String> developers = [];
  List<String> collaborators = [];
  DatabaseService databaseService = DatabaseService();
  final Uri _url = Uri.parse('https://www.instagram.com/wrc_tv_italy/');

  ContactsScreen(cont) {
    LocalStorage.init();
    contacts = cont;
  }

  void _launchUrl() async {
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }

  @override
  Widget build(BuildContext context) {
    developers = contacts.developers.split('\n');
    collaborators = contacts.collaborators.split('\n');
    return Scaffold(
      backgroundColor: kBlack,
      appBar: AppBar(
        elevation: 0.0,
        toolbarHeight: 65.0,
        centerTitle: true,
        actions: [Container()],
        title: Container(),
        backgroundColor: kBlack,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 0.5,
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 50.0),
              child:
                  Image.asset('images/rallytwoplus.png', fit: BoxFit.contain),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 16.0),
              child: OutlineButton(
                borderSide:
                    BorderSide(color: kRed, style: BorderStyle.solid, width: 1),
                onPressed: _launchUrl,
                child: Row(
                  children: const [
                    Expanded(
                        flex: 1,
                        child: Icon(
                          FontAwesomeIcons.instagram,
                          size: 40.0,
                          color: kRed,
                        )),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      flex: 5,
                      child: Text(
                        '@rally2plus',
                        style: TextStyle(
                            color: kRed,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            for (String str in developers)
              Padding(
                padding: developers.indexOf(str) % 3 == 2
                    ? const EdgeInsets.only(bottom: 10.0)
                    : EdgeInsets.zero,
                child: Text(
                  str,
                  textAlign: TextAlign.center,
                  style: getStyle(developers.indexOf(str)),
                  maxLines: 2,
                ),
              ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              LocalStorage.isIta() ? 'COLLABORATORI' : 'COLLABORATORS',
              textAlign: TextAlign.center,
              style: GoogleFonts.openSansCondensed(
                fontSize: 22.0,
                color: kWhite,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80.0),
              child: Divider(
                height: 10.0,
                thickness: 1.0,
                color: kRed,
              ),
            ),
            for (String str in collaborators)
              Padding(
                padding: collaborators.indexOf(str) % 3 == 2
                    ? const EdgeInsets.only(bottom: 10.0)
                    : EdgeInsets.zero,
                child: Text(
                  str,
                  textAlign: TextAlign.center,
                  style: getStyleCollaboratori(collaborators.indexOf(str)),
                ),
              ),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  TextStyle getStyle(int index) {
    if (index % 3 == 0)
      return GoogleFonts.openSansCondensed(
        fontSize: 34.0,
        color: kWhite,
        fontWeight: FontWeight.bold,
      );

    if (index % 3 == 1)
      return GoogleFonts.openSansCondensed(
        fontSize: 18.0,
        color: kWhite,
        fontWeight: FontWeight.w400,
      );

    if (index % 3 == 2)
      return GoogleFonts.openSansCondensed(
        fontSize: 24.0,
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      );
    return GoogleFonts.openSansCondensed(
      fontSize: 18.0,
      color: kWhite,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle getStyleCollaboratori(int index) {
    if (index % 3 == 0)
      return GoogleFonts.openSansCondensed(
        fontSize: 22.0,
        color: kWhite,
        fontWeight: FontWeight.bold,
      );

    if (index % 3 == 1)
      return GoogleFonts.openSansCondensed(
        fontSize: 12.0,
        color: kWhite,
        fontWeight: FontWeight.w400,
      );

    if (index % 3 == 2)
      return GoogleFonts.openSansCondensed(
        fontSize: 16.0,
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      );

    return GoogleFonts.openSansCondensed(
      fontSize: 12.0,
      color: kWhite,
      fontWeight: FontWeight.w400,
    );
  }
}

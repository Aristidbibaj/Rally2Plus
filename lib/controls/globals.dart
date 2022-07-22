const KRally2Plus = 'Rally 2 Plus';

const kSettings = {'it': 'Impostazioni', 'en': 'Settings'};

const kLanguage = {'it': 'Lingua', 'en': 'Language'};

const kContentWaiting = {
  'it': 'In attesa di aggiungere contenuti!',
  'en': 'Waiting to add content!'
};

const kYear = {'it': 'Anno', 'en': 'Year'};

const kMonth = {'it': 'Mese', 'en': 'Month'};

const kReadMore = {'it': 'Leggi anche..', 'en': 'Read more..'};

const kMedia = 'Media';

const kContacts = {'it': 'Contatti', 'en': 'Contacts'};

const kSearch = {'it': 'Cerca', 'en': 'Search'};

const kLastNews = {'it': 'Ultime notizie', 'en': 'Last news'};

const kAllMonths = [
  {'it': 'GEN', 'en': 'JAN'},
  {'it': 'FEB', 'en': 'FEB'},
  {'it': 'MAR', 'en': 'MAR'},
  {'it': 'APR', 'en': 'APR'},
  {'it': 'MAG', 'en': 'MAY'},
  {'it': 'GIU', 'en': 'JUN'},
  {'it': 'LUG', 'en': 'JUL'},
  {'it': 'AGO', 'en': 'AUG'},
  {'it': 'SET', 'en': 'SEP'},
  {'it': 'OTT', 'en': 'OCT'},
  {'it': 'NOV', 'en': 'NOV'},
  {'it': 'DIC', 'en': 'DEC'}
];

const kBottomNavBarName = [
  {'it': 'Home', 'en': 'Home'},
  {'it': 'Originali', 'en': 'Originals'},
  {'it': 'Bernacca', 'en': 'Bernacca'},
];

const kContactsDefault = {
  "collaborators":
      "Marco Racing\n(photographer)\nhttps://www.instagram.com/marco_racing_/\nNicola Scognamillo\n(photographer)\nhttps://www.instagram.com/nicola_scognamillo/\nLucas Martineza\n(photographer)\nhttps://www.instagram.com/lucasmartineza/",
  "rally2plus_web_link": "https://www.instagram.com/wrc_tv_italy/",
  "developers":
      "Andrea Gambardella\n(owner/creator)\nandre.gamba.95@gmail.com\nAristid Bibaj\n(Full-stack developer)\naristid.bibaj@gmail.com\nGiovanni Bernacchini\n(collaborator)\nhttps://www.instagram.com/bernacchinigiovanni/"
};

const kHomeCategoryDefault = {
  "base": [
    {
      "img":
          "https://firebasestorage.googleapis.com/v0/b/rally2plus-ab17892.appspot.com/o/home%2F0.jpeg?alt=media&token=1e1f4d9a-c5ca-4720-a378-3d27b49f80ef",
      "name": {"en": "wrc", "it": "wrc"}
    },
    {
      "img":
          "https://firebasestorage.googleapis.com/v0/b/rally2plus-ab17892.appspot.com/o/home%2F1.jpeg?alt=media&token=69cd0e4c-8c5d-4188-a0fb-eb596c7a6e80",
      "name": {"en": "wrc2", "it": "wrc2"}
    },
    {
      "img":
          "https://firebasestorage.googleapis.com/v0/b/rally2plus-ab17892.appspot.com/o/home%2F2.png?alt=media&token=89ed00f5-1770-4662-9fe9-ff0ff336544a",
      "name": {"en": "standings", "it": "classifiche"}
    },
    {
      "img":
          "https://firebasestorage.googleapis.com/v0/b/rally2plus-ab17892.appspot.com/o/home%2Fbernacca.jpg?alt=media&token=fa68ad0e-36ae-40f5-afea-96f73c693903",
      "name": {"en": "bernacca", "it": "bernacca"}
    },
    {
      "img":
          "https://firebasestorage.googleapis.com/v0/b/rally2plus-ab17892.appspot.com/o/home%2F4.png?alt=media&token=be6a88eb-91a7-4b2f-a6fb-98f32e134a30",
      "name": {"en": "originals", "it": "originali"}
    },
    {
      "img":
          "https://firebasestorage.googleapis.com/v0/b/rally2plus-ab17892.appspot.com/o/home%2F5.jpeg?alt=media&token=5738d54e-09f3-4a6f-9c3a-074a59b7f132",
      "name": {"en": "work with us", "it": "lavora con noi"}
    },
    {
      "img":
          "https://firebasestorage.googleapis.com/v0/b/rally2plus-ab17892.appspot.com/o/home%2F6.jpeg?alt=media&token=305ccf87-5e63-4752-bdc4-ff65eda73f52",
      "name": {"en": "social", "it": "social"}
    }
  ],
  "hidden": [
    {
      "img":
          "https://firebasestorage.googleapis.com/v0/b/rally2plus-ab17892.appspot.com/o/home%2F0.jpeg?alt=media&token=1e1f4d9a-c5ca-4720-a378-3d27b49f80ef",
      "name": {"en": "wrc", "it": "wrc"},
      "visible": false
    },
    {
      "img":
          "https://firebasestorage.googleapis.com/v0/b/rally2plus-ab17892.appspot.com/o/home%2F1.jpeg?alt=media&token=69cd0e4c-8c5d-4188-a0fb-eb596c7a6e80",
      "name": {"en": "wrc2", "it": "wrc2"},
      "visible": false
    },
    {
      "img":
          "https://firebasestorage.googleapis.com/v0/b/rally2plus-ab17892.appspot.com/o/home%2F2.png?alt=media&token=89ed00f5-1770-4662-9fe9-ff0ff336544a",
      "name": {"en": "standings", "it": "classifiche"},
      "visible": false
    },
    {
      "img":
          "https://firebasestorage.googleapis.com/v0/b/rally2plus-ab17892.appspot.com/o/home%2Fbernacca.jpg?alt=media&token=fa68ad0e-36ae-40f5-afea-96f73c693903",
      "name": {"en": "bernacca", "it": "bernacca"},
      "visible": false
    },
    {
      "img":
          "https://firebasestorage.googleapis.com/v0/b/rally2plus-ab17892.appspot.com/o/home%2F4.png?alt=media&token=be6a88eb-91a7-4b2f-a6fb-98f32e134a30",
      "name": {"en": "originals", "it": "originali"},
      "visible": false
    },
    {
      "img":
          "https://firebasestorage.googleapis.com/v0/b/rally2plus-ab17892.appspot.com/o/home%2F5.jpeg?alt=media&token=5738d54e-09f3-4a6f-9c3a-074a59b7f132",
      "name": {"en": "work with us", "it": "lavora con noi"},
      "visible": false
    },
    {
      "img":
          "https://firebasestorage.googleapis.com/v0/b/rally2plus-ab17892.appspot.com/o/home%2F6.jpeg?alt=media&token=305ccf87-5e63-4752-bdc4-ff65eda73f52",
      "name": {"en": "social", "it": "social"},
      "visible": false
    }
  ]
};

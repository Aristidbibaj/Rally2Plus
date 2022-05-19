class Originals {
  late String flag;
  late String category;
  late String datetime;
  late String source;
  late bool is_video_from_link;
  late int id;
  late String title_img;
  late Map<String, dynamic> subtitle;
  late Map<String, dynamic> tag;
  late Map<String, dynamic> text;
  late Map<String, dynamic> title;
  late String media_link;
  late bool is_multi_img;
  late List<String> multi_imgs_link;

  Originals({
    required this.flag,
    required this.category,
    required this.datetime,
    required this.source,
    required this.is_video_from_link,
    required this.id,
    required this.title_img,
    required this.subtitle,
    required this.tag,
    required this.text,
    required this.title,
    required this.media_link,
    required this.is_multi_img,
    required this.multi_imgs_link,
  });

  factory Originals.fromRTDB(Map<String, dynamic> json) {
    return Originals(
        flag: json['flag'],
        category: json['category'],
        datetime: json['datetime'],
        source: json['source'],
        is_video_from_link: json['is_video_from_link'],
        id: json['id'],
        title_img: json['title_img'],
        subtitle: Map.from(json['subtitle']),
        tag: Map.from(json['tag']),
        text: Map.from(json['text']),
        title: Map.from(json['title']),
        media_link: json['media_link'],
        is_multi_img: json['is_multi_img'],
        multi_imgs_link: json['multi_imgs_link'].cast<String>());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> temp_news = <String, dynamic>{};
    temp_news['flag'] = flag;
    temp_news['category'] = category;
    temp_news['datetime'] = datetime;
    temp_news['source'] = source;
    temp_news['is_video_from_link'] = is_video_from_link;
    temp_news['id'] = id;
    temp_news['title_img'] = title_img;
    temp_news['subtitle'] = subtitle;
    temp_news['tag'] = tag;
    temp_news['text'] = text;
    temp_news['title'] = title;
    temp_news['media_link'] = media_link;
    temp_news['is_multi_img'] = is_multi_img;
    temp_news['multi_imgs_link'] = multi_imgs_link;
    return temp_news;
  }

  bool containQuotedText() {
    if ((text['en']).contains('&&')) return true;
    return false;
  }

  int getYear() {
    return int.parse((datetime).split(' ')[0].split('-')[0]);
  }

  int getMonth() {
    return int.parse((datetime).split(' ')[0].split('-')[1]);
  }

  //return 3 strings, strings[1] is quoted text
  List<String> getFormattedQuotedText({required String language}) {
    return text[language].toString().split('&&');
  }

  @override
  String toString() {
    return 'News: $id\nDate:$datetime\nFlag:$flag\n';
  }
}

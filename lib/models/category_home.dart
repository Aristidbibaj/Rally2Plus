import 'package:firebase_database/firebase_database.dart';

class HomeCategory {
  late Map<String, String> name;
  late String img;

  HomeCategory({
    required this.name,
    required this.img,
  });

  factory HomeCategory.fromRTDB(Map<String, dynamic> json) {
    return HomeCategory(
      name: Map<String, String>.from(json['name']),
      img: json['img'],
    );
  }

  HomeCategory.fromDataSnapshot(DataSnapshot snapshot) {
    (snapshot as Map<dynamic, dynamic>).forEach((key, value) {
      name = Map<String, String>.from(value['name']);
      img = value['img'];
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['img'] = img;
    return data;
  }
}

class HomeCategoryHidden {
  late Map<String, String> name;
  late String img;
  late bool visible;

  HomeCategoryHidden({
    required this.name,
    required this.img,
    required this.visible,
  });

  factory HomeCategoryHidden.fromRTDB(Map<String, dynamic> json) {
    return HomeCategoryHidden(
        name: Map<String, String>.from(json['name']),
        img: json['img'],
        visible: json['visible']);
  }

  HomeCategoryHidden.fromDataSnapshot(DataSnapshot snapshot) {
    (snapshot as Map<dynamic, dynamic>).forEach((key, value) {
      name = Map<String, String>.from(value['name']);
      img = value['img'];
      visible = value['visible'];
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['img'] = img;
    data['visible'] = visible;
    return data;
  }
}

import 'dart:ui' as ui;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:news_paper/model/notice.dart';
import 'package:news_paper/newspaper/base.dart';

class Section with ChangeNotifier {
  final String id;
  final String name;
  final String url;
  bool enable = true;

  Section({this.id, this.name, this.url});

  toggleEnable() {
    enable = !enable;
    notifyListeners();
  }

  disable() {
    enable = false;
    notifyListeners();
  }
}

class ProviderNotices with ChangeNotifier {
  NewspaperBase newspaperBase;
  Map<String, Notice> _notices;

  List<Notice> get notices => _notices != null ? [..._notices.values.toList()] : null;

  ProviderNotices(NewspaperBase newspaperBase) {
    this.newspaperBase = newspaperBase;
  }

  synchronize({bool force}) async {
    var box = await Hive.openBox(this.newspaperBase.baseName);
    if (force ?? false) {
      await box.clear();
    }
    if (force ?? false || await newspaperBase.makeFetch() || box.isEmpty) {
      var list = await newspaperBase.synchronizeNotices();
      for (var value in list) {
        await box.put(value.url, value);
      }
    }

    _notices = Map<String, Notice>.from(box.toMap());

    final temp = {..._notices};

    final sortedKeys = temp.keys.toList(growable: false)
      ..sort((k1, k2) => temp[k2].dateForOrder.compareTo(temp[k1].dateForOrder));
    _notices = Map.fromIterable(sortedKeys, key: (k) => k, value: (k) => temp[k]);
    _notices.values.forEach((element) => element.newspaperBase = newspaperBase);

    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:news_paper/base.dart';

class Notice with ChangeNotifier {
  final String id;
  final String title;
  final String section;
  final String summary;
  final String imageUrl;
  final String url;

  Notice({this.section, this.id, this.url, this.title, this.summary, this.imageUrl});
}

class ProviderNotices with ChangeNotifier {
  NewspaperBase newspaperBase;
  List<Notice> _notices;

  List<Notice> get notices => _notices != null ? [..._notices] : null;

  ProviderNotices(NewspaperBase newspaperBase) {
    this.newspaperBase = newspaperBase;
  }

  synchronize(BuildContext context) async {
    _notices = await newspaperBase.synchronizeNotices();
    notifyListeners();
  }
}

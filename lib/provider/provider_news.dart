import 'package:flutter/material.dart';
import 'package:news_paper/newspaper/base.dart';

class Notice with ChangeNotifier {
  final String id;
  final String title;
  final String section;
  final String summary;
  final String imageUrl;
  final String url;
  NewspaperBase newspaperBase;
  String html;

  Notice(
      {this.section,
      this.id,
      this.url,
      this.html,
      this.title,
      this.newspaperBase,
      this.summary,
      this.imageUrl});

  synchronize(BuildContext context) async {
    Notice data = await newspaperBase.fetchNoticeData(url);
    this.html = data?.html;
    notifyListeners();
  }
}

class Section with ChangeNotifier {
  final String id;
  final String name;
  final String url;

  Section({this.id, this.name, this.url});
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

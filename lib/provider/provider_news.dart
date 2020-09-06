import 'dart:ui' as ui;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:news_paper/newspaper/base.dart';

class Notice with ChangeNotifier {
  final String id;
  final String title;
  final String section;
  final String summary;
  final String date;
  final String url;
  String imageUrl;
  NewspaperBase newspaperBase;
  String html;
  double _textScaleFactor;

  double get textScaleFactor => _textScaleFactor ?? 1.0;

  Notice({this.section,
    this.id,
    this.url,
    this.date,
    this.html,
    this.title,
    this.newspaperBase,
    this.summary,
    this.imageUrl});

  synchronize(BuildContext context) async {
    Notice data = await newspaperBase.fetchNoticeData(url);
    this.html = data?.html;
    this._textScaleFactor = _textScaleFactor ?? MediaQuery
        .of(context)
        .textScaleFactor;
    notifyListeners();
  }

  setNoticeImage(String imageUrl) async {
    if (this.imageUrl == null) {
      this.imageUrl = imageUrl;
      notifyListeners();
    } else {
      final actualSize = await _calculateImageDimension(this.imageUrl);
      final newSize = await _calculateImageDimension(imageUrl);

      if (actualSize.width < newSize.width || actualSize.height < newSize.height) {
        this.imageUrl = imageUrl;
        notifyListeners();
      }
    }
  }

  changeTextScaleFactor(double newScale) {
    this._textScaleFactor = newScale;
    notifyListeners();
  }

  Future<Size> _calculateImageDimension(String url) {
    Completer<Size> completer = Completer();
    Image image = Image.network(url);
    image.image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener(
            (ImageInfo image, bool synchronousCall) {
          var myImage = image.image;
          Size size = Size(myImage.width.toDouble(), myImage.height.toDouble());
          completer.complete(size);
        },
      ),
    );
    return completer.future;
  }
}

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
  List<Notice> _notices;

  List<Notice> get notices => _notices != null ? [..._notices] : null;

  ProviderNotices(NewspaperBase newspaperBase) {
    this.newspaperBase = newspaperBase;
  }

  synchronize({bool useCache}) async {
    _notices = await newspaperBase.synchronizeNotices(cache: useCache);
    newspaperBase.sections.forEach((section) => section.enable = true);
    notifyListeners();
  }

  disableAllSections() {
    newspaperBase.sections.forEach((section) => section.disable());
  }
}

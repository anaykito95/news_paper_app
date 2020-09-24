import 'dart:ui' as ui;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:news_paper/newspaper/base.dart';

part 'notice.g.dart';

@HiveType(typeId: 0)
class Notice extends HiveObject with ChangeNotifier{
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String section;
  @HiveField(3)
  final String summary;
  @HiveField(4)
  final String date;
  @HiveField(5)
  final String url;
  @HiveField(6)
  String imageUrl;
  @HiveField(7)
  String html;
  @HiveField(8)
  final String base;
  @HiveField(9)
  double _textScaleFactor;
  @HiveField(10)
  final int dateForOrder;

  NewspaperBase newspaperBase;

  double get textScaleFactor => _textScaleFactor ?? 1.0;

  Notice({this.section,
    this.id,
    this.url,
    this.date,
    this.html,
    this.title,
    this.base,
    this.dateForOrder,
    this.newspaperBase,
    this.summary,
    this.imageUrl});

  synchronize(BuildContext context) async {
    if (this.html == null) {
      this.html = await newspaperBase.fetchNoticeData(url);
      var box = await Hive.openBox(this.newspaperBase.baseName);
      box.put(this.url, this);
      this._textScaleFactor = _textScaleFactor ?? MediaQuery
          .of(context)
          .textScaleFactor;
      notifyListeners();
    }
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
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:news_paper/newspaper/base.dart';
import 'package:news_paper/provider/provider_news.dart';

class Bohemia extends NewspaperBase {
  @override
  String get assetBannerName => 'granma-logo.png';

  String get assetIconName => 'bohemia-icon.jpg';

  @override
  String get baseUrl => 'http://bohemia.cu/';

  @override
  Color get color => Colors.white;

  @override
  Color get bannerColor => Colors.white;

  @override
  Color get actionColor => Color(0xff104469);

  @override
  String get title => 'Revista Bohemia';

  @override
  List<Section> get sections => [
//    Section(name: 'Cuba', url: '$baseUrl/cuba', id: '$baseUrl/cuba'),
//    Section(name: 'Mundo', url: '$baseUrl/mundo', id: '$baseUrl/inter'),
//    Section(name: 'Deportes', url: '$baseUrl/deportes', id: '$baseUrl/deportes'),
//    Section(name: 'Cultura', url: '$baseUrl/cultura', id: '$baseUrl/cultura'),
//    Section(name: 'Opinión', url: '$baseUrl/opinion', id: '$baseUrl/opinion'),
//    Section(name: 'Ciencia', url: '$baseUrl/ciencia-tecnica', id: '$baseUrl/ciencia'),
//    Section(name: 'Salud', url: '$baseUrl/salud', id: '$baseUrl/salud')
  ];

  @override
  Future<Notice> parseSingleNotice(dom.Document document) async {
    try {
      final notice = Notice(html: document.getElementsByClassName('review-content')?.first?.outerHtml);
      return notice;
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  String get rssUrl => 'http://www.bohemia.cu/feed';
}
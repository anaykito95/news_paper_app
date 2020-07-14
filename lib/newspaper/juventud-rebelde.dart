import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:news_paper/newspaper/base.dart';
import 'package:news_paper/provider/provider_news.dart';

class JuventudRebelde extends NewspaperBase {
  @override
  String get assetBannerName => 'jr-logo.png';

  @override
  String get assetIconName => 'jr-icon.jpg';

  @override
  String get baseUrl => 'http://www.juventudrebelde.cu';

  @override
  Color get color => Colors.blue;

  @override
  Color get bannerColor => Colors.blue;

  @override
  Color get actionColor => Colors.white;

  @override
  String get title => 'Juventud Rebelde';

  @override
  Future<List<Notice>> parseNewsFromDocument(dom.Document document) async {
    List<Notice> result = [];
    try {
      final elements = document.getElementsByClassName('item-news');
      elements.forEach((element) {
        try {
          var tagImg = element.getElementsByTagName('img');
          var tagA = element.getElementsByTagName('a');
          final notice = Notice(
              section: element.getElementsByClassName('section')[1].text,
              newspaperBase: this,
              url: tagA.isNotEmpty ? tagA[0]?.attributes['href'] : null,
              title: tagA.isNotEmpty ? tagA[0]?.getElementsByClassName('title')[0]?.text : null,
              summary: element.getElementsByClassName('sumary')[0].text,
              imageUrl: tagImg.isNotEmpty ? tagImg[0]?.attributes['src'] : null);
          result.add(notice);
        } catch (e) {
          print(e);
        }
      });
    } catch (e) {
      print(e);
    }
    return result;
  }

  @override
  Future<Notice> parseSingleNotice(dom.Document document) async {
    try {
      final notice =
      Notice(html: document.getElementsByClassName('news-content')?.first?.outerHtml);
      return notice;
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  List<Section> get sections => [
    Section(name: 'Cuba', url: '$baseUrl/cuba', id: '$baseUrl/cuba'),
    Section(name: 'Internacionales', url: '$baseUrl/internacionales', id: '$baseUrl/inter'),
    Section(name: 'Ciencia y Técnica', url: '$baseUrl/ciencia-tecnica', id: '$baseUrl/ciencia'),
    Section(name: 'Opinión', url: '$baseUrl/opinion', id: '$baseUrl/opinion'),
    Section(name: 'Cultura', url: '$baseUrl/cultura', id: '$baseUrl/cultura'),
    Section(name: 'Deporte', url: '$baseUrl/deporte', id: '$baseUrl/deporte'),
    Section(name: 'Cultura', url: '$baseUrl/cultura', id: '$baseUrl/cultura'),
    Section(name: 'Suplementos', url: '$baseUrl/suplementos', id: '$baseUrl/suplementos')
  ];
}
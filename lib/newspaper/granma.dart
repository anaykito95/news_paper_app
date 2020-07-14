import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:news_paper/newspaper/base.dart';
import 'package:news_paper/provider/provider_news.dart';

class Granma extends NewspaperBase {
  @override
  String get assetBannerName => 'granma-logo.png';

  String get assetIconName => 'granma-icon.jpg';

  @override
  String get baseUrl => 'http://www.granma.cu';

  @override
  Color get color => Colors.white;

  @override
  Color get bannerColor => Colors.white;

  @override
  Color get actionColor => Color(0xffE20612);

  @override
  String get title => 'Granma';

  @override
  List<Section> get sections => [
    Section(name: 'Cuba', url: '$baseUrl/cuba', id: '$baseUrl/cuba'),
    Section(name: 'Mundo', url: '$baseUrl/mundo', id: '$baseUrl/inter'),
    Section(name: 'Deportes', url: '$baseUrl/deportes', id: '$baseUrl/deportes'),
    Section(name: 'Cultura', url: '$baseUrl/cultura', id: '$baseUrl/cultura'),
    Section(name: 'Opinión', url: '$baseUrl/opinion', id: '$baseUrl/opinion'),
    Section(name: 'Ciencia', url: '$baseUrl/ciencia-tecnica', id: '$baseUrl/ciencia'),
    Section(name: 'Salud', url: '$baseUrl/salud', id: '$baseUrl/salud')
  ];

  @override
  Future<List<Notice>> parseNewsFromDocument(dom.Document document) async {
    List<Notice> result = [];
    try {
      final elements = document.getElementsByTagName('article');
      elements.forEach((element) {
        try {
          var tagImg = element.getElementsByTagName('img');
          var tagA = element.getElementsByTagName('a');
          var tagP = element.getElementsByTagName('p');
          final notice = Notice(
              url: tagA.isNotEmpty ? '$baseUrl/${tagA[0]?.attributes['href']}' : null,
              title: tagA.isNotEmpty ? tagA[0]?.text : null,
              newspaperBase: this,
              summary: tagP.isNotEmpty ? tagP[0]?.text : null,
              imageUrl: tagImg.isNotEmpty && tagImg[0]?.attributes['src'] != null
                  ? '$baseUrl${tagImg[0]?.attributes['src']}'
                  : null);
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
      final notice = Notice(html: document.getElementsByClassName('g-story')?.first?.outerHtml);
      return notice;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
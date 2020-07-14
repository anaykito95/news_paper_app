import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:news_paper/newspaper/base.dart';
import 'package:news_paper/provider/provider_news.dart';

class Tribuna extends NewspaperBase {
  @override
  String get assetBannerName => 'tribuna-logo.png';

  @override
  String get assetIconName => 'tribuna-icon.jpg';

  @override
  String get baseUrl => 'http://www.tribuna.cu';

  @override
  Color get color => Color(0xffFFFFFF);

  @override
  Color get bannerColor => Colors.white;

  @override
  Color get actionColor => Colors.black87;

  @override
  String get title => 'Tribuna de la Habana';

  @override
  Future<List<Notice>> parseNewsFromDocument(dom.Document document) async {
    List<Notice> result = [];
    try {
      final elements = document.getElementsByTagName('article');
      elements.forEach((element) {
        try {
          final notice = Notice(
            url: element.getElementsByClassName('post-thumbnail')?.first?.attributes['href'],
            title: element.getElementsByTagName('h2')?.first?.text ?? '',
            newspaperBase: this,
//            summary: element.getElementsByTagName('p')?.first?.text,
            imageUrl: element
                .getElementsByClassName('post-thumbnail')
                ?.first
                ?.getElementsByTagName('img')
                ?.first
                ?.attributes['data-src'],
          );
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
          Notice(html: document.getElementsByTagName('article')?.first?.outerHtml);
      return notice;
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  List<Section> get sections => [
        Section(name: 'Cuba', url: '$baseUrl/cuba/', id: '$baseUrl/cuba'),
        Section(name: 'Mundo', url: '$baseUrl/mundo/', id: '$baseUrl/inter'),
        Section(name: 'Buzón', url: '$baseUrl/buzon-abierto/', id: '$baseUrl/ciencia'),
        Section(name: 'Opinión', url: '$baseUrl/opinion/', id: '$baseUrl/opinion'),
        Section(name: 'Deportes', url: '$baseUrl/deportes/', id: '$baseUrl/deporte'),
        Section(name: 'Cultura', url: '$baseUrl/cultura/', id: '$baseUrl/cultura'),
        Section(name: 'Salud', url: '$baseUrl/salud', id: '$baseUrl/suplementos'),
        Section(name: 'Historia', url: '$baseUrl/memoria-historica', id: '$baseUrl/history')
      ];
}

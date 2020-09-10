import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:news_paper/newspaper/base.dart';
import 'package:news_paper/provider/provider_news.dart';

class Cubadebate extends NewspaperBase {
  @override
  String get assetBannerName => 'tribuna-logo.png';

  @override
  String get assetIconName => 'cubadebate-icon.jpg';

  @override
  String get baseUrl => 'http://www.cubadebate.cu';

  @override
  Color get color => Color(0xffFFFFFF);

  @override
  Color get bannerColor => Colors.white;

  @override
  Color get actionColor => Color(0xffEC2127);

  @override
  String get title => 'Cubadebate';

  @override
  String get baseName => 'cubadebate';

  @override
  List<Section> get sections => [
//        Section(name: 'Cuba', url: '$baseUrl/cuba/', id: '$baseUrl/cuba'),
//        Section(name: 'Mundo', url: '$baseUrl/mundo/', id: '$baseUrl/inter'),
//        Section(name: 'Buzón', url: '$baseUrl/buzon-abierto/', id: '$baseUrl/ciencia'),
//        Section(name: 'Opinión', url: '$baseUrl/opinion/', id: '$baseUrl/opinion'),
//        Section(name: 'Deportes', url: '$baseUrl/deportes/', id: '$baseUrl/deporte'),
//        Section(name: 'Cultura', url: '$baseUrl/cultura/', id: '$baseUrl/cultura'),
//        Section(name: 'Salud', url: '$baseUrl/salud', id: '$baseUrl/suplementos'),
//        Section(name: 'Historia', url: '$baseUrl/memoria-historica', id: '$baseUrl/history')
      ];

  @override
  String get rssUrl => 'http://www.cubadebate.cu/feed/';

  @override
  String get htmlClassNoticeData => 'note_content';
}

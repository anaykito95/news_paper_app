import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:news_paper/newspaper/base.dart';
import 'package:news_paper/provider/provider_news.dart';

class Trabajadores extends NewspaperBase {
  @override
  String get assetBannerName => 'tr-logo.png';

  @override
  String get assetIconName => 'tr-icon.jpg';

  @override
  String get baseUrl => 'http://www.trabajadores.cu';

  @override
  Color get color => Color(0xffF17B00);

  @override
  Color get bannerColor => Color(0xffF17B00);

  @override
  Color get actionColor => Colors.white;

  @override
  String get title => 'Trabajadores';

  @override
  String get baseName => 'trabajadores';

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

  @override
  String get rssUrl => 'http://www.trabajadores.cu/feed/';

  @override
  String get htmlClassNoticeData => 'entry-content';
}

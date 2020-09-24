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
  Color get color => Color(0xff009DDE);

  @override
  Color get bannerColor => Color(0xff009DDE);

  @override
  Color get actionColor => Colors.white;

  @override
  String get title => 'Juventud Rebelde';

  @override
  String get baseName => 'juventud';

  @override
  List<Section> get sections => [
    Section(name: 'Cuba', url: '$baseUrl/cuba', id: '$baseUrl/cuba'),
    Section(name: 'Internacionales', url: '$baseUrl/internacionales', id: '$baseUrl/inter'),
    Section(name: 'Ciencia y Técnica', url: '$baseUrl/ciencia-tecnica', id: '$baseUrl/ciencia'),
    Section(name: 'Cultura', url: '$baseUrl/cultura', id: '$baseUrl/cultura'),
    Section(name: 'Deporte', url: '$baseUrl/deportes', id: '$baseUrl/deportes'),
  ];

  @override
  String get rssUrl => 'http://www.juventudrebelde.cu/get/rss/grupo/generales';

  @override
  String get htmlClassNoticeData => 'article';
}
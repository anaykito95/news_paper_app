import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:news_paper/newspaper/base.dart';
import 'package:news_paper/provider/provider_news.dart';

class Acn extends NewspaperBase {
  @override
  String get assetBannerName => 'granma-logo.png';

  String get assetIconName => 'acn-icon.jpg';

  @override
  String get baseUrl => 'http://www.acn.cu';

  @override
  Color get color => Colors.white;

  @override
  Color get bannerColor => Colors.white;

  @override
  Color get actionColor => Color(0xff1C7FE5);

  @override
  String get title => 'Agencia Cubana de Noticias';

  @override
  String get baseName => 'acn';

  @override
  List<Section> get sections => [
  ];

  @override
  String get rssUrl => 'http://www.acn.cu/?format=feed&type=rss';

  @override
  String get htmlClassNoticeData => 'article-full';
}
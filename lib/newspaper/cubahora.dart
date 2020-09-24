import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:news_paper/newspaper/base.dart';
import 'package:news_paper/provider/provider_news.dart';

class Cubahora extends NewspaperBase {
  @override
  String get assetBannerName => 'granma-logo.png';

  String get assetIconName => 'cubahora-icon.png';

  @override
  String get baseUrl => 'http://www.cubahora.cu';

  @override
  Color get color => Colors.white;

  @override
  Color get bannerColor => Colors.white;

  @override
  Color get actionColor => Color(0xff75A836);

  @override
  String get title => 'Cubahora';

  @override
  String get baseName => 'cubahora';

  @override
  List<Section> get sections => [
  ];

  @override
  String get rssUrl => 'https://www.cubahora.cu/feed';

  @override
  String get htmlClassNoticeData => 'article';
}
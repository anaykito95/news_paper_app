import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:news_paper/provider/provider_news.dart';

abstract class NewspaperBase {
  Color get color;

  Color get bannerColor;

  Color get actionColor;

  String get assetBannerName;

  String get assetIconName;

  String get baseUrl;

  String get title;

  List<Section> get sections;

  final Map<String, List<Notice>> _cache = Map();

  Future<List<Notice>> synchronizeNotices() async {
    if (_cache.containsKey(baseUrl) && _cache[baseUrl].isNotEmpty) {
      return _cache[baseUrl];
    }
    List<Notice> list = [];
    try {
      http.Response response = await http.get(baseUrl);
      dom.Document document = parser.parse(response.body);
      list = await parseNewsFromDocument(document);
      if (list.isNotEmpty) {
        _cache.putIfAbsent(baseUrl, () => list);
      }
    } catch (e) {
      print(e);
    }
    return list;
  }

  Future<Notice> fetchNoticeData(String url) async {
    try {
      http.Response response = await http.get(url);
      dom.Document document = parser.parse(response.body);
      return await parseSingleNotice(document);
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<Notice>> parseNewsFromDocument(dom.Document document);

  Future<Notice> parseSingleNotice(dom.Document document);
}



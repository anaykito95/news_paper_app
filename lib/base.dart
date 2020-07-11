import 'package:flutter/material.dart';
import 'package:news_paper/provider/provider_news.dart';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;

abstract class NewspaperBase {
  Color get color;

  String get assetImageName;

  String get baseUrl;

  String get title;

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

  Future<List<Notice>> parseNewsFromDocument(dom.Document document);
}

class JuventudRebelde extends NewspaperBase {
  @override
  String get assetImageName => 'juventud_rebelde.png';

  @override
  String get baseUrl => 'http://www.juventudrebelde.cu';

  @override
  Color get color => Colors.blue;

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
}

class Granma extends NewspaperBase {
  @override
  String get assetImageName => 'granma-logo.png';

  @override
  String get baseUrl => 'http://www.granma.cu';

  @override
  Color get color => Colors.white;

  @override
  String get title => 'Granma';

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
              url: tagA.isNotEmpty ? tagA[0]?.attributes['href'] : null,
              title: tagA.isNotEmpty ? tagA[0]?.text : null,
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
}

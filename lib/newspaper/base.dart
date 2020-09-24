import 'dart:convert' show utf8;
import 'package:dart_rss/domain/atom_feed.dart';
import 'package:dart_rss/domain/rss1_feed.dart';
import 'package:dart_rss/domain/rss_feed.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:news_paper/model/notice.dart';
import 'package:news_paper/provider/provider_news.dart';

abstract class NewspaperBase {
  Color get color;

  Color get bannerColor;

  Color get actionColor;

  String get assetBannerName;

  String get assetIconName;

  String get baseUrl;

  String get rssUrl;

  String get title;

  String get baseName;

  String get htmlClassNoticeData;

  List<Section> get sections;

  Future<List<Notice>> synchronizeNotices({String url}) async {
    List<Notice> list = [];
    try {
      list = await _readRSS();
    } catch (e) {
      print(e);
    }
    return list;
  }

  Future<bool> makeFetch() async {
    final appBox = await Hive.openBox('app');
    final actual = DateTime.now().millisecondsSinceEpoch;
    final int last = appBox.get('time-$baseName', defaultValue: actual);
    return actual - last > Duration(hours: 1).inMilliseconds;
  }

  _saveFetchTime() async {
    final appBox = await Hive.openBox('app');
    final actual = DateTime.now().millisecondsSinceEpoch;
    appBox.put('time-$baseName', actual);
  }

  Future<List<Notice>> _readRSS() async {
    final response = await http.get(rssUrl);
    List<Notice> list = [];
    if (response.statusCode == 200) {
      try {
        final result = RssFeed.parse(response.body);
        if (result != null) {
          _saveFetchTime();
          list = result.items
              .map((e) => Notice(
                    title: _cleanString(e.title),
                    id: e.guid?.replaceAll("\n", ""),
                    url: e.link?.replaceAll("\n", ""),
                    date: _getDateTimeHora(e.pubDate?.replaceAll("\n", "")),
                    dateForOrder:
                        getDateTime(e.pubDate?.replaceAll("\n", "")).millisecondsSinceEpoch,
                    newspaperBase: this,
//            section: e.categories?.
                    summary: _cleanString(e.description),
                  ))
              .toList();
          return list;
        }
      } catch (e) {}
      try {
        final result = AtomFeed.parse(response.body); // for parsing Atom feed
        if (result != null) {
          _saveFetchTime();
          list = result.items
              .map((e) => Notice(
                    title: e.title?.replaceAll("\n", ""),
                    id: e.id?.replaceAll("\n", ""),
                    url: e.links?.first?.href?.replaceAll("\n", ""),
                    date: _getDateTimeHora(e.updated),
                    dateForOrder: getDateTime(e.updated).millisecondsSinceEpoch,
                    newspaperBase: this,
//            section: e.categories?.
                    summary: e.summary ?? e.content,
                  ))
              .toList();
          return list;
        }
      } catch (e) {}
      try {
        final result = Rss1Feed.parse(response.body); // for parsing RSS 1.0 feed
        if (result != null) {
          _saveFetchTime();
          list = result.items
              .map((e) => Notice(
                    title: e.title?.replaceAll("\n", ""),
                    id: e.link?.replaceAll("\n", ""),
                    url: e.link?.replaceAll("\n", ""),
                    date: result.updateBase.toIso8601String(),
                    newspaperBase: this,
//            section: e.categories?.
                    summary: e.description,
                  ))
              .toList();
          return list;
        }
      } catch (e) {}
    }
    return list;
  }

  _cleanString(String data) {
    try {
      data = data.replaceAll("\n", "");
      data = utf8.decode(data.runes.toList());
    } catch (e) {}
    return data;
  }

  Future<String> fetchNoticeData(String url) async {
    try {
      http.Response response = await http.get(url);
      dom.Document document = parser.parse(response.body);
      return document.getElementsByClassName(htmlClassNoticeData)?.first?.outerHtml;
    } catch (e) {
      print(e);
      try {
        http.Response response = await http.get(url);
        dom.Document document = parser.parse(response.body);
        return document.getElementsByTagName(htmlClassNoticeData)?.first?.outerHtml;
      } catch (e) {
        print(e);
      }
    }
    return 'Ocurrio un error al cargar la noticia...';
  }

  String _getDateTimeHora(String dateParam) {
    DateTime dateParse = getDateTime(dateParam);
    if (dateParse == null) return dateParam;
    final meridian = dateParse.hour < 13 ? 'am' : 'pm';
    final dateTimeFormat =
        DateFormat('EEEE, d MMM - h:mm \'$meridian\'', Locale('es', 'ES').toString());
    final date = dateTimeFormat.format(dateParse.toLocal());
    return '${date[0].toUpperCase()}${date.substring(1)}';
  }

  DateTime getDateTime(String dateParam) {
    DateTime dateParse = DateTime.tryParse(dateParam) ?? _getDateFromString(dateParam);
    return dateParse;
  }

  DateTime _getDateFromString(String date) {
    return DateFormat('E, d MMM yyyy HH:mm:ss Z', "en_EN").parse(date);
  }
}

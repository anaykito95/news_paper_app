import 'package:dart_rss/domain/atom_feed.dart';
import 'package:dart_rss/domain/rss1_feed.dart';
import 'package:dart_rss/domain/rss_feed.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
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

  List<Section> get sections;

  final Map<String, List<Notice>> _cache = Map();

  Future<List<Notice>> synchronizeNotices({String url, bool cache}) async {
    if (cache ?? true && _cache.containsKey(url ?? rssUrl) && _cache[url ?? rssUrl].isNotEmpty) {
      return _cache[url ?? rssUrl];
    }
    List<Notice> list = [];
    try {
      list = await readRSS();
      if (list.isNotEmpty) {
        _cache.putIfAbsent(url ?? baseUrl, () => list);
      }
    } catch (e) {
      print(e);
    }
    return list;
  }

  Future<List<Notice>> readRSS() async {
    final response = await http.get(rssUrl);
    List<Notice> list = [];
    if (response.statusCode == 200) {
      try {
        final result = RssFeed.parse(response.body);
        if (result != null) {
          list = result.items.map((e) => Notice(
            title: e.title?.replaceAll("\n", ""),
            id: e.guid?.replaceAll("\n", ""),
            url: e.link?.replaceAll("\n", ""),
            date: _getDateTimeHora(e.pubDate?.replaceAll("\n", "")),
            newspaperBase: this,
//            section: e.categories?.
            summary: e.description,
          )).toList();
          return list;
        }
      } catch (e) {}
      try {
        final result = AtomFeed.parse(response.body); // for parsing Atom feed
        if (result != null) {
          list = result.items.map((e) => Notice(
            title: e.title?.replaceAll("\n", ""),
            id: e.id?.replaceAll("\n", ""),
            url: e.links?.first?.href?.replaceAll("\n", ""),
            date: _getDateTimeHora(e.updated),
            newspaperBase: this,
//            section: e.categories?.
            summary: e.summary ?? e.content,
          )).toList();
          return list;
        }
      } catch (e) {}
      try {
        final result = Rss1Feed.parse(response.body); // for parsing RSS 1.0 feed
        if (result != null) {
          list = result.items.map((e) => Notice(
            title: e.title?.replaceAll("\n", ""),
            id: e.link?.replaceAll("\n", ""),
            url: e.link?.replaceAll("\n", ""),
            date: result.updateBase.toIso8601String(),
            newspaperBase: this,
//            section: e.categories?.
            summary: e.description,
          )).toList();
          return list;
        }
      } catch (e) {}
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

  Future<Notice> parseSingleNotice(dom.Document document);

  String _getDateTimeHora(String dateParam) {
    DateTime dateParse = DateTime.tryParse(dateParam) ?? _getDateFromString(dateParam);
    if (dateParse == null) return dateParam;
    final meridian = dateParse.hour < 13 ? 'am' : 'pm';
    final dateTimeFormat =
    DateFormat('EEEE, d MMM - h:mm \'$meridian\'', Locale('es', 'ES').toString());
    final date = dateTimeFormat.format(dateParse.toLocal());
    return '${date[0].toUpperCase()}${date.substring(1)}';
  }

  DateTime _getDateFromString(String date) {
    return DateFormat('E, d MMM yyyy HH:mm:ss Z',"en_EN").parse(date);
  }
}

import 'package:flutter/material.dart';
import 'package:news_paper/model/notice.dart';
import 'package:news_paper/newspaper/base.dart';
import 'package:news_paper/provider/provider_news.dart';
import 'package:news_paper/ui/widget/notice_grid_item.dart';
import 'package:news_paper/ui/widget/placeholder.dart';
import 'package:provider/provider.dart';

class SectionDetail extends StatelessWidget {
  final Section section;
  final NewspaperBase base;

  const SectionDetail({Key key, @required this.section, @required this.base}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(section.name),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: FutureBuilder<List<Notice>>(
        future: loadData(),
        initialData: null,
        builder: (context, snapshot) => snapshot.data == null
            ? ShimmerPlaceholder(itemCount: 5,)
            : snapshot.data.length > 0
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                        value: snapshot.data[i],
                        child: NoticeListItem(),
                      ),
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text('Sin noticias que mostrar'),
                      ],
                    ),
                  ),
      ),
    );
  }

  Future<List<Notice>> loadData() async {
    final list = await base.synchronizeNotices(url: section.url);
    print(list.length);
    return list;
  }
}

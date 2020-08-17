import 'package:flutter/material.dart';
import 'package:news_paper/newspaper/base.dart';
import 'package:news_paper/provider/provider_news.dart';
import 'package:news_paper/ui/widget/notice_grid_item.dart';
import 'package:news_paper/ui/widget/placeholder.dart';

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
            ? ShimmerPlaceholder()
            : snapshot.data.length > 0
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GridView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (ctx, i) => NoticeGridItem(
                        notice: snapshot.data[i],
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 7 / 5,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10),
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

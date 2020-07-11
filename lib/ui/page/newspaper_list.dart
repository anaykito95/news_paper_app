import 'package:flutter/material.dart';
import 'package:news_paper/base.dart';
import 'package:news_paper/provider/provider_news.dart';
import 'package:news_paper/ui/screen/newspaper_detail.dart';
import 'package:provider/provider.dart';

class NewsPaperList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        NewsPaperListItem(newspaper: JuventudRebelde()),
        NewsPaperListItem(newspaper: Granma()),
      ],
    );
  }
}

class NewsPaperListItem extends StatelessWidget {
  final NewspaperBase newspaper;

  const NewsPaperListItem({Key key, this.newspaper}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: newspaper.baseUrl == null
          ? null
          : () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider.value(
                    value: ProviderNotices(newspaper),
                    child: NewspaperDetail(),
                  ))),
      child: Card(
        color: newspaper.color,
        margin: const EdgeInsets.all(20),
        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
        clipBehavior: Clip.hardEdge,
        elevation: 10,
        child: Container(
          height: 200,
          alignment: Alignment.center,
          child: Image.asset('assets/images/${newspaper.assetImageName}'),
        ),
      ),
    );
  }
}

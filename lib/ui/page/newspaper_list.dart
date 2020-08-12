import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_paper/newspaper/base.dart';
import 'package:news_paper/newspaper/granma.dart';
import 'package:news_paper/newspaper/juventud-rebelde.dart';
import 'package:news_paper/newspaper/trabajadores.dart';
import 'package:news_paper/newspaper/tribuna.dart';
import 'package:news_paper/provider/provider_news.dart';
import 'package:news_paper/ui/screen/newspaper_detail.dart';
import 'package:provider/provider.dart';

class NewsPaperList extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 2 / 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        children: <Widget>[
          NewsPaperListItem(newspaper: JuventudRebelde()),
          NewsPaperListItem(newspaper: Granma()),
//          NewsPaperListItem(newspaper: Tribuna()),
          NewsPaperListItem(
            newspaper: Trabajadores(),
            circle: true,
          ),
        ],
      );
}

class NewsPaperListItem extends StatelessWidget {
  final NewspaperBase newspaper;
  final bool circle;

  const NewsPaperListItem({Key key, this.newspaper, this.circle}) : super(key: key);

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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        clipBehavior: Clip.hardEdge,
        elevation: 10,
        child: circle ?? false
            ? Container(
                height: 200,
                margin: const EdgeInsets.all(10),
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 100,
                    backgroundImage: AssetImage('assets/images/${newspaper.assetIconName}')),
              )
            : Container(
                height: 200,
                margin: const EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Image.asset('assets/images/${newspaper.assetIconName}'),
              ),
      ),
    );
  }

  Widget _buildCircleAvatar() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final radius = min(constraints.maxHeight / 4, constraints.maxWidth / 4);
        return Center(
          child: CircleAvatar(
            radius: radius,
            backgroundImage: AssetImage('assets/images/${newspaper.assetIconName}')
          ),
        );
      },
    );
  }
}

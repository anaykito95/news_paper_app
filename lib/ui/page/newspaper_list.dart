import 'package:flutter/material.dart';

class NewsPaperList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        NewsPaperListItem(
          color: Colors.blue,
          nameImage: 'juventud_rebelde.png',
        ),
        NewsPaperListItem(
          color: Colors.white,
          nameImage: 'granma-logo.png',
        ),
        NewsPaperListItem(
          color: Colors.blue,
          nameImage: 'Tribuna-logo-final.png',
        ),
      ],
    );
  }
}

class NewsPaperListItem extends StatelessWidget {
  final String nameImage;
  final Widget page;
  final Color color;

  const NewsPaperListItem({Key key, this.nameImage, this.page, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      child: Container(
        height: 200,
        alignment: Alignment.center,
        child: Image.asset('assets/images/$nameImage'),
      ),
    );
  }
}

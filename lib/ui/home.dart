import 'package:flutter/material.dart';
import 'package:news_paper/ui/app_theme.dart';
import 'package:news_paper/ui/page/newspaper_list.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: MediaQuery.of(context).padding.copyWith(left: 0, right: 0, bottom: 0),
      color: Colors.white,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Periodicos de Cuba',
            style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.black87),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.white),
        ),
//        drawer: Drawer(),
        bottomNavigationBar: BottomAppBar(
//        color: Colors.black26,
          elevation: 0,
          child: ListTile(
            subtitle: Text(
              'Ing. Andrés Forns Jusino',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            title: Text(
              'Desarrollador',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(child: Container(child: NewsPaperList())),
          ],
        ),
      ),
    );
  }
}

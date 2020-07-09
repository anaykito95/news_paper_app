import 'package:flutter/material.dart';
import 'package:news_paper/ui/app_theme.dart';
import 'package:news_paper/ui/page/newspaper_list.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Periodicos de Cuba'),
        actions: <Widget>[
          Switch(
            value: Provider.of<AppStateNotifier>(context, listen: false).isDarkMode,
            onChanged: (boolVal) {
              Provider.of<AppStateNotifier>(context, listen: false).updateTheme(boolVal);
            },
          )
        ],
      ),
      body: NewsPaperList(),
    );
  }
}

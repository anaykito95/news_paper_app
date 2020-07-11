import 'package:flutter/material.dart';
import 'package:news_paper/ui/app_theme.dart';
import 'package:news_paper/ui/page/newspaper_list.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: MediaQuery.of(context).padding.copyWith(left: 0, right: 0, bottom: 0),
      color: Colors.grey,
      child: Scaffold(
        body: Column(
          children: <Widget>[
            ListTile(
              title: Text(
                'Periodicos de Cuba',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4,
              ),
//              trailing: Switch(
//                value: Provider.of<AppStateNotifier>(context, listen: false).isDarkMode,
//                onChanged: (boolVal) {
//                  Provider.of<AppStateNotifier>(context, listen: false).updateTheme(boolVal);
//                },
//              ),
            ),
            Expanded(child: NewsPaperList()),
          ],
        ),
      ),
    );
  }
}

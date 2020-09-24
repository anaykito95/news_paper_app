import 'package:flutter/material.dart';
import 'package:news_paper/ui/app_theme.dart';
import 'package:news_paper/ui/page/newspaper_list.dart';
import 'package:package_info/package_info.dart';
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
            'Periódicos de Cuba',
            style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.black87),
          ),
          actions: <Widget>[
            Tooltip(
              message: 'Información',
              child: IconButton(
                icon: Icon(Icons.info_outline),
                color: Colors.black54,
                onPressed: () => PackageInfo.fromPlatform().then((info) => showAboutDialog(
                        context: context,
                        applicationIcon: CircleAvatar(
                          backgroundImage: AssetImage('assets/icon/icon.png'),
                        ),
                        children: [
                          ListTile(
                            title: Text('Desarrollador'),
                            subtitle: Text('Ing. Andrés Forns Jusino'),
                          ),
                          ListTile(
                            title: Text('Version'),
                            subtitle: Text('${info.version}.${info.buildNumber}'),
                          )
                        ])),
              ),
            )
          ],
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.white),
        ),
//        drawer: Drawer(),
//        bottomNavigationBar: BottomAppBar(
////        color: Colors.black26,
//          elevation: 0,
//          child: ListTile(
//            subtitle: Text(
//              'Ing. Andrés Forns Jusino',
////              textAlign: TextAlign.center,
//              style: Theme.of(context).textTheme.bodyText1,
//            ),
//            title: Text(
//              '*Desarrollador',
////              textAlign: TextAlign.center,
//              style: Theme.of(context).textTheme.bodyText2,
//            ),
//            trailing: Text(
//              'asd',
//              style: Theme.of(context).textTheme.caption.copyWith(color: Colors.black87),
//            ),
//          ),
//        ),
        body: Column(
          children: <Widget>[
            Expanded(child: Container(child: NewsPaperList())),
          ],
        ),
      ),
    );
  }
}

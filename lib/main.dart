import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_paper/model/notice.dart';
import 'package:news_paper/ui/app_theme.dart';
import 'package:news_paper/ui/home.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoticeAdapter());
  initializeDateFormatting("es_ES", null).then((_) => runApp(App()));
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AppStateNotifier()),
      ],
      child: Consumer<AppStateNotifier>(
        builder: (context, appState, child) => MaterialApp(
            title: 'Periodicos de Cuba',
            builder: (context, child) {
              return ScrollConfiguration(
                behavior: MyBehavior(),
                child: child,
              );
            },
            home: FutureBuilder(
                future: Hive.openBox('app'),
                builder: (context, snapshot) {
                  return snapshot.connectionState == ConnectionState.done
                      ? Home()
                      : Scaffold(
                          body: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                }),
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    Hive.close();
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

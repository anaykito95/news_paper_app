import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
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
  await initializeDateFormatting("es_ES", null);
  runApp(
    EasyDynamicThemeWidget(
      child: App(),
    ),
  );
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
            if(snapshot.connectionState == ConnectionState.done) {
              return Home();
            }
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }),
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: EasyDynamicTheme.of(context).themeMode,
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

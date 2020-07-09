import 'package:flutter/material.dart';
import 'package:news_paper/ui/app_theme.dart';
import 'package:news_paper/ui/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AppStateNotifier()),
      ],
      child: Consumer<AppStateNotifier>(
        builder: (context, appState, child) => MaterialApp(
            title: 'Periodicos de Cuba',
            home: Home(),
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light),
      ),
    );
  }
}

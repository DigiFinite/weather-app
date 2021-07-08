import 'package:Weather/models/settings.dart';
import 'package:Weather/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:Weather/screens/Loading.dart';
import 'package:Weather/screens/Weather.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppSettingsChangeNotifier>(
      create: (_) => AppSettingsChangeNotifier(),
      child: Consumer<AppSettingsChangeNotifier>(
          builder: (_, appSettings, __) => MaterialApp(
          title: 'Weather',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: appSettings.themeMode == AppThemeMode.Light ? ThemeMode.light : ThemeMode.dark, 
          debugShowCheckedModeBanner: false,
          initialRoute: '/loading',
          routes: {
            '/loading': (context) => Loading(),
            '/weather': (context) => Weather(),
          },
        ),
      ),
    );
  }
}

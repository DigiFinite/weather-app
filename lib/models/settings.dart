import 'package:flutter/foundation.dart';

class AppSettingsChangeNotifier extends ChangeNotifier {
  AppThemeMode themeMode = AppThemeMode.Light;

  void toggleTheme() {
    themeMode = themeMode == AppThemeMode.Light
        ? AppThemeMode.Dark
        : AppThemeMode.Light;
    notifyListeners();
  }
}

enum AppThemeMode {
  Light,
  Dark,
}

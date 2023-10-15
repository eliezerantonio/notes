import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infrastructure/shared/cache/key_value_storage_service.dart';
import '../../../infrastructure/shared/cache/key_value_storage_service_impl.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  final keyValueStorageService = KeyValueStorageServiceImpl();

  return ThemeNotifier(keyValueStorageService: keyValueStorageService);
});

//!Notifier
class ThemeNotifier extends StateNotifier<ThemeState> {
  final KeyValueStorageService keyValueStorageService;

  ThemeNotifier({required this.keyValueStorageService}) : super(ThemeState()) {
    getTheme();
  }

  Future<void> setTheme(bool value) async {
    await keyValueStorageService.setKeyValue('theme', value);

    if (value) {
      _setDarkTheme(value);
      return;
    }
    _setLightTheme(value);
  }

  Future<void> _setDarkTheme(bool value) async {
    state = state.copyWith(themeData: darkTheme(), darkTheme: value);
  }

  Future<void> _setLightTheme(bool value) async {
    state = state.copyWith(themeData: lightTheme(), darkTheme: value);
  }

  Future<void> getTheme() async {
    final theme = await keyValueStorageService.getValue('theme');
    switch (theme) {
      case false:
        state = state.copyWith(themeData: lightTheme(), darkTheme: theme);
        break;
      case true:
        state = state.copyWith(themeData: darkTheme(), darkTheme: theme);
        break;

      default:
        state = state.copyWith(themeData: lightTheme(), darkTheme: theme);
    }
  }

  ThemeData lightTheme() => ThemeData.light(useMaterial3: true);
  ThemeData darkTheme() => ThemeData.dark(useMaterial3: true);
}

//!state

class ThemeState {
  final ThemeData? themeData;
  final bool darkTheme;

  ThemeState({
    this.themeData,
    this.darkTheme = false,
  });

  ThemeState copyWith({
    ThemeData? themeData,
    bool? darkTheme,
  }) {
    return ThemeState(
      themeData: themeData ?? this.themeData,
      darkTheme: darkTheme ?? this.darkTheme,
    );
  }
}

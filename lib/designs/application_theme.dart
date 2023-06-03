import 'package:flutter/material.dart';

class ApplicationTheme {
  final ColorScheme kColourScheme = ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 96, 59, 181)
  );

  final ColorScheme kDarkMode = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 125, 0, 255)
  );

  ThemeData get applyNormalTheme {
    // copyWith takes existing theme and allows overriding for certain features
    return ThemeData().copyWith(
      useMaterial3: true,
      colorScheme: kColourScheme,
      appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: kColourScheme.onPrimaryContainer,
        foregroundColor: kColourScheme.primaryContainer
      ),
      cardTheme: const CardTheme().copyWith(
        color: kColourScheme.secondaryContainer,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8)
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        // copyWith and styleFrom have a similar function
        style: ElevatedButton.styleFrom(
          backgroundColor: kColourScheme.primaryContainer
        )
      ),
      textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: kColourScheme.onSecondaryContainer
        )
      )
    );
  }

  ThemeData get applyDarkTheme {
    return ThemeData.dark().copyWith(
      useMaterial3: true,
      colorScheme: kDarkMode,
      cardTheme: const CardTheme().copyWith(
        color: kDarkMode.secondaryContainer,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8)
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        // copyWith and styleFrom have a similar function
        style: ElevatedButton.styleFrom(
          backgroundColor: kDarkMode.primaryContainer,
          foregroundColor: kDarkMode.onPrimaryContainer
        )
      ),
    );
  }

}
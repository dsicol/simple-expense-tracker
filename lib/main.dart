import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';
import 'package:expense_tracker/designs/application_theme.dart';

var kColourScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 96, 59, 181)
);

void main() {
  final applicationTheme = ApplicationTheme();
  runApp(
      MaterialApp(
        // copyWith uses default style and overrides certain features
          theme: applicationTheme.applyNormalTheme,
          darkTheme: applicationTheme.applyDarkTheme,
          themeMode: ThemeMode.dark,
          home: const Expenses()
      )
    );
}

import 'package:flutter/material.dart';

class NavalhaTheme {
  static ThemeData get themeData => ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false,
        dividerTheme: const DividerThemeData(
          color: Colors.transparent,
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          surfaceTintColor: Colors.transparent,
        ),
        dialogTheme: const DialogTheme(
          surfaceTintColor: Colors.transparent,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            surfaceTintColor: MaterialStateProperty.all(Colors.transparent),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            surfaceTintColor: MaterialStateProperty.all(Colors.transparent),
          ),
        ),
        appBarTheme: const AppBarTheme(surfaceTintColor: Colors.transparent),
        cupertinoOverrideTheme:
            MaterialBasedCupertinoThemeData(materialTheme: ThemeData()),
        canvasColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(background: Colors.black),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.amber,
        ),
      );
}

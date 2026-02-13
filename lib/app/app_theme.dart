import 'package:flutter/material.dart';
import 'package:productapp/app/app_color.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      toolbarHeight: 65,
      backgroundColor: AppColor.blue1,
      centerTitle: false,
      iconTheme: const IconThemeData(color: AppColor.white, size: 25),
      titleSpacing: 0,
      titleTextStyle: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 17,
        color: AppColor.white,
      ),
    ),
    dividerTheme: const DividerThemeData(thickness: 0.5, space: 10.0),
    tabBarTheme: TabBarThemeData(
      unselectedLabelColor: AppColor.blue1,
      labelColor: AppColor.white,
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: const BoxDecoration(
        color: AppColor.blue1,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(6),
          topRight: Radius.circular(6),
          bottomLeft: Radius.circular(2.5),
          bottomRight: Radius.circular(2.5),
        ),
      ),
      labelStyle: const TextStyle(fontSize: 14, color: AppColor.blue1),
      unselectedLabelStyle: const TextStyle(
        fontSize: 14,
        color: AppColor.blue1,
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColor.grey1,
      primary: AppColor.blue1,
      secondary: AppColor.green1,
      tertiary: AppColor.blue1,
      brightness: Brightness.light,
    ),
    cardTheme: CardThemeData(
      surfaceTintColor: Colors.white,
      shadowColor: AppColor.grey3,
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
    ),
    sliderTheme: SliderThemeData(
      trackHeight: 2,
      overlayColor: AppColor.red1,
      thumbColor: AppColor.red1,
      inactiveTrackColor: AppColor.red3,
      activeTrackColor: AppColor.red1,
      secondaryActiveTrackColor: AppColor.red1,
      thumbShape: SliderComponentShape.noThumb,
      overlayShape: SliderComponentShape.noOverlay,
      disabledInactiveTrackColor: AppColor.red3,
    ),
    iconTheme: const IconThemeData(color: AppColor.blue1),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        shape: WidgetStateProperty.all(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(0)),
          ),
        ),
      ),
    ),
    useMaterial3: true,
    dialogTheme: DialogThemeData(
      actionsPadding: const EdgeInsets.all(5),
      surfaceTintColor: AppColor.white,
      backgroundColor: AppColor.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColor.black3,
      selectedItemColor: AppColor.green1,
      unselectedItemColor: AppColor.grey12,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.green1,
        foregroundColor: Colors.white,
        minimumSize: const Size(50, 50),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all(const Size(50, 50)),
        side: WidgetStateProperty.all(
          BorderSide(color: AppColor.red1, width: 1),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade200,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    ),
  );

  // ==================== DARK THEME ====================
  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      toolbarHeight: 65,
      backgroundColor: Colors.black,
      centerTitle: false,
      iconTheme: const IconThemeData(color: Colors.white, size: 25),
      titleSpacing: 0,
      titleTextStyle: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 17,
        color: Colors.white,
      ),
    ),
    dividerTheme: const DividerThemeData(thickness: 0.5, space: 10.0),
    tabBarTheme: TabBarThemeData(
      unselectedLabelColor: Colors.white70,
      labelColor: Colors.white,
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: BoxDecoration(
        color: Colors.white24,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(6),
          topRight: Radius.circular(6),
          bottomLeft: Radius.circular(2.5),
          bottomRight: Radius.circular(2.5),
        ),
      ),
      labelStyle: const TextStyle(fontSize: 14, color: Colors.white),
      unselectedLabelStyle: const TextStyle(
        fontSize: 14,
        color: Colors.white70,
      ),
    ),
    colorScheme: const ColorScheme.dark(
      primary: Colors.white,
      secondary: Colors.white70,
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      surface: Colors.grey,
      onSurface: Colors.white,
    ),
    cardTheme: CardThemeData(
      surfaceTintColor: Colors.grey[900],
      shadowColor: Colors.grey[800],
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
    ),
    sliderTheme: SliderThemeData(
      trackHeight: 2,
      overlayColor: Colors.white,
      thumbColor: Colors.white,
      inactiveTrackColor: Colors.grey,
      activeTrackColor: Colors.white,
      secondaryActiveTrackColor: Colors.white,
      thumbShape: SliderComponentShape.noThumb,
      overlayShape: SliderComponentShape.noOverlay,
      disabledInactiveTrackColor: Colors.grey,
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        shape: WidgetStateProperty.all(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(0)),
          ),
        ),
      ),
    ),
    useMaterial3: true,
    dialogTheme: DialogThemeData(
      actionsPadding: const EdgeInsets.all(5),
      surfaceTintColor: Colors.grey[900],
      backgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        minimumSize: const Size(50, 50),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all(const Size(50, 50)),
        side: WidgetStateProperty.all(
          const BorderSide(color: Colors.white, width: 1),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[850],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      labelStyle: const TextStyle(color: Colors.white70),
    ),
  );
}

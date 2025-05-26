import 'package:byte_flow/views/auth/gestarted.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  void toggleTheme() {
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  // Light theme colors
  static const Color lightPrimaryColor = Color(0xFF3D5AFE);
  static const Color lightSecondaryColor = Color(0xFF81A4FD);
  static const Color lightBackgroundColor = Colors.white;
  static const Color lightTextColor = Colors.black87;
  static const Color lightContainerTextColor = Colors.white;

  // Dark theme colors
  static const Color darkPrimaryColor = Color(0xFF1A237E);
  static const Color darkSecondaryColor = Color(0xFF3949AB);
  static const Color darkBackgroundColor = Color(0xFF121212);
  static const Color darkTextColor = Colors.white;
  static const Color darkContainerTextColor = Colors.white;

  // Get gradient colors based on current theme
  List<Color> get gradientColors => themeMode == ThemeMode.light
      ? [lightPrimaryColor, lightSecondaryColor]
      : [darkPrimaryColor, darkSecondaryColor];

  // Get text color based on theme
  Color get textColor =>
      themeMode == ThemeMode.light ? lightTextColor : darkTextColor;

  // Get container text color
  Color get containerTextColor => lightContainerTextColor;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: ThemeProvider.lightPrimaryColor,
            scaffoldBackgroundColor: ThemeProvider.lightBackgroundColor,
            appBarTheme: AppBarTheme(
              backgroundColor: ThemeProvider.lightBackgroundColor,
              foregroundColor: ThemeProvider.lightTextColor,
              elevation: 0,
            ),
            textTheme: Typography.material2018().black,
            colorScheme: ColorScheme.light(
              primary: ThemeProvider.lightPrimaryColor,
              secondary: ThemeProvider.lightSecondaryColor,
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: ThemeProvider.darkPrimaryColor,
            scaffoldBackgroundColor: ThemeProvider.darkBackgroundColor,
            appBarTheme: AppBarTheme(
              backgroundColor: ThemeProvider.darkBackgroundColor,
              foregroundColor: ThemeProvider.darkTextColor,
              elevation: 0,
            ),
            textTheme: Typography.material2018().white,
            colorScheme: ColorScheme.dark(
              primary: ThemeProvider.darkPrimaryColor,
              secondary: ThemeProvider.darkSecondaryColor,
            ),
          ),
          home: const GetStarted(),
        );
      },
    );
  }
}

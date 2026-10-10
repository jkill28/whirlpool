import 'package:flutter/material.dart';
import 'package:whirldroid/screens/main_screen.dart';

void main() {
  runApp(const WhirldroidApp());
}

class WhirldroidApp extends StatelessWidget {
  const WhirldroidApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhirlDroid',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          brightness: Brightness.dark,
          primary: Colors.orange,
          secondary: Colors.orangeAccent,
          surface: const Color(0xFF121212),
          background: const Color(0xFF1E1E1E),
          error: Colors.redAccent,
          onPrimary: Colors.black,
          onSecondary: Colors.black,
          onSurface: Colors.white,
          onBackground: Colors.white,
          onError: Colors.black,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF0D0D0D),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          foregroundColor: Colors.white,
          elevation: 4,
          shadowColor: Colors.orange,
        ),
        cardTheme: CardTheme(
          color: const Color(0xFF1E1E1E),
          elevation: 2,
          shadowColor: Colors.orange.withOpacity(0.3),
          margin: const EdgeInsets.all(8),
        ),
        listTileTheme: ListTileThemeData(
          tileColor: const Color(0xFF1E1E1E),
          textColor: Colors.white,
          iconColor: Colors.orange,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.black,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.black,
            elevation: 4,
            shadowColor: Colors.orange,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF2D2D2D),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.orange.withOpacity(0.5)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.orange.withOpacity(0.5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.orange, width: 2),
          ),
          labelStyle: const TextStyle(color: Colors.orange),
          hintStyle: const TextStyle(color: Colors.grey),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF121212),
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey,
        ),
        dividerTheme: const DividerThemeData(
          color: Color(0xFF333333),
          thickness: 1,
        ),
      ),
      home: const MainScreen(),
    );
  }
}

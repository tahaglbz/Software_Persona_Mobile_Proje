import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const NovaStoreApp());
}

/// NovaStore Mini Katalog Uygulaması
/// Lisans: MIT
/// Geliştirici: Flutter Graduation Project
class NovaStoreApp extends StatelessWidget {
  const NovaStoreApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NovaStore Mini Katalog',
      debugShowCheckedModeBanner: false,

      // Tema Ayarları - Profesyonel Görünüm
      theme: ThemeData(
        // Renk Şeması
        primarySwatch: Colors.blue,
        useMaterial3: true,

        // AppBar Teması
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
          elevation: 2,
          centerTitle: false,
          titleTextStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),

        // Buton Teması
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade600,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

        // Card Teması
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        // Scaffold Arka Planı
        scaffoldBackgroundColor: Colors.white,
      ),

      // Ana Ekran - HomeScreen
      home: const HomeScreen(),
    );
  }
}

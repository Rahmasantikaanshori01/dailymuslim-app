// // ===========================
// // view/theme/theme_provider.dart
// // ===========================

// import 'package:flutter/material.dart';

// class ThemeProvider extends ChangeNotifier {
//   ThemeData _themeData = defaultTheme;

//   ThemeData get themeData => _themeData;

//   String currentTheme = 'default';

//   // ================= DEFAULT =================

//   static final ThemeData defaultTheme = ThemeData(
//     brightness: Brightness.light,
//     scaffoldBackgroundColor: const Color(0xFF8E97B5),
//     primaryColor: const Color(0xFF8E97B5),
//     colorScheme: ColorScheme.fromSeed(
//       seedColor: const Color(0xFF8E97B5),
//     ),
//   );

//   // ================= DARK =================

//   static final ThemeData darkTheme = ThemeData(
//     brightness: Brightness.dark,
//     scaffoldBackgroundColor: const Color(0xFF1E1E1E),
//     primaryColor: Colors.black,
//   );

//   // ================= LIGHT =================

//   static final ThemeData lightTheme = ThemeData(
//     brightness: Brightness.light,
//     scaffoldBackgroundColor: Colors.white,
//     primaryColor: Colors.white,
//   );

//   // ================= GREEN =================

//   static final ThemeData greenTheme = ThemeData(
//     brightness: Brightness.light,
//     scaffoldBackgroundColor: const Color(0xFF4CAF50),
//     primaryColor: const Color(0xFF4CAF50),
//   );

//   // ================= PURPLE =================

//   static final ThemeData purpleTheme = ThemeData(
//     brightness: Brightness.light,
//     scaffoldBackgroundColor: const Color(0xFF9C27B0),
//     primaryColor: const Color(0xFF9C27B0),
//   );

//   // ================= YELLOW =================

//   static final ThemeData yellowTheme = ThemeData(
//     brightness: Brightness.light,
//     scaffoldBackgroundColor: const Color(0xFFFFC107),
//     primaryColor: const Color(0xFFFFC107),
//   );

//   // ================= PINK =================

//   static final ThemeData pinkTheme = ThemeData(
//     brightness: Brightness.light,
//     scaffoldBackgroundColor: const Color(0xFFE91E63),
//     primaryColor: const Color(0xFFE91E63),
//   );

//   // ================= CHANGE THEME =================

//   void changeTheme(String theme) {
//     currentTheme = theme;

//     switch (theme) {
//       case 'dark':
//         _themeData = darkTheme;
//         break;

//       case 'light':
//         _themeData = lightTheme;
//         break;

//       case 'green':
//         _themeData = greenTheme;
//         break;

//       case 'purple':
//         _themeData = purpleTheme;
//         break;

//       case 'yellow':
//         _themeData = yellowTheme;
//         break;

//       case 'pink':
//         _themeData = pinkTheme;
//         break;

//       default:
//         _themeData = defaultTheme;
//     }

//     notifyListeners();
//   }
// }
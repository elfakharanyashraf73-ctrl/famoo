import 'package:famoo/Main.dart';

ThemeData lightMode = ThemeData(
  scaffoldBackgroundColor: Color(0xFFFDF8F0),

  colorScheme: ColorScheme.fromSeed(
    seedColor: Color(0xFFC5A059),
    primary: Color(0xFFC5A059),
    secondary: Color(0xFFB8933F),
    surface: Color(0xFFFFFFFF),
  ),
  //_______________________________________________
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(fontSize: 20, fontFamily: 'Pinky'),
    backgroundColor: Color(0xFFC5A059),
    foregroundColor: Color(0xFFFFFFFF),

    elevation: 0,
  ),

  dividerColor: Color(0xFFE8D5B7),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xFFC5A059),
    foregroundColor: Color(0xFFFFFFFF),
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xFFF5F0E6),
    selectedItemColor: Color(0xFFC5A059),
    unselectedItemColor: Color(0xFF9E9E9E),
  ),

  textTheme: TextTheme(
    bodyLarge: TextStyle(
      fontFamily: 'Pinky',
      // fontSize: 20,
      color: Color(0xff050301),
    ),
    bodyMedium: TextStyle(fontFamily: 'Pinky', color: Color(0xFF8A8A8A)),
    bodySmall: TextStyle(
      fontFamily: 'Pinky',
      color: Color(0xFF8A8A8A),
      fontSize: 13,
    ),
    labelLarge: TextStyle(
      fontFamily: 'Pinky',
      fontSize: 20,
      color: Color(0xff050301),
    ),
    labelMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontFamily: 'Pinky',
      fontSize: 16,
      color: Color(0xff050301),
    ),
  ),
);
ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(
    0xFF12100E,
  ), // خلفية داكنة مائلة لدفء درجات الـ Gold

  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color(0xFFC5A059),
    primary: const Color(0xFFC5A059),
    secondary: const Color(0xFFD4AF37),
    surface: const Color(
      0xFF1E1A17,
    ), // لون الكروت والعناصر الداكنة بدمج خفيف مع لون البراند
  ),

  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontFamily: 'Pinky',
      color: Colors.white,
    ),
    backgroundColor: Color(0xFF1E1A17),
    foregroundColor: Color(0xFFC5A059),
    elevation: 0,
  ),

  dividerColor: const Color(0xFF38302A),

  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFFC5A059),
    foregroundColor: Color(0xFF12100E),
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF1E1A17),
    selectedItemColor: Color(0xFFC5A059),
    unselectedItemColor: Color(0xFF8A8A8A),
  ),

  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontFamily: 'Pinky',
      color: Color(0xFFF5F0E6), // نص فاتح مريح للعين بدلاً من الأبيض الصريح
    ),
    bodyMedium: TextStyle(fontFamily: 'Pinky', color: Color(0xFFB0A89F)),
    bodySmall: TextStyle(
      fontFamily: 'Pinky',
      color: Color(0xFFB0A89F),
      fontSize: 16,
    ),
    labelLarge: TextStyle(
      fontFamily: 'Pinky',
      fontSize: 20,
      color: Color(0xFFF5F0E6),
    ),
    labelMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontFamily: 'Pinky',
      fontSize: 16,
      color: Color(0xFFF5F0E6),
    ),
  ),
);

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;
  bool isdark=false;
  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }
  
void toggleTheme() {
  final isDark = _themeData == lightMode;
  isdark = isDark;
  themeData = isDark ? darkMode : lightMode;
  settings['darkMode'] = isDark;
}
}

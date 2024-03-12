import 'package:flutter/material.dart';
import 'package:result_ease/screen/onboarding/splash.dart';


final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: const MaterialColor(0xFF1D3557, {
      50: Color(0xFFEBF2F7),
      100: Color(0xFFD4E4F1),
      200: Color(0xFFADCBE6),
      300: Color(0xFF85B2D9),
      400: Color(0xFF6094CC),
      500: Color(0xFF457B9D),
      600: Color(0xFF3A688B),
      700: Color(0xFF30577A),
      800: Color(0xFF254568),
      900: Color(0xFF1B3548),
    }),
    brightness: Brightness.light,
    accentColor:const Color(0xFFE63946),
    backgroundColor:const Color(0xFFA8DADC),
    cardColor:const Color(0xFFF1FAEE),
  ),
  textTheme:const TextTheme(
    bodyText1: TextStyle(
      color: Colors.black87, // For highly readable body text
    ),
    headline6: TextStyle(
      color: Color(0xFF1D3557), // For headings or titles
      fontWeight: FontWeight.bold,
      fontSize: 48,
    ),
  ),
);


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme,
      home: const SplashScreen(),
    );
  }
}

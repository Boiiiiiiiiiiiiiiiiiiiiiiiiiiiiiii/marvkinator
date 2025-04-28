import 'package:akinator/data/notifiers.dart';
import 'package:akinator/views/pages/welcome_page.dart';
import 'package:flutter/material.dart';
 // Import your Debt class
void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkThemeNotifier,
      builder: (context, isDark, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 132, 200, 255),
              brightness: isDark ? Brightness.dark : Brightness.light
            )
          ),

          home: WelcomePage()
        );
      },
    );
  }
}

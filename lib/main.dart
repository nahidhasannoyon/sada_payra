import 'package:flutter/material.dart';
import 'package:sada_payra/views/home_screen.dart';

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
      theme: ThemeData(
        fontFamily: 'Satoshi',
        primaryColor: const Color.fromRGBO(248, 245, 242, 1),
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(248, 245, 242, 1),
        ),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(
              secondary: const Color.fromRGBO(7, 128, 128, 1),
            )
            .copyWith(
              surface: const Color.fromRGBO(248, 245, 242, 1),
            ),
      ),
      home: const HomeScreen(),
    );
  }
}

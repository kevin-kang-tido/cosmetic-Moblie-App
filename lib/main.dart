import 'package:cosmetic/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:cosmetic/screen/main_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainScreen(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 84, 3, 223),
        ),
        useMaterial3: false,
        fontFamily: 'Lato',
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

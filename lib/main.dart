import 'package:cosmetic/screen/main_screen.dart';
import 'package:flutter/material.dart';

void main() {

  // Control level
  final control = ElevatedButton(onPressed: (){}, child: Icon(Icons.check));

  // Layout level
  final layout = Align(
    alignment: Alignment.bottomRight,
    child: Padding(
      padding: EdgeInsets.all(20),
      child: control,
    ),
  );

  final screen = MainScreen();

  // Root tree
  final root = MaterialApp(
    home: screen,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(255, 84, 3, 223),
      ),
      useMaterial3: false,
      // fontFamily:
    ),
    debugShowCheckedModeBanner: false,
  );

  runApp(root);
}
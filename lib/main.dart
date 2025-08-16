// lib/main.dart (Updated)

import 'package:cosmetic/data/app_shared_pref.dart';
import 'package:cosmetic/product_provider.dart';
import 'package:cosmetic/screen/add_cart_screen.dart';
import 'package:cosmetic/screen/register_screen.dart';
import 'package:cosmetic/screen/slash_screen.dart';
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
      // Use the AuthWrapper as the home screen
      home: const AuthWrapper(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 84, 3, 223),
        ),
        useMaterial3: false,
        fontFamily: 'Lato',
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/cart': (_) => const AddCartScreen(),
      },
    );
  }
}

// This new widget checks the auth status and directs the user
class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  final AppSharedPref _prefs = AppSharedPref();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _prefs.isLoggedIn(),
      builder: (context, snapshot) {
        // Show a loading screen while we check the auth status
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // If the user is logged in, show the MainScreen
        if (snapshot.hasData && snapshot.data == true) {
          return const MainScreen();
        }

        // Otherwise, show the RegisterScreen
        return const SplashScreen();
      },
    );
  }
}
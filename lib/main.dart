import 'package:cosmetic/product_provider.dart';
import 'package:cosmetic/screen/add_cart_screen.dart';
import 'package:cosmetic/screen/slash_screen.dart';
import 'package:cosmetic/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'translate/app_translate.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


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
    return GetMaterialApp(
      title: 'Cosmetic App',

      // Translation
      translations: AppTranslate(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale("en", ""),
      supportedLocales: const [
        Locale("en", ""),
        Locale("km", ""), // Khmer
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // Theme setup
      theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 84, 3, 223),
        ),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,

      debugShowCheckedModeBanner: false,

      // Auth wrapper
      home: const AuthWrapper(),

      routes: {
        '/cart': (_) => const AddCartScreen(),
      },
    );
  }
}

/// Authentication Wrapper with Firebase
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData) {
          return const MainScreen();
        }
        return const SplashScreen();
      },
    );
  }
}

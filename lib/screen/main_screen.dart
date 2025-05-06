import 'package:cosmetic/screen/fav_screen.dart';
import 'package:cosmetic/screen/home_screen.dart';
import 'package:cosmetic/screen/shop_screen.dart';
import 'package:cosmetic/screen/user_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    ShopScreen(),
    FavScreen(),
    UserScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            const SizedBox(height: 12),
            Expanded(child: _screens[_selectedIndex]),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_basket), label: 'Shop'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Favorite'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'User'),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: const [
          Icon(Icons.menu, size: 30),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Shopie',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/images/cosmetic_2.png'),
          ),
        ],
      ),
    );
  }
}

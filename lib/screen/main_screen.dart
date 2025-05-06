import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<String> categories = ['Skincare', 'Makeup', 'Haircare', 'Personal'];
  final List<Map<String, String>> products = List.generate(
    6,
        (index) => {
      'title': 'Black Skincare',
      'subtitle': 'Aesthetic Skincare Branding',
      'price': '\$10.99',
      'image': 'assets/images/cosmetic_1.png', // replace with asset or network image
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(child: _buildBody()),
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
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Person'),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopBar(),
          const SizedBox(height: 16),
          _buildPromoBanner(),
          const SizedBox(height: 16),
          _buildCategories(),
          const SizedBox(height: 16),
          _buildSection('New Arrivals'),
          _buildProductList(),
          const SizedBox(height: 16),
          _buildSection('Best Sales'),
          _buildProductList(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      children: [
        const Icon(Icons.menu, size: 30),
        const SizedBox(width: 12),
        const Expanded(
          child: Text(
            'Shopie',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        const CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage('assets/images/cosmetic_2.png'), // replace with user profile
        ),
      ],
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.pink[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Get your special sale', style: TextStyle(fontSize: 16)),
                Text('up to 90%', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Shop Now'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return Wrap(
      spacing: 8,
      children: categories
          .map((cat) => Chip(
        label: Text(cat),
        backgroundColor: Colors.white,
        side: const BorderSide(color: Colors.grey),
      ))
          .toList(),
    );
  }

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    );
  }

  Widget _buildProductList() {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final product = products[index];
          return Container(
            width: 140,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(product['image']!, height: 100),
                const SizedBox(height: 8),
                Text(product['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(product['subtitle']!, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(product['price']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                    const Icon(Icons.favorite_border, color: Colors.green),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

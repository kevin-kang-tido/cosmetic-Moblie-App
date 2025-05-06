import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<String> categories = const ['Skincare', 'Makeup', 'Haircare', 'Personal'];

  final List<Map<String, String>> products = const [
    {
      'title': 'Black Skincare',
      'subtitle': 'Aesthetic Skincare Branding',
      'price': '\$10.99',
      'image': 'assets/images/cosmetic_2.png',
    },
    {
      'title': 'Black Skincare',
      'subtitle': 'Aesthetic Skincare Branding',
      'price': '\$10.99',
      'image': 'assets/images/cosmetic_2.png',
    },
    {
      'title': 'Black Skincare',
      'subtitle': 'Aesthetic Skincare Branding',
      'price': '\$10.99',
      'image': 'assets/images/cosmetic_2.png',
    },
    // Add more products if needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
        ),
      ),
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
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Get your special sale', style: TextStyle(fontSize: 16)),
                Text('up to 90%', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            child: const Text('Shop Now'),
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
                Image.network(product['image']!, height: 100, fit: BoxFit.cover),
                const SizedBox(height: 8),
                Text(product['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(product['subtitle']!, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(product['price']!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const Icon(Icons.favorite_border, color: Colors.black),
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

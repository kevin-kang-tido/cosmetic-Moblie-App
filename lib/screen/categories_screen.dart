import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cosmetic/model/product_model.dart';
import 'package:cosmetic/screen/detail_screen.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../product_provider.dart';
import 'package:cosmetic/screen/user_screen.dart';
import 'package:cosmetic/screen/main_screen.dart';


class CategoriesScreen extends StatefulWidget {
  final String category;

  const CategoriesScreen({super.key, required this.category});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final String response = await rootBundle.loadString('assets/data/products.json');
    final data = json.decode(response) as List;
    final allProducts = data.map((item) => Product.fromJson(item)).toList();

    setState(() {
      _products = allProducts
          // .where((product) => product.category.toLowerCase() == widget.category.toLowerCase())
          .toList();
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            const SizedBox(height: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: _products.isEmpty
                    ? const Center(child: Text("No products found in this category"))
                    : GridView.builder(
                  itemCount: _products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.65,
                  ),
                  itemBuilder: (context, index) =>
                      _buildProductCard(context, _products[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildProductCard(BuildContext context, Product product) {
    final provider = Provider.of<ProductProvider>(context);
    final isFav = provider.isFavorite(product);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailPage(product: product),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Image.asset(product.image),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2),
            Text(
              product.description,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: isFav ? Colors.green : Colors.grey,
                  ),
                  onPressed: () {
                    provider.toggleFavorite(product);
                    provider.addToCart(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Added to cart')),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const Icon(Icons.menu, size: 30),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const MainScreen()),
                );
              },
              child: const Text(
                'Shopie',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const UserScreen()),
              );
            },
            child: const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
          ),
        ],
      ),
    );
  }
}

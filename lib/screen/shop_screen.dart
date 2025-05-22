import 'dart:convert';

import 'package:cosmetic/model/product_model.dart';
import 'package:cosmetic/screen/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../product_provider.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final String response = await rootBundle.loadString('assets/data/products.json');
    final data = json.decode(response) as List;
    setState(() {
      _products = data.map((item) => Product.fromJson(item)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearchBar(context),
        const SizedBox(height: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: GridView.builder(
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
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          const Icon(Icons.arrow_back_ios, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Product',
                prefixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Stack(
            children: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/cart'),
                child: Stack(
                  children: [
                    const Icon(Icons.shopping_cart_outlined, size: 26),
                    // Badge
                  ],
                ),
              ),
              // const Icon(Icons.shopping_cart_outlined, size: 26),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      '2',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
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


// Widget _buildProductCard(BuildContext context, Product product) {
  //   final provider = Provider.of<ProductProvider>(context);
  //   final isFav = provider.isFavorite(product);
  //
  //   return Container(
  //     padding: const EdgeInsets.all(12),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(16),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Expanded(child: Center(child: Image.asset(product.image))),
  //         const SizedBox(height: 8),
  //         Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
  //         const SizedBox(height: 2),
  //         Text(product.description, style: const TextStyle(fontSize: 12, color: Colors.grey)),
  //         const SizedBox(height: 6),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text('\$${product.price}', style: const TextStyle(fontWeight: FontWeight.bold)),
  //             IconButton(
  //               icon: Icon(Icons.favorite, color: isFav ? Colors.green : Colors.grey),
  //               onPressed: () {
  //                 provider.toggleFavorite(product);
  //                 provider.addToCart(product); // 👈 Also add to cart
  //                 ScaffoldMessenger.of(context).showSnackBar(
  //                   const SnackBar(content: Text('Added to cart')),
  //                 );
  //               },
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

}

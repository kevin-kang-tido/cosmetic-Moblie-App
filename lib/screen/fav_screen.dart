import 'package:cosmetic/model/product_model.dart';
import 'package:cosmetic/screen/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../product_provider.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<ProductProvider>(context).favorites;

    if (favorites.isEmpty) {
      return const Center(child: Text('No favorites yet'));
    }

    return Padding(
      padding: const EdgeInsets.all(12),
      child: GridView.builder(
        itemCount: favorites.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.65,
        ),
        itemBuilder: (context, index) {
          final product = favorites[index];
          return _buildFavoriteCard(context, product);
        },
      ),
    );
  }

  Widget _buildFavoriteCard(BuildContext context, Product product) {
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
            Expanded(child: Center(child: Image.asset(product.image))),
            const SizedBox(height: 8),
            Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 2),
            Text(product.description, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 6),
            Text('\$${product.price.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

}

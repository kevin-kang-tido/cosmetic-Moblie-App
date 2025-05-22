import 'package:cosmetic/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/product_model.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final provider = Provider.of<ProductProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: Column(
        children: [
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () => Navigator.pop(context),
                ),
                IconButton(
                  icon: const Icon(Icons.shopping_cart_checkout),
                  onPressed: () {
                    provider.addToCartMuti(product, quantity);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Added to cart')),
                    );
                    Navigator.pushNamed(context, '/cart');
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Image.asset(
                  product.image,
                  height: 250,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDot(true),
                    const SizedBox(width: 6),
                    _buildDot(false),
                  ],
                ),
              ],
            ),
          ),
          _buildBottomDetail(context, product, provider),
        ],
      ),
    );
  }

  Widget _buildDot(bool selected) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: selected ? Colors.black : Colors.grey.shade300,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildBottomDetail(BuildContext context, Product product, ProductProvider provider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Row(
            children: const [
              Icon(Icons.star, color: Colors.black, size: 18),
              Icon(Icons.star, color: Colors.black, size: 18),
              Icon(Icons.star, color: Colors.black, size: 18),
              Icon(Icons.star_border, color: Colors.black, size: 18),
              SizedBox(width: 6),
              Text(
                '#54  Product rating',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            'Aesthetic Skincare Branding',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () => setState(() {
                      if (quantity > 1) quantity--;
                    }),
                    icon: const Icon(Icons.remove_circle_outline),
                  ),
                  Text('$quantity', style: const TextStyle(fontSize: 18)),
                  IconButton(
                    onPressed: () => setState(() {
                      quantity++;
                    }),
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  provider.addToCartMuti(product, quantity);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Added to cart')),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: Text("cart"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

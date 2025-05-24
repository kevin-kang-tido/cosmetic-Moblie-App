import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../product_provider.dart';

class AddCartScreen extends StatelessWidget {
  const AddCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);
    final cart = provider.cart;

    final deliveryFee = 900.0;
    final discount = 30.0;
    final subtotal = provider.subtotal;
    final total = subtotal + deliveryFee - discount;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Bag'),
        leading: const BackButton(),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.shopping_cart_outlined),
          )
        ],
      ),
      body: cart.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: cart.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final entry = cart.entries.elementAt(index);
                final product = entry.key;
                final qty = entry.value;

                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 21),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(product.image, width: 50, height: 50, fit: BoxFit.cover),
                  ),
                  title: Text(product.name),
                  subtitle: Text(product.description),
                  trailing: SizedBox(
                    height: 60, // constrain height to prevent overflow
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () => provider.decrementQty(product),
                              icon: const Icon(Icons.remove_circle_outline, size: 20),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                            Text(qty.toString().padLeft(2, '0')),
                            IconButton(
                              onPressed: () => provider.incrementQty(product),
                              icon: const Icon(Icons.add_circle_outline, size: 20),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  onLongPress: () => provider.removeFromCart(product),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: cart.isEmpty
          ? null
          : SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(blurRadius: 6, color: Colors.black12)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildSummaryRow('Subtotal:', subtotal),
                    _buildSummaryRow('Delivery Fee:', deliveryFee),
                    _buildSummaryRow('Discount:', discount, red: true),
                    const Divider(),
                    _buildSummaryRow('Total:', total, bold: true),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 21),
                  ),
                  onPressed: () {},
                  child: const Text('Check Out'),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }

  Widget _buildSummaryRow(String label, double amount, {bool red = false, bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: TextStyle(
              color: red ? Colors.red : Colors.black,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

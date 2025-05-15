import 'package:cosmetic/model/product_model.dart';
import 'package:flutter/material.dart';


// class ProductProvider with ChangeNotifier {
//
//   final List<Product> _favorites = [];
//
//   List<Product> get favorites => _favorites;
//
//   void toggleFavorite(Product product) {
//     if (_favorites.contains(product)) {
//       _favorites.remove(product);
//     } else {
//       _favorites.add(product);
//     }
//     notifyListeners();
//   }
//
//   bool isFavorite(Product product) {
//     return _favorites.contains(product);
//   }
// }

class ProductProvider with ChangeNotifier {
  final List<Product> _favorites = [];
  final Map<Product, int> _cart = {};

  List<Product> get favorites => _favorites;
  Map<Product, int> get cart => _cart;

  void toggleFavorite(Product product) {
    if (_favorites.contains(product)) {
      _favorites.remove(product);
    } else {
      _favorites.add(product);
    }
    notifyListeners();
  }

  bool isFavorite(Product product) => _favorites.contains(product);

  void addToCart(Product product) {
    _cart.update(product, (qty) => qty + 1, ifAbsent: () => 1);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cart.remove(product);
    notifyListeners();
  }

  void incrementQty(Product product) {
    _cart[product] = (_cart[product] ?? 1) + 1;
    notifyListeners();
  }

  void decrementQty(Product product) {
    if (_cart[product]! > 1) {
      _cart[product] = _cart[product]! - 1;
    } else {
      _cart.remove(product);
    }
    notifyListeners();
  }

  double get subtotal => _cart.entries.fold(
    0.0,
        (total, item) => total + item.key.price * item.value,
  );
}

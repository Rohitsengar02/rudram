import 'package:flutter/material.dart';
import '../models/data_models.dart';

class CartItem {
  final ProductItem product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  double get totalPrice => product.currentPrice * quantity;
}

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal => _items.fold(0, (sum, item) => sum + item.totalPrice);

  double get tax => subtotal * 0.18; // 18% GST

  double get shipping => subtotal > 500 ? 0 : 50;

  double get total => subtotal + tax + shipping;

  void addItem(ProductItem product) {
    final existingIndex = _items.indexWhere(
      (item) => item.product.title == product.title,
    );

    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(CartItem(product: product));
    }
    notifyListeners();
  }

  void removeItem(ProductItem product) {
    _items.removeWhere((item) => item.product.title == product.title);
    notifyListeners();
  }

  void updateQuantity(ProductItem product, int quantity) {
    final index = _items.indexWhere(
      (item) => item.product.title == product.title,
    );

    if (index >= 0) {
      if (quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index].quantity = quantity;
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  bool isInCart(ProductItem product) {
    return _items.any((item) => item.product.title == product.title);
  }
}

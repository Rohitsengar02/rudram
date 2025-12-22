import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class OrderItem {
  final String orderNumber;
  final String date;
  final String status;
  final List<OrderProduct> items;
  final double totalAmount;

  OrderItem({
    required this.orderNumber,
    required this.date,
    required this.status,
    required this.items,
    required this.totalAmount,
  });

  Map<String, dynamic> toJson() {
    return {
      'orderNumber': orderNumber,
      'date': date,
      'status': status,
      'items': items.map((item) => item.toJson()).toList(),
      'totalAmount': totalAmount,
    };
  }

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      orderNumber: json['orderNumber'],
      date: json['date'],
      status: json['status'],
      items: (json['items'] as List)
          .map((item) => OrderProduct.fromJson(item))
          .toList(),
      totalAmount: json['totalAmount'],
    );
  }
}

class OrderProduct {
  final String title;
  final String image;
  final double price;
  final int quantity;
  final double totalPrice;

  OrderProduct({
    required this.title,
    required this.image,
    required this.price,
    required this.quantity,
    required this.totalPrice,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'image': image,
      'price': price,
      'quantity': quantity,
      'totalPrice': totalPrice,
    };
  }

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      title: json['title'],
      image: json['image'],
      price: json['price'],
      quantity: json['quantity'],
      totalPrice: json['totalPrice'],
    );
  }
}

class OrdersProvider with ChangeNotifier {
  List<OrderItem> _orders = [];
  static const String _storageKey = 'orders';

  List<OrderItem> get orders => _orders;

  OrdersProvider() {
    loadOrders();
  }

  Future<void> loadOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final String? ordersJson = prefs.getString(_storageKey);

    if (ordersJson != null) {
      final List<dynamic> decoded = json.decode(ordersJson);
      _orders = decoded.map((item) => OrderItem.fromJson(item)).toList();
      notifyListeners();
    }
  }

  Future<void> addOrder({
    required List<dynamic> cartItems,
    required double totalAmount,
  }) async {
    final orderNumber = DateTime.now().millisecondsSinceEpoch
        .toString()
        .substring(7);
    final date = DateTime.now().toString().split(' ')[0];

    // Convert cart items to order products
    final List<OrderProduct> orderProducts = cartItems.map((item) {
      return OrderProduct(
        title: item.product.title,
        image: item.product.image,
        price: item.product.currentPrice,
        quantity: item.quantity,
        totalPrice: item.totalPrice,
      );
    }).toList();

    final newOrder = OrderItem(
      orderNumber: orderNumber,
      date: date,
      status: 'Processing',
      items: orderProducts,
      totalAmount: totalAmount,
    );

    _orders.insert(0, newOrder);
    await _saveOrders();
    notifyListeners();
  }

  Future<void> _saveOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final String ordersJson = json.encode(
      _orders.map((order) => order.toJson()).toList(),
    );
    await prefs.setString(_storageKey, ordersJson);
  }

  Future<void> updateOrderStatus(String orderNumber, String newStatus) async {
    final index = _orders.indexWhere(
      (order) => order.orderNumber == orderNumber,
    );
    if (index != -1) {
      _orders[index] = OrderItem(
        orderNumber: _orders[index].orderNumber,
        date: _orders[index].date,
        status: newStatus,
        items: _orders[index].items,
        totalAmount: _orders[index].totalAmount,
      );
      await _saveOrders();
      notifyListeners();
    }
  }

  Future<void> clearOrders() async {
    _orders = [];
    await _saveOrders();
    notifyListeners();
  }
}

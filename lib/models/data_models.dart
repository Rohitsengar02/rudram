import 'package:flutter/material.dart';

class CategoryItem {
  final String title;
  final IconData icon;
  final Color color;

  CategoryItem({required this.title, required this.icon, required this.color});
}

class ProductItem {
  final String title;
  final double currentPrice;
  final double oldPrice;
  final String discount;
  final String image; // URL or Asset path
  final Color bgColor;

  ProductItem({
    required this.title,
    required this.currentPrice,
    required this.oldPrice,
    required this.discount,
    required this.image,
    this.bgColor = const Color(0xFFEEEEEE),
  });
}

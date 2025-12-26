import 'package:flutter/material.dart';

class CategoryItem {
  final String title;
  final IconData icon;
  final Color color;

  const CategoryItem({
    required this.title,
    required this.icon,
    required this.color,
  });
}

class ProductItem {
  final String title;
  final double currentPrice;
  final double oldPrice;
  final String discount;
  final String image; // URL or Asset path
  final Color bgColor;

  const ProductItem({
    required this.title,
    required this.currentPrice,
    required this.oldPrice,
    required this.discount,
    required this.image,
    this.bgColor = const Color(0xFFEEEEEE),
  });
}

final List<ProductItem> globalShopProducts = [
  ProductItem(
    title: "Royal Emerald Diamond Set",
    currentPrice: 85000.00,
    oldPrice: 125000.00,
    discount: "-32%",
    image:
        "https://images.weserv.nl/?url=https://i.pinimg.com/1200x/6a/55/96/6a55960bc89259fa0cc11bf784e1d28c.jpg",
  ),
  ProductItem(
    title: "Sapphire Drop Earrings",
    currentPrice: 42000.00,
    oldPrice: 55000.00,
    discount: "-25%",
    image:
        "https://images.weserv.nl/?url=https://i.pinimg.com/1200x/f4/05/41/f4054166dccbf42baf55d8501074b012.jpg",
  ),
  ProductItem(
    title: "Infinity Gold Bracelet",
    currentPrice: 35000.00,
    oldPrice: 45000.00,
    discount: "-22%",
    image:
        "https://images.weserv.nl/?url=https://i.pinimg.com/736x/c3/8e/3e/c38e3e93d6d993c115314b20274943fa.jpg",
  ),
  ProductItem(
    title: "Classic Solitaire Ring",
    currentPrice: 95000.00,
    oldPrice: 110000.00,
    discount: "-15%",
    image:
        "https://images.weserv.nl/?url=https://i.pinimg.com/736x/0f/5f/1a/0f5f1a0cc6a898a8b23e72fb2b1a087f.jpg",
  ),
  ProductItem(
    title: "Rose Gold Pendant",
    currentPrice: 28000.00,
    oldPrice: 35000.00,
    discount: "-20%",
    image:
        "https://images.weserv.nl/?url=https://i.pinimg.com/736x/36/dc/71/36dc71af1ca7f5c4a8fdfe73bbb688b1.jpg",
  ),
  ProductItem(
    title: "Bridal Meenakari Set",
    currentPrice: 125000.00,
    oldPrice: 155000.00,
    discount: "-19%",
    image:
        "https://images.weserv.nl/?url=https://i.pinimg.com/736x/54/26/f3/5426f37ee3738c45aa2e07091c6ea709.jpg",
  ),
  ProductItem(
    title: "Diamond Stud Earrings",
    currentPrice: 15000.00,
    oldPrice: 25000.00,
    discount: "-40%",
    image:
        "https://images.weserv.nl/?url=https://i.pinimg.com/1200x/a2/d1/53/a2d153c12d7c1216c406500543686ceb.jpg",
  ),
  ProductItem(
    title: "Gold Choker Necklace",
    currentPrice: 45000.00,
    oldPrice: 60000.00,
    discount: "-25%",
    image:
        "https://images.weserv.nl/?url=https://i.pinimg.com/1200x/55/5f/81/555f8192d281f652159bbf59a2bb673c.jpg",
  ),
  ProductItem(
    title: "Pearl Drop Necklace",
    currentPrice: 22000.00,
    oldPrice: 30000.00,
    discount: "-26%",
    image:
        "https://images.weserv.nl/?url=https://i.pinimg.com/736x/22/86/e4/2286e4e7c09d91ebc9a9169e1bcd069d.jpg",
  ),
];

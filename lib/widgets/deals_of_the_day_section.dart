import 'dart:async';
import 'package:flutter/material.dart';
import '../models/data_models.dart';
import '../utils/app_colors.dart';
import 'product_card.dart';

class DealsOfTheDaySection extends StatefulWidget {
  const DealsOfTheDaySection({super.key});

  @override
  State<DealsOfTheDaySection> createState() => _DealsOfTheDaySectionState();
}

class _DealsOfTheDaySectionState extends State<DealsOfTheDaySection> {
  late Timer _timer;
  Duration _timeLeft = const Duration(hours: 5, minutes: 23, seconds: 45);

  final List<ProductItem> products = [
    ProductItem(
      title: "Ruby Heart Pendant",
      currentPrice: 55000,
      oldPrice: 78000,
      discount: "29% Off",
      image:
          "https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/4_a7e9t3.jpg",
      bgColor: const Color(0xFFDC143C), // Crimson
    ),
    ProductItem(
      title: "Sapphire Ring Set",
      currentPrice: 145000,
      oldPrice: 189000,
      discount: "23% Off",
      image:
          "https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/6_mu5hap.jpg",
      bgColor: const Color(0xFF0F52BA), // Sapphire
    ),
    ProductItem(
      title: "Gold Kada Bracelet",
      currentPrice: 125000,
      oldPrice: 155000,
      discount: "19% Off",
      image:
          "https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/1_x3dvkl.jpg",
      bgColor: const Color(0xFFDAA520), // Goldenrod
    ),
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft.inSeconds > 0) {
        setState(() {
          _timeLeft = _timeLeft - const Duration(seconds: 1);
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(duration.inHours)}:${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              Icon(Icons.local_fire_department, color: Colors.orange, size: 24),
              const SizedBox(width: 8),
              const Text(
                "Deals of the Day",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF6B6B),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _formatDuration(_timeLeft),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 270,
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 16),
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductCard(product: products[index]);
            },
          ),
        ),
      ],
    );
  }
}

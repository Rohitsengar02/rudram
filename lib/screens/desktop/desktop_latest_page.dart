import 'package:flutter/material.dart';
import '../../widgets/desktop/desktop_header.dart';
import '../../widgets/desktop/desktop_footer_section.dart';

class DesktopLatestPage extends StatelessWidget {
  const DesktopLatestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const DesktopHeader(),
            _buildNewsSection(),
            const DesktopFooterSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsSection() {
    return Padding(
      padding: const EdgeInsets.all(80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "NEW DESIGNS",
            style: TextStyle(letterSpacing: 4, color: Colors.blueAccent),
          ),
          const SizedBox(height: 20),
          const Text(
            "Latest at Rudram",
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 50),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            separatorBuilder: (context, index) => const Divider(height: 60),
            itemBuilder: (context, index) => _buildArticleRow(index),
          ),
        ],
      ),
    );
  }

  Widget _buildArticleRow(int index) {
    final titles = [
      "The 2026 Spring Collection",
      "Gold Market Trends: A Report",
      "Craftsmanship in the Modern Era",
    ];
    return Row(
      children: [
        Container(
          width: 300,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(width: 40),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titles[index],
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                "Explore the latest updates and launches from the heart of our design studio. Every piece tells a story of heritage and innovation.",
                style: TextStyle(color: Colors.grey, height: 1.6),
              ),
              const SizedBox(height: 20),
              const Text(
                "Read More →",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../../widgets/desktop/desktop_header.dart';
import '../../widgets/desktop/desktop_footer_section.dart';

class DesktopInfoPage extends StatelessWidget {
  const DesktopInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const DesktopHeader(),
            _buildAboutHeader(),
            _buildInfoContent(),
            const DesktopFooterSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutHeader() {
    return Container(
      color: const Color(0xFFF8F9FA),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 100),
      child: const Column(
        children: [
          Text(
            "OUR STORY",
            style: TextStyle(letterSpacing: 4, color: Colors.grey),
          ),
          SizedBox(height: 20),
          Text(
            "Heritage & Trust",
            style: TextStyle(fontSize: 52, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoContent() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 80, horizontal: 100),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              "At Rudram Jewels, we believe in the timeless beauty of handcrafted excellence. For decades, our artisans have poured their skill and passion into creating masterpieces that define generations.",
              style: TextStyle(
                fontSize: 18,
                height: 1.8,
                color: Colors.black87,
              ),
            ),
          ),
          SizedBox(width: 100),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Our Values",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  "• Uncompromising Purity\n• Ethical Sourcing\n• Master Craftsmanship\n• Lifetime Support",
                  style: TextStyle(
                    fontSize: 16,
                    height: 2.2,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

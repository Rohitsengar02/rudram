import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class DesktopOurFeaturesSection extends StatelessWidget {
  const DesktopOurFeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 100),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildFeatureItem(
            icon: Icons.verified_outlined,
            title: '100% Certified',
            subtitle: 'Available with every purchase',
          ),
          _buildDivider(),
          _buildFeatureItem(
            icon: Icons.local_shipping_outlined,
            title: 'Free Shipping',
            subtitle: 'On all orders above ₹5000',
          ),
          _buildDivider(),
          _buildFeatureItem(
            icon: Icons.change_circle_outlined,
            title: 'Easy Exchange',
            subtitle: '10 Days hassle-free exchange',
          ),
          _buildDivider(),
          _buildFeatureItem(
            icon: Icons.support_agent_outlined,
            title: 'Lifetime Support',
            subtitle: 'Dedicated support for you',
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(height: 60, width: 1, color: Colors.grey[300]);
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primaryOrange.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.primaryOrange, size: 32),
        ),
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 8),
        Text(subtitle, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
      ],
    );
  }
}

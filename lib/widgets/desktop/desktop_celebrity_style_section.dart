import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../screens/shop_screen.dart';

class DesktopCelebrityStyleSection extends StatelessWidget {
  const DesktopCelebrityStyleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 100),
      color: const Color(0xFFFAF9F6),
      child: Column(
        children: [
          const Text(
            'As Seen On Celebrities',
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Stars shining brighter with Rudram Jewels',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
          const SizedBox(height: 60),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.7,
              crossAxisSpacing: 30,
              mainAxisSpacing: 30,
            ),
            itemCount: 3,
            itemBuilder: (context, index) {
              return _buildCelebrityCard(context, index);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCelebrityCard(BuildContext context, int index) {
    final celebs = [
      {
        'name': 'Deepika Padukone',
        'event': 'Cannes Film Festival',
        'image':
            'https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/5_lf1dgq.jpg',
      },
      {
        'name': 'Priyanka Chopra',
        'event': 'Met Gala After Party',
        'image':
            'https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/6_mu5hap.jpg',
      },
      {
        'name': 'Alia Bhatt',
        'event': 'Awards Night',
        'image':
            'https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/3_i5pjnq.jpg',
      },
    ];
    final item = celebs[index];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ShopScreen()),
        );
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: NetworkImage(item['image']!),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                stops: const [0.6, 1.0],
              ),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name']!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item['event']!,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

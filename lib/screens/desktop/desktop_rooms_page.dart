import 'package:flutter/material.dart';
import '../../widgets/desktop/desktop_header.dart';
import '../../widgets/desktop/desktop_footer_section.dart';

class DesktopRoomsPage extends StatelessWidget {
  const DesktopRoomsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const DesktopHeader(),
            _buildHero(),
            _buildRoomGrid(),
            const DesktopFooterSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHero() {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            "https://images.weserv.nl/?url=https://i.pinimg.com/1200x/bc/62/77/bc627798725bb482061030e2003c2602.jpg",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        color: Colors.black26,
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "THE VIRTUAL SHOWROOM",
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 4,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Exquisite Rooms",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 52,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoomGrid() {
    final rooms = [
      {
        'name': 'The Bridal Lounge',
        'image':
            'https://images.weserv.nl/?url=https://i.pinimg.com/1200x/f1/44/1a/f1441a7748881f148d28a50995c72e21.jpg',
      },
      {
        'name': 'Diamond Vault',
        'image':
            'https://images.weserv.nl/?url=https://i.pinimg.com/1200x/54/26/f3/5426f37ee3738c45aa2e07091c6ea709.jpg',
      },
      {
        'name': 'Vintage Gallery',
        'image':
            'https://images.weserv.nl/?url=https://i.pinimg.com/1200x/3b/68/7d/3b687d608827725895786ed8e330058b.jpg',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 80),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 30,
          mainAxisSpacing: 30,
          childAspectRatio: 0.8,
        ),
        itemCount: rooms.length,
        itemBuilder: (context, index) => Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(rooms[index]['image']!, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              rooms[index]['name']!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

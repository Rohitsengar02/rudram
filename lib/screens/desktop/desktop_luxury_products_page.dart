import 'package:flutter/material.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import '../../models/data_models.dart';
import '../../widgets/desktop/desktop_header.dart';
import '../../widgets/desktop/desktop_footer_section.dart';
import 'desktop_product_detail_page.dart';

class DesktopLuxuryProductsPage extends StatefulWidget {
  const DesktopLuxuryProductsPage({super.key});

  @override
  State<DesktopLuxuryProductsPage> createState() =>
      _DesktopLuxuryProductsPageState();
}

class _DesktopLuxuryProductsPageState extends State<DesktopLuxuryProductsPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  final List<ProductItem> luxuryProducts = [
    const ProductItem(
      title: "Royal Emerald Diamond Set",
      currentPrice: 85000.00,
      oldPrice: 125000.00,
      discount: "-32%",
      image:
          "https://images.weserv.nl/?url=https://i.pinimg.com/1200x/6a/55/96/6a55960bc89259fa0cc11bf784e1d28c.jpg",
    ),
    const ProductItem(
      title: "Bridal Meenakari Set",
      currentPrice: 125000.00,
      oldPrice: 155000.00,
      discount: "-19%",
      image:
          "https://images.weserv.nl/?url=https://i.pinimg.com/736x/54/26/f3/5426f37ee3738c45aa2e07091c6ea709.jpg",
    ),
    const ProductItem(
      title: "Classic Solitaire Ring",
      currentPrice: 95000.00,
      oldPrice: 110000.00,
      discount: "-15%",
      image:
          "https://images.weserv.nl/?url=https://i.pinimg.com/736x/0f/5f/1a/0f5f1a0cc6a898a8b23e72fb2b1a087f.jpg",
    ),
    const ProductItem(
      title: "Sapphire Drop Earrings",
      currentPrice: 42000.00,
      oldPrice: 55000.00,
      discount: "-25%",
      image:
          "https://images.weserv.nl/?url=https://i.pinimg.com/1200x/f4/05/41/f4054166dccbf42baf55d8501074b012.jpg",
    ),
    const ProductItem(
      title: "Gold Choker Necklace",
      currentPrice: 45000.00,
      oldPrice: 60000.00,
      discount: "-25%",
      image:
          "https://images.weserv.nl/?url=https://i.pinimg.com/1200x/55/5f/81/555f8192d281f652159bbf59a2bb673c.jpg",
    ),
    const ProductItem(
      title: "Infinity Gold Bracelet",
      currentPrice: 35000.00,
      oldPrice: 45000.00,
      discount: "-22%",
      image:
          "https://images.weserv.nl/?url=https://i.pinimg.com/736x/c3/8e/3e/c38e3e93d6d993c115314b20274943fa.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // Dark Luxury Background
      body: WebSmoothScroll(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              const DesktopHeader(),

              // Luxury Hero Section
              Container(
                width: double.infinity,
                height: 500,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://images.weserv.nl/?url=https://i.pinimg.com/1200x/71/34/04/713404787d5ac88c7d7e63b355d0e882.jpg",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        const Color(0xFF0F172A),
                        const Color(0xFF0F172A).withOpacity(0.3),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "THE ROYAL SELECTION",
                          style: TextStyle(
                            fontSize: 16,
                            letterSpacing: 8,
                            color: Color(0xFFE2E8F0),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Luxury Redefined",
                          style: TextStyle(
                            fontSize: 64,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Playfair Display', // Premium font feel
                          ),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 15,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 1),
                          ),
                          child: const Text(
                            "EXPLORE MASTERPIECES",
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 2,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Products Grid
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 80,
                  vertical: 80,
                ),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Text(
                          "Curated Collections",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Total 06 Items",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 60),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.8,
                            crossAxisSpacing: 40,
                            mainAxisSpacing: 60,
                          ),
                      itemCount: luxuryProducts.length,
                      itemBuilder: (context, index) {
                        return _LuxuryProductCard(
                          product: luxuryProducts[index],
                        );
                      },
                    ),
                  ],
                ),
              ),

              const DesktopFooterSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class _LuxuryProductCard extends StatefulWidget {
  final ProductItem product;
  const _LuxuryProductCard({required this.product});

  @override
  State<_LuxuryProductCard> createState() => _LuxuryProductCardState();
}

class _LuxuryProductCardState extends State<_LuxuryProductCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DesktopProductDetailPage(product: widget.product),
          ),
        );
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: [
                    if (_isHovered)
                      BoxShadow(
                        color: Colors.white.withOpacity(0.05),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      AnimatedScale(
                        duration: const Duration(milliseconds: 1000),
                        scale: _isHovered ? 1.05 : 1.0,
                        child: Image.network(
                          widget.product.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                      if (_isHovered)
                        Container(color: Colors.black.withOpacity(0.2)),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 300),
                          opacity: _isHovered ? 1.0 : 0.0,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            color: Colors.white,
                            child: const Text(
                              "VIEW DETAIL",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Text(
              widget.product.title,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontFamily: 'Playfair Display',
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "₹${widget.product.currentPrice.toInt()}",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xFFCBD5E1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 15),
                Text(
                  "₹${widget.product.oldPrice.toInt()}",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

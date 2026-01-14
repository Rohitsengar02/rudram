import 'package:flutter/material.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';
import '../../models/data_models.dart';
import '../../widgets/desktop/desktop_header.dart';
import 'desktop_product_detail_page.dart';

class DesktopShopPage extends StatefulWidget {
  const DesktopShopPage({super.key});

  @override
  State<DesktopShopPage> createState() => _DesktopShopPageState();
}

class _DesktopShopPageState extends State<DesktopShopPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late ScrollController _scrollController;
  final List<ProductItem> shopProducts = [
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

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animationController.forward();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: WebSmoothScroll(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              // Header
              const DesktopHeader(),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Sidebar - 2/8 Flex with Ultra-Soft Static UI
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        border: Border(
                          right: BorderSide(color: Colors.grey.shade50),
                        ),
                      ),
                      padding: const EdgeInsets.only(
                        left: 30,
                        right: 20,
                        bottom: 40,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 30),
                              child: Text(
                                "Filters",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF405870),
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            _buildListFilter("Categories", [
                              "Gold Jewelry",
                              "Diamond Collection",
                              "Silver Articles",
                              "Gemstone Special",
                            ]),
                            _buildPriceFilter(),
                            _buildListFilter("Occasion", [
                              "Bridal",
                              "Casual Wear",
                              "Party Wear",
                              "Office Wear",
                            ]),
                            _buildListFilter("Gender", [
                              "Women",
                              "Men",
                              "Unisex",
                              "Kids",
                            ]),
                            _buildListFilter("Collections", [
                              "Royal",
                              "Minimalist",
                              "Antique",
                              "Modern",
                            ]),
                            _buildListFilter("Metal Purity", [
                              "14K Gold",
                              "18K Gold",
                              "22K Gold",
                              "24K Gold",
                            ]),
                            _buildListFilter("Gemstone Type", [
                              "Diamond",
                              "Emerald",
                              "Ruby",
                              "Pearl",
                              "Sapphire",
                            ]),
                            _buildColorFilter(),
                            _buildListFilter("Availability", [
                              "In Stock",
                              "New Arrivals",
                              "Pre-Order",
                            ]),
                            _buildRatingFilter(),
                            _buildDiscountFilter(),
                            const SizedBox(height: 50),
                            Container(
                              width: double.infinity,
                              height: 54,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(
                                      0xFF4F46E5,
                                    ).withOpacity(0.1),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF4F46E5),
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: const Text(
                                  "APPLY FILTER",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Right Content - 70% Flex
                  Expanded(
                    flex: 8,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Banner with Image (No Text)
                          Container(
                            width: double.infinity,
                            height: 200,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0F0F0),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Image.network(
                              "https://images.weserv.nl/?url=https://i.pinimg.com/1200x/18/22/ee/1822eef2f6cc34174e52b9d9e6857d33.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),

                          const SizedBox(height: 40),

                          // Toolbar
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  _toolbarIcon(Icons.grid_view_rounded, true),
                                  const SizedBox(width: 10),
                                  _toolbarIcon(Icons.list_rounded, false),
                                ],
                              ),
                              const Text(
                                "SHOWING 1-9 OF 32 RESULTS",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Row(
                                  children: [
                                    Text(
                                      "Sort by: Default",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Icon(Icons.keyboard_arrow_down, size: 16),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 30),

                          // Product Grid with Bottom-to-Top Animation (4 Columns)
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  childAspectRatio: 0.72,
                                  crossAxisSpacing: 25,
                                  mainAxisSpacing: 35,
                                ),
                            itemCount: shopProducts.length,
                            itemBuilder: (context, index) {
                              return _buildAnimatedProductCard(
                                index,
                                shopProducts[index],
                              );
                            },
                          ),

                          const SizedBox(height: 60),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListFilter(String title, List<String> items) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF405870),
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 15),
          ...items
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: InkWell(
                    onTap: () {},
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF94A3B8), // Soft slate
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
          const SizedBox(height: 10),
          Divider(color: const Color(0xFFF1F5F9), thickness: 0.5),
        ],
      ),
    );
  }

  Widget _buildPriceFilter() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Price",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF405870),
                ),
              ),
              Text(
                "₹50,000",
                style: TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: const Color(0xFF818CF8), // Softer indigo
              inactiveTrackColor: const Color(0xFFF1F5F9),
              thumbColor: Colors.white,
              overlayColor: const Color(0xFF818CF8).withOpacity(0.1),
              trackHeight: 3,
            ),
            child: RangeSlider(
              values: const RangeValues(0, 100000),
              max: 100000,
              onChanged: (values) {},
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "₹0",
                style: TextStyle(fontSize: 10, color: Color(0xFFCBD5E1)),
              ),
              Text(
                "₹100k",
                style: TextStyle(fontSize: 10, color: Color(0xFFCBD5E1)),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Divider(color: const Color(0xFFF1F5F9), thickness: 0.5),
        ],
      ),
    );
  }

  Widget _buildColorFilter() {
    final colors = [
      {"name": "Gold", "color": const Color(0xFFFFD700)},
      {"name": "Rose Gold", "color": const Color(0xFFB76E79)},
      {"name": "Silver", "color": const Color(0xFFC0C0C0)},
      {"name": "White gold", "color": const Color(0xFFF5F5F5)},
    ];

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Colors",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF405870),
            ),
          ),
          const SizedBox(height: 10),
          ...colors
              .map(
                (c) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 24,
                        width: 24,
                        child: Checkbox(
                          value: c['name'] == "Gold",
                          onChanged: (v) {},
                          activeColor: const Color(0xFF818CF8),
                          side: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: c['color'] as Color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        c['name'] as String,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
          const SizedBox(height: 15),
          Divider(color: const Color(0xFFF1F5F9), thickness: 0.5),
        ],
      ),
    );
  }

  Widget _buildRatingFilter() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Customer Rating",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF405870),
            ),
          ),
          const SizedBox(height: 10),
          ...List.generate(
            5,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                children: [
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: Radio(
                      value: 5 - index,
                      groupValue: 5,
                      onChanged: (v) {},
                      activeColor: const Color(0xFF818CF8),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Row(
                    children: List.generate(
                      5,
                      (i) => Icon(
                        Icons.star,
                        size: 14,
                        color: i < (5 - index)
                            ? const Color(0xFFFCD34D)
                            : const Color(0xFFF1F5F9),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          Divider(color: const Color(0xFFF1F5F9), thickness: 0.5),
        ],
      ),
    );
  }

  Widget _buildDiscountFilter() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Discount",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF405870),
            ),
          ),
          const SizedBox(height: 10),
          ...[
                "50% or more",
                "40% or more",
                "30% or more",
                "20% or more",
                "10% or more",
              ]
              .map(
                (d) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 24,
                        width: 24,
                        child: Radio(
                          value: d,
                          groupValue: "30% or more",
                          onChanged: (v) {},
                          activeColor: const Color(0xFF818CF8),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        d,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }

  Widget _toolbarIcon(IconData icon, bool isActive) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.white,
        border: Border.all(
          color: isActive ? Colors.black : Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Icon(
        icon,
        size: 18,
        color: isActive ? Colors.white : Colors.black54,
      ),
    );
  }

  Widget _buildAnimatedProductCard(int index, ProductItem product) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final progress = CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            (index * 0.05).clamp(0.0, 0.5),
            (index * 0.05 + 0.5).clamp(0.0, 1.0),
            curve: Curves.easeOutCubic,
          ),
        ).value;

        return Opacity(
          opacity: progress,
          child: Transform.translate(
            offset: Offset(0, 50 * (1 - progress)),
            child: _DesktopShopProductCard(product: product),
          ),
        );
      },
    );
  }
}

class _DesktopShopProductCard extends StatefulWidget {
  final ProductItem product;

  const _DesktopShopProductCard({required this.product});

  @override
  State<_DesktopShopProductCard> createState() =>
      _DesktopShopProductCardState();
}

class _DesktopShopProductCardState extends State<_DesktopShopProductCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                DesktopProductDetailPage(product: widget.product),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  const begin = Offset(0.0, 0.05);
                  const end = Offset.zero;
                  const curve = Curves.easeOutCubic;

                  var slideTween = Tween(
                    begin: begin,
                    end: end,
                  ).chain(CurveTween(curve: curve));
                  var fadeTween = Tween(
                    begin: 0.0,
                    end: 1.0,
                  ).chain(CurveTween(curve: curve));

                  return FadeTransition(
                    opacity: animation.drive(fadeTween),
                    child: SlideTransition(
                      position: animation.drive(slideTween),
                      child: child,
                    ),
                  );
                },
            transitionDuration: const Duration(milliseconds: 600),
          ),
        );
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: Column(
            children: [
              // Image Box
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      Hero(
                        tag: 'product_${widget.product.image}',
                        child: Image.network(
                          widget.product.image,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Center(
                                child: Icon(Icons.image_outlined, size: 40),
                              ),
                        ),
                      ),
                      if (_isHovered)
                        Positioned.fill(
                          child: Container(
                            color: Colors.black.withOpacity(0.05),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // Product Info
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  children: [
                    Text(
                      widget.product.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF757575),
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "₹${widget.product.currentPrice.toInt()}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          widget.product.discount,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF4F46E5),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "₹${widget.product.oldPrice.toInt()}",
                          style: const TextStyle(
                            fontSize: 13,
                            decoration: TextDecoration.lineThrough,
                            color: Color(0xFFBDBDBD),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

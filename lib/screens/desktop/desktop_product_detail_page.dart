import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../models/data_models.dart';
import '../../widgets/desktop/desktop_header.dart';
import 'desktop_checkout_page.dart';

enum ProductViewMode { gallery, carousel, video }

class DesktopProductDetailPage extends StatefulWidget {
  final ProductItem product;
  const DesktopProductDetailPage({super.key, required this.product});

  @override
  State<DesktopProductDetailPage> createState() =>
      _DesktopProductDetailPageState();
}

class _DesktopProductDetailPageState extends State<DesktopProductDetailPage> {
  late String _selectedImage;
  late List<String> _galleryImages;
  ProductViewMode _currentMode = ProductViewMode.gallery;
  bool _isCartOpen = false;
  final List<ProductItem> _cartItems = [];

  void _addToCart(ProductItem product) {
    setState(() {
      _cartItems.add(product);
      _isCartOpen = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedImage = widget.product.image;
    _galleryImages = [
      widget.product.image,
      "https://images.weserv.nl/?url=https://i.pinimg.com/1200x/6a/55/96/6a55960bc89259fa0cc11bf784e1d28c.jpg",
      "https://images.weserv.nl/?url=https://i.pinimg.com/1200x/f4/05/41/f4054166dccbf42baf55d8501074b012.jpg",
      "https://images.weserv.nl/?url=https://i.pinimg.com/736x/c3/8e/3e/c38e3e93d6d993c115314b20274943fa.jpg",
      "https://images.weserv.nl/?url=https://i.pinimg.com/736x/0f/5f/1a/0f5f1a0cc6a898a8b23e72fb2b1a087f.jpg",
      "https://images.weserv.nl/?url=https://i.pinimg.com/736x/36/dc/71/36dc71af1ca7f5c4a8fdfe73bbb688b1.jpg",
      "https://images.weserv.nl/?url=https://i.pinimg.com/736x/54/26/f3/5426f37ee3738c45aa2e07091c6ea709.jpg",
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                DesktopHeader(
                  cartCount: _cartItems.length,
                  onCartTap: () => setState(() => _isCartOpen = true),
                ),
                _ProductHeroSection(
                  product: widget.product,
                  selectedImage: _selectedImage,
                  galleryImages: _galleryImages,
                  currentMode: _currentMode,
                  onImageSelected: (img) {
                    setState(() {
                      _selectedImage = img;
                      _currentMode = ProductViewMode.gallery;
                    });
                  },
                  onModeChanged: (mode) {
                    setState(() {
                      _currentMode = mode;
                    });
                  },
                  onAddToCart: () => _addToCart(widget.product),
                ),
                const _ProductStudioGallery(),
                const _ProductTabsSection(),
                const SizedBox(height: 100),
                const _ProductCarouselSection(
                  title: "YOU MAY ALSO LIKE",
                  subtitle: "Related Masterpieces",
                ),
                const SizedBox(height: 100),
                const _ProductCarouselSection(
                  title: "BEST SELLERS",
                  subtitle: "Most Loved Masterpieces",
                ),
                const SizedBox(height: 100),
                const _ProductCarouselSection(
                  title: "NEW ARRIVALS",
                  subtitle: "Freshly Crafted Treasures",
                ),
                const SizedBox(height: 100),
                const _ProductCarouselSection(
                  title: "TRENDING NOW",
                  subtitle: "The Season's Favorites",
                ),
                const SizedBox(height: 100),
                const _ProductCarouselSection(
                  title: "RECENTLY VIEWED",
                  subtitle: "Pick Up Where You Left Off",
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),

          // Custom Dimmer Overlay
          if (_isCartOpen)
            GestureDetector(
              onTap: () => setState(() => _isCartOpen = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                color: Colors.black.withOpacity(0.3),
              ),
            ),

          // Slide-in Cart Sidebar
          AnimatedPositioned(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutCubic,
            right: _isCartOpen ? 0 : -450,
            top: 0,
            bottom: 0,
            child: _CartSidebar(
              items: _cartItems,
              onClose: () => setState(() => _isCartOpen = false),
              onRemove: (product) {
                setState(() {
                  _cartItems.remove(product);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductHeroSection extends StatelessWidget {
  final ProductItem product;
  final String selectedImage;
  final List<String> galleryImages;
  final ProductViewMode currentMode;
  final Function(String) onImageSelected;
  final Function(ProductViewMode) onModeChanged;
  final VoidCallback onAddToCart;

  const _ProductHeroSection({
    required this.product,
    required this.selectedImage,
    required this.galleryImages,
    required this.currentMode,
    required this.onImageSelected,
    required this.onModeChanged,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    // Find next product
    int currentIndex = globalShopProducts.indexWhere(
      (p) => p.title == product.title,
    );
    ProductItem nextProduct =
        globalShopProducts[(currentIndex + 1) % globalShopProducts.length];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
      color: const Color(0xFFFBFBFF),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Far Left Vertical Sidebar
              _buildVerticalSidebar(),

              const SizedBox(width: 50),

              // 2. Left Side: Mode Toggles + Display Area
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    // Mode Toggle Pill
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildModeButton("GALLERY", ProductViewMode.gallery),
                          _buildModeButton(
                            "360° VIEW",
                            ProductViewMode.carousel,
                          ),
                          _buildModeButton(
                            "WATCH VIDEO",
                            ProductViewMode.video,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Dynamic Display Area
                    _buildDynamicDisplay(),

                    const SizedBox(height: 25),

                    // Only show thumbnails in Gallery Mode
                    if (currentMode == ProductViewMode.gallery)
                      _buildThumbnails(),
                  ],
                ),
              ),

              const SizedBox(width: 80),

              // 3. Right Content Side
              Expanded(flex: 5, child: _buildDetailedProductInfo(context)),
            ],
          ),

          // Next Product Floating Card
        ],
      ),
    );
  }

  Widget _buildNextProductCard(BuildContext context, ProductItem product) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, anim, secAnim) =>
                DesktopProductDetailPage(product: product),
            transitionsBuilder: (context, anim, secAnim, child) {
              return FadeTransition(opacity: anim, child: child);
            },
          ),
        );
      },
      child: Container(
        width: 220,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(product.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "NEXT PRODUCT",
                    style: TextStyle(
                      fontSize: 9,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF818CF8),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "₹${product.currentPrice.toInt()}",
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildModeButton(String label, ProductViewMode mode) {
    final isSelected = currentMode == mode;
    return GestureDetector(
      onTap: () => onModeChanged(mode),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF818CF8) : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            color: isSelected ? Colors.white : Colors.grey.shade400,
          ),
        ),
      ),
    );
  }

  Widget _buildDynamicDisplay() {
    switch (currentMode) {
      case ProductViewMode.gallery:
        return _buildMainImage();
      case ProductViewMode.carousel:
        return _buildVerticalCarousel();
      case ProductViewMode.video:
        return _buildVideoPlaceholder();
    }
  }

  Widget _buildMainImage() {
    return Hero(
      tag: 'product_${product.image}',
      child: Container(
        height: 450,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Image.network(selectedImage, fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildVerticalCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 450,
        viewportFraction: 0.9,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        scrollDirection: Axis.vertical,
        enlargeCenterPage: true,
      ),
      items: galleryImages.map((img) {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.network(img, fit: BoxFit.cover),
        );
      }).toList(),
    );
  }

  Widget _buildVideoPlaceholder() {
    return Container(
      height: 450,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.network(
            product.image,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            opacity: const AlwaysStoppedAnimation(0.4),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.play_arrow_rounded,
                  size: 60,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "LOADING PRODUCT VIDEO...",
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 2,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildThumbnails() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: galleryImages.length,
        itemBuilder: (context, index) {
          final img = galleryImages[index];
          final isSelected = img == selectedImage;
          return GestureDetector(
            onTap: () => onImageSelected(img),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 100,
              margin: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF818CF8)
                      : Colors.transparent,
                  width: 2,
                ),
                boxShadow: [
                  if (isSelected)
                    BoxShadow(
                      color: const Color(0xFF818CF8).withOpacity(0.2),
                      blurRadius: 10,
                    ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.network(img, fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }

  Widget _buildVerticalSidebar() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _verticalText("100% natural"),
        const SizedBox(height: 40),
        _verticalText("no side effect"),
        const SizedBox(height: 40),
        _verticalText("healthy"),
        const SizedBox(height: 80),
        const Icon(Icons.share, size: 18, color: Colors.black54),
        const SizedBox(height: 20),
        const Text(
          "f",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 20),
        const Icon(Icons.alternate_email, size: 18, color: Colors.black54),
      ],
    );
  }

  Widget _verticalText(String text) {
    return RotatedBox(
      quarterTurns: 3,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black38,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildDetailedProductInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "PREMIUM COLLECTION",
          style: TextStyle(
            fontSize: 12,
            letterSpacing: 3,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF818CF8).withOpacity(0.8),
          ),
        ),
        const SizedBox(height: 15),
        Text(
          product.title.toUpperCase(),
          style: const TextStyle(
            fontSize: 48,
            fontFamily: 'Serif',
            fontWeight: FontWeight.w900,
            color: Color(0xFF1E293B),
            height: 1.1,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Row(
              children: List.generate(
                5,
                (index) => Icon(
                  Icons.star_rounded,
                  size: 20,
                  color: index < 4
                      ? const Color(0xFFFBBF24)
                      : Colors.grey.shade300,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              "4.8 (124 reviews)",
              style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Text(
          "Masterfully designed with precision and soul. This piece embodies the perfect harmony of contemporary elegance and timeless craftsmanship, making it a definitive staple for your personal collection.",
          style: TextStyle(
            fontSize: 16,
            color: const Color(0xFF64748B),
            height: 1.8,
          ),
        ),
        const SizedBox(height: 40),
        Text(
          "₹${product.currentPrice.toInt()}",
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 40),
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                "ADD TO CART",
                const Color(0xFF818CF8),
                Colors.white,
                Icons.shopping_bag_outlined,
                onTap: onAddToCart,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _buildActionButton(
                "BUY NOW",
                const Color(0xFF1E293B),
                Colors.white,
                Icons.bolt_rounded,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DesktopCheckoutPage(cartItems: [product]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 50),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _buildTag("Handmade"),
            _buildTag("Limited Edition"),
            _buildTag("Ethical Gold"),
            _buildTag("Certified"),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(
    String label,
    Color bg,
    Color text,
    IconData icon, {
    VoidCallback? onTap,
  }) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: bg.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: onTap ?? () {},
        icon: Icon(icon, size: 20),
        label: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: text,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  Widget _buildTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Text(
        "# $label",
        style: const TextStyle(
          fontSize: 12,
          color: Color(0xFF94A3B8),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _ProductStudioGallery extends StatelessWidget {
  const _ProductStudioGallery();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 100),
      child: Column(
        children: [
          // Gallery Header
          Column(
            children: [
              Text(
                "STUDIO DISCOVERY",
                style: TextStyle(
                  fontSize: 12,
                  letterSpacing: 4,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF818CF8).withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                "Capturing the Essence of Luxury",
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: 'Serif',
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 80),

          // Masonry Gallery Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Column 1
              Expanded(
                child: Column(
                  children: [
                    _GalleryItem(
                      url:
                          "https://images.weserv.nl/?url=https://i.pinimg.com/736x/54/26/f3/5426f37ee3738c45aa2e07091c6ea709.jpg",
                      title: "PRECISION CUT",
                      subtitle: "The art of perfect symmetry",
                      height: 400,
                    ),
                    const SizedBox(height: 40),
                    _GalleryItem(
                      url:
                          "https://images.weserv.nl/?url=https://i.pinimg.com/1200x/6a/55/96/6a55960bc89259fa0cc11bf784e1d28c.jpg",
                      title: "TIMELESS GOLD",
                      subtitle: "Meticulously hand-rolled 24K gold",
                      height: 550,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 40),
              // Column 2
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 60), // Offset for masonry feel
                    _GalleryItem(
                      url:
                          "https://images.weserv.nl/?url=https://i.pinimg.com/1200x/22/86/e4/2286e4e7c09d91ebc9a9169e1bcd069d.jpg",
                      title: "ARTISAN TOUCH",
                      subtitle: "Crafting stories into metal",
                      height: 600,
                    ),
                    const SizedBox(height: 40),
                    _GalleryItem(
                      url:
                          "https://images.weserv.nl/?url=https://i.pinimg.com/1200x/a2/d1/53/a2d153c12d7c1216c406500543686ceb.jpg",
                      title: "MACRO DETAIL",
                      subtitle: "Seeing the invisible beauty",
                      height: 450,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 40),
              // Column 3
              Expanded(
                child: Column(
                  children: [
                    _GalleryItem(
                      url:
                          "https://images.weserv.nl/?url=https://i.pinimg.com/1200x/55/5f/81/555f8192d281f652159bbf59a2bb673c.jpg",
                      title: "LIFESTYLE",
                      subtitle: "Elegance for every moment",
                      height: 500,
                    ),
                    const SizedBox(height: 40),
                    _GalleryItem(
                      url:
                          "https://images.weserv.nl/?url=https://i.pinimg.com/736x/54/26/f3/5426f37ee3738c45aa2e07091c6ea709.jpg",
                      title: "VINTAGE SOUL",
                      subtitle: "Traditional patterns re-imagined",
                      height: 350,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GalleryItem extends StatefulWidget {
  final String url;
  final String title;
  final String subtitle;
  final double height;

  const _GalleryItem({
    required this.url,
    required this.title,
    required this.subtitle,
    required this.height,
  });

  @override
  State<_GalleryItem> createState() => _GalleryItemState();
}

class _GalleryItemState extends State<_GalleryItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            height: widget.height,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(isHovered ? 0.08 : 0.03),
                  blurRadius: isHovered ? 40 : 20,
                  offset: Offset(0, isHovered ? 20 : 10),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                AnimatedScale(
                  scale: isHovered ? 1.05 : 1.0,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOutCubic,
                  child: Image.network(
                    widget.url,
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                ),
                if (isHovered)
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.3),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 10,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
              color: Color(0xFF818CF8),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            widget.subtitle,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF475569),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductTabsSection extends StatefulWidget {
  const _ProductTabsSection();

  @override
  State<_ProductTabsSection> createState() => _ProductTabsSectionState();
}

class _ProductTabsSectionState extends State<_ProductTabsSection> {
  int _activeTab = 0; // 0: Description, 1: Features, 2: Reviews

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 80),
      child: Column(
        children: [
          // Tab Headers
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTabHeader("DESCRIPTION", 0),
              const SizedBox(width: 60),
              _buildTabHeader("FEATURES", 1),
              const SizedBox(width: 60),
              _buildTabHeader("REVIEWS (124)", 2),
            ],
          ),
          const SizedBox(height: 60),
          // Tab Content Area
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            child: _buildTabContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabHeader(String label, int index) {
    final bool isActive = _activeTab == index;
    return GestureDetector(
      onTap: () => setState(() => _activeTab = index),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              color: isActive ? const Color(0xFF1E293B) : Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 12),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 2,
            width: isActive ? 40 : 0,
            color: const Color(0xFF818CF8),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_activeTab) {
      case 0:
        return _buildDescriptionTab();
      case 1:
        return _buildFeaturesTab();
      case 2:
        return _buildReviewsTab();
      default:
        return const SizedBox();
    }
  }

  Widget _buildDescriptionTab() {
    return Container(
      key: const ValueKey(0),
      constraints: const BoxConstraints(maxWidth: 900),
      child: Column(
        children: [
          const Text(
            "Elevating Timeless Elegance",
            style: TextStyle(
              fontSize: 28,
              fontFamily: 'Serif',
              fontWeight: FontWeight.w900,
              color: Color(0xFF1E293B),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          Text(
            "Our mastercraft series represents the pinnacle of jewelry design. Each piece is born from a singular vision—to blend the raw majesty of earth's finest minerals with the delicate precision of modern craftsmanship. From the initial hand-drawn sketch to the final laser-guided setting, the process takes over 120 hours of concentrated artistry.",
            style: TextStyle(
              fontSize: 16,
              height: 2,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            "We use only ethically sourced 24K gold and conflict-free gemstones, ensuring that your heirloom is as pure in its origin as it is in its appearance.",
            style: TextStyle(
              fontSize: 16,
              height: 2,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesTab() {
    return Container(
      key: const ValueKey(1),
      constraints: const BoxConstraints(maxWidth: 900),
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        childAspectRatio: 3,
        mainAxisSpacing: 30,
        crossAxisSpacing: 50,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildFeatureItem(
            Icons.verified_user_outlined,
            "BIS Hallmarked Purity",
            "Guaranteed 24K Gold quality certification.",
          ),
          _buildFeatureItem(
            Icons.auto_awesome_outlined,
            "Precision Stone Setting",
            "Laser-guided placement for maximum brilliance.",
          ),
          _buildFeatureItem(
            Icons.eco_outlined,
            "Ethically Sourced",
            "100% conscious material sourcing protocols.",
          ),
          _buildFeatureItem(
            Icons.health_and_safety_outlined,
            "Hypoallergenic",
            "Lead and nickel free for sensitive skin.",
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String desc) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF818CF8).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: const Color(0xFF818CF8), size: 24),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                desc,
                style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReviewsTab() {
    return Container(
      key: const ValueKey(2),
      constraints: const BoxConstraints(maxWidth: 900),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "4.8",
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: List.generate(
                      5,
                      (index) => const Icon(
                        Icons.star,
                        color: Color(0xFFFBBF24),
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Based on 124 verified reviews",
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 60),
          _buildReviewCard(
            "Aarav Sharma",
            "Five days ago",
            "Absolutely stunning piece. The craftsmanship is even better in person than in the photos. The gold has a very rich, premium glow.",
            5,
          ),
          const Divider(height: 50),
          _buildReviewCard(
            "Priya Patel",
            "Two weeks ago",
            "I've been wearing the bracelet for two weeks and it's perfect. Very comfortable and definitely a conversation starter.",
            4,
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(
    String author,
    String date,
    String content,
    int stars,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  author,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
                ),
              ],
            ),
            Row(
              children: List.generate(
                5,
                (index) => Icon(
                  Icons.star,
                  color: index < stars
                      ? const Color(0xFFFBBF24)
                      : Colors.grey.shade300,
                  size: 16,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Text(
          content,
          style: TextStyle(
            color: Colors.grey.shade600,
            height: 1.6,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

class _ProductCarouselSection extends StatelessWidget {
  final String title;
  final String subtitle;

  const _ProductCarouselSection({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            letterSpacing: 4,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 15),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 32,
            fontFamily: 'Serif',
            fontWeight: FontWeight.w900,
            color: Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 60),
        CarouselSlider(
          options: CarouselOptions(
            height: 480,
            viewportFraction: 0.25,
            autoPlay: true,
            enlargeCenterPage: false,
            padEnds: false,
          ),
          items: globalShopProducts.map((product) {
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, anim, secAnim) =>
                            DesktopProductDetailPage(product: product),
                        transitionsBuilder: (context, anim, secAnim, child) {
                          return FadeTransition(opacity: anim, child: child);
                        },
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                              image: DecorationImage(
                                image: NetworkImage(product.image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          product.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFF1E293B),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "₹${product.currentPrice.toInt()}",
                          style: const TextStyle(
                            color: Color(0xFF818CF8),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _CartSidebar extends StatelessWidget {
  final List<ProductItem> items;
  final VoidCallback onClose;
  final Function(ProductItem) onRemove;

  const _CartSidebar({
    required this.items,
    required this.onClose,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    double total = items.fold(0, (sum, item) => sum + item.currentPrice);

    return Container(
      width: 450,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 50,
            offset: Offset(-10, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          // Sidebar Header
          Padding(
            padding: const EdgeInsets.all(40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "MY SHOPPING BAG",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                    color: Color(0xFF1E293B),
                  ),
                ),
                IconButton(
                  onPressed: onClose,
                  icon: const Icon(Icons.close_rounded, size: 28),
                  color: Colors.grey.shade400,
                ),
              ],
            ),
          ),

          // Items List
          Expanded(
            child: items.isEmpty
                ? _buildEmptyCart()
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    itemCount: items.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 40),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return _buildCartItem(item);
                    },
                  ),
          ),

          // Bottom Totals & Action
          if (items.isNotEmpty) _buildCartFooter(context, total),
        ],
      ),
    );
  }

  Widget _buildCartItem(ProductItem item) {
    return Row(
      children: [
        Container(
          width: 80,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: NetworkImage(item.image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 25),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Color(0xFF1E293B),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                "₹${item.currentPrice.toInt()}",
                style: const TextStyle(
                  color: Color(0xFF818CF8),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () => onRemove(item),
          icon: const Icon(Icons.delete_outline_rounded, size: 20),
          color: Colors.red.shade300,
        ),
      ],
    );
  }

  Widget _buildEmptyCart() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.shopping_bag_outlined,
          size: 60,
          color: Colors.grey.shade200,
        ),
        const SizedBox(height: 20),
        const Text(
          "YOUR BAG IS EMPTY",
          style: TextStyle(
            color: Colors.grey,
            letterSpacing: 2,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildCartFooter(BuildContext context, double total) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "TOTAL ESTIMATE",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  color: Colors.grey,
                ),
              ),
              Text(
                "₹${total.toInt()}",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DesktopCheckoutPage(cartItems: items),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E293B),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 0,
              ),
              child: const Text(
                "CHECKOUT NOW",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

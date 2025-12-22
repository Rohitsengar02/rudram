import 'package:flutter/material.dart';

class AiStylistScreen extends StatefulWidget {
  const AiStylistScreen({super.key});

  @override
  State<AiStylistScreen> createState() => _AiStylistScreenState();
}

class _AiStylistScreenState extends State<AiStylistScreen>
    with TickerProviderStateMixin {
  bool _isListening = false;
  late List<ScrollController> _scrollControllers;
  late AnimationController _shadowController;
  late Animation<double> _shadowAnimation;

  final List<String> _sampleQueries = [
    "What are the top trending jewelry designs 2024",
    "Show me luxury diamond necklaces for weddings",
    "Find elegant gold earrings under ₹50,000",
    "Suggest bridal jewelry sets",
  ];

  int _currentQueryIndex = 0;

  // Product data for carousels
  final List<Map<String, String>> _products = [
    {
      'name': 'Diamond Necklace',
      'price': '₹85,000',
      'image':
          'https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/6_mu5hap.jpg',
    },
    {
      'name': 'Gold Bracelet',
      'price': '₹45,000',
      'image':
          'https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/5_lf1dgq.jpg',
    },
    {
      'name': 'Pearl Earrings',
      'price': '₹32,000',
      'image':
          'https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/7_i3yykt.jpg',
    },
    {
      'name': 'Silver Ring',
      'price': '₹28,000',
      'image':
          'https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/4_a7e9t3.jpg',
    },
    {
      'name': 'Bridal Set',
      'price': '₹125,000',
      'image':
          'https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/3_i5pjnq.jpg',
    },
    {
      'name': 'Golden Chain',
      'price': '₹67,000',
      'image':
          'https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/1_x3dvkl.jpg',
    },
  ];

  @override
  void initState() {
    super.initState();
    _scrollControllers = List.generate(3, (index) => ScrollController());

    // Shadow animation
    _shadowController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _shadowAnimation = Tween<double>(begin: 20.0, end: 40.0).animate(
      CurvedAnimation(parent: _shadowController, curve: Curves.easeInOut),
    );

    // Start auto-scrolling for each carousel
    _startAutoScroll();
  }

  void _startAutoScroll() {
    // Carousel 1 - Left scroll
    _autoScroll(_scrollControllers[0], reverse: false);

    // Carousel 2 - Right scroll
    _autoScroll(_scrollControllers[1], reverse: true);

    // Carousel 3 - Left scroll
    _autoScroll(_scrollControllers[2], reverse: false);
  }

  void _autoScroll(ScrollController controller, {required bool reverse}) {
    Future.delayed(Duration.zero, () async {
      if (!mounted) return;

      while (mounted) {
        await Future.delayed(const Duration(milliseconds: 50));
        if (controller.hasClients) {
          final maxScroll = controller.position.maxScrollExtent;
          final currentScroll = controller.offset;

          if (reverse) {
            // Scroll right (backwards)
            if (currentScroll <= 0) {
              controller.jumpTo(maxScroll);
            } else {
              controller.animateTo(
                currentScroll - 1,
                duration: const Duration(milliseconds: 50),
                curve: Curves.linear,
              );
            }
          } else {
            // Scroll left (forwards)
            if (currentScroll >= maxScroll) {
              controller.jumpTo(0);
            } else {
              controller.animateTo(
                currentScroll + 1,
                duration: const Duration(milliseconds: 50),
                curve: Curves.linear,
              );
            }
          }
        }
      }
    });
  }

  @override
  void dispose() {
    for (var controller in _scrollControllers) {
      controller.dispose();
    }
    _shadowController.dispose();
    super.dispose();
  }

  void _toggleListening() {
    setState(() {
      _isListening = !_isListening;
      if (_isListening) {
        _currentQueryIndex = (_currentQueryIndex + 1) % _sampleQueries.length;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final carouselHeight = screenHeight / 3;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Stack(
        children: [
          // Background carousels - Full height, no padding
          Positioned.fill(
            child: Column(
              children: [
                _buildCarousel(0, carouselHeight),
                _buildCarousel(1, carouselHeight),
                _buildCarousel(2, carouselHeight),
              ],
            ),
          ),

          // Gradient overlay (bottom to top)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    const Color(0xFF0A0A0A),
                    const Color(0xFF0A0A0A).withValues(alpha: 0.95),
                    const Color(0xFF0A0A0A).withValues(alpha: 0.85),
                    const Color(0xFF0A0A0A).withValues(alpha: 0.6),
                    Colors.transparent,
                    const Color(0xFF0A0A0A).withValues(alpha: 0.6),
                    const Color(0xFF0A0A0A).withValues(alpha: 0.85),
                    const Color(0xFF0A0A0A).withValues(alpha: 0.95),
                    const Color(0xFF0A0A0A),
                  ],
                  stops: const [
                    0.0,
                    0.1,
                    0.15,
                    0.25,
                    0.5,
                    0.75,
                    0.85,
                    0.9,
                    1.0,
                  ],
                ),
              ),
            ),
          ),

          // Main content
          SafeArea(
            child: Column(
              children: [
                // Back button
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ),

                const Spacer(),

                // GIF in center with circular clip and animated gradient shadow
                AnimatedBuilder(
                  animation: _shadowAnimation,
                  builder: (context, child) {
                    return Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFF6C63FF,
                            ).withValues(alpha: 0.6),
                            blurRadius: _shadowAnimation.value,
                            spreadRadius: _shadowAnimation.value / 2,
                          ),
                          BoxShadow(
                            color: const Color(
                              0xFFFF6EC7,
                            ).withValues(alpha: 0.4),
                            blurRadius: _shadowAnimation.value + 10,
                            spreadRadius: _shadowAnimation.value / 3,
                          ),
                          BoxShadow(
                            color: const Color(
                              0xFF00D4FF,
                            ).withValues(alpha: 0.3),
                            blurRadius: _shadowAnimation.value + 20,
                            spreadRadius: _shadowAnimation.value / 4,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Container(
                          color: Colors.transparent,
                          child: Image.asset(
                            'assets/images/gif.gif',
                            width: 260,
                            height: 260,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 260,
                                height: 260,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF6C63FF),
                                      Color(0xFFFF6EC7),
                                    ],
                                  ),
                                ),
                                child: const Icon(
                                  Icons.auto_awesome,
                                  size: 80,
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                // Query text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      _sampleQueries[_currentQueryIndex],
                      key: ValueKey(_currentQueryIndex),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),

                const Spacer(),

                // Microphone button at bottom
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: _toggleListening,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: _isListening
                                  ? [
                                      const Color(0xFFFF6EC7),
                                      const Color(0xFF9D5CFF),
                                    ]
                                  : [
                                      const Color(0xFFB0FF57),
                                      const Color(0xFF00D4FF),
                                    ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    (_isListening
                                            ? const Color(0xFFFF6EC7)
                                            : const Color(0xFFB0FF57))
                                        .withValues(alpha: 0.6),
                                blurRadius: 30,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Icon(
                            _isListening ? Icons.stop : Icons.mic,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _isListening ? 'Listening...' : 'Tap to speak',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.6),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarousel(int index, double height) {
    // Create infinite scroll by duplicating products
    final infiniteProducts = List.generate(
      100,
      (i) => _products[i % _products.length],
    );

    return SizedBox(
      height: height,
      child: ListView.builder(
        controller: _scrollControllers[index],
        scrollDirection: Axis.horizontal,
        itemCount: infiniteProducts.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, i) {
          final product = infiniteProducts[i];
          return Container(
            width: 140,
            margin: EdgeInsets.zero,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  product['image']!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Container(color: Colors.grey[800]),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.8),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 12,
                  left: 12,
                  right: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        product['name']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        product['price']!,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

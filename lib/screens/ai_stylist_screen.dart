import 'package:flutter/material.dart';
import 'dart:math' as math;

class AiStylistScreen extends StatefulWidget {
  const AiStylistScreen({super.key});

  @override
  State<AiStylistScreen> createState() => _AiStylistScreenState();
}

class _AiStylistScreenState extends State<AiStylistScreen>
    with TickerProviderStateMixin {
  bool _isListening = false;
  bool _isThinking = false;
  bool _showProducts = false;
  late AnimationController _pulseController;
  late AnimationController _moveController;
  late AnimationController _thinkingController;
  late AnimationController _bubbleController;
  late AnimationController _scaleController;
  late AnimationController _expandController;

  late Animation<Offset> _moveAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _expandAnimation;
  final List<BubbleData> _bubbles = [];

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _moveController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _moveAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(0, -2.0)).animate(
          CurvedAnimation(parent: _moveController, curve: Curves.easeOutCubic),
        );

    _thinkingController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);

    _bubbleController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.5,
    ).animate(CurvedAnimation(parent: _scaleController, curve: Curves.easeOut));

    _expandController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _expandAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _expandController, curve: Curves.easeInOutCubic),
    );

    _initBubbles();
  }

  void _initBubbles() {
    final random = math.Random();
    for (int i = 0; i < 20; i++) {
      _bubbles.add(
        BubbleData(
          x: random.nextDouble(),
          y: random.nextDouble(),
          size: random.nextDouble() * 30 + 20,
          speed: random.nextDouble() * 0.5 + 0.3,
        ),
      );
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _moveController.dispose();
    _thinkingController.dispose();
    _bubbleController.dispose();
    _scaleController.dispose();
    _expandController.dispose();
    super.dispose();
  }

  void _onAvatarTapped() {
    // Do nothing on single tap, only long press matters
  }

  void _onAvatarLongPressStart(LongPressStartDetails details) {
    if (!_showProducts) {
      // Move to center and start listening
      _moveController.forward();
      setState(() {
        _isListening = true;
      });
      _scaleController.forward(); // Shrink avatar
    }
  }

  void _onAvatarLongPressEnd(LongPressEndDetails details) {
    if (_isListening) {
      setState(() {
        _isListening = false;
        _isThinking = true;
      });

      _expandController.forward();

      Future.delayed(const Duration(milliseconds: 800), () {
        setState(() {
          _isThinking = false;
          _showProducts = true;
        });
      });
    }
  }

  void _resetState() {
    setState(() {
      _showProducts = false;
      _isListening = false;
      _isThinking = false;
    });
    _moveController.reverse();
    _scaleController.reverse();
    _expandController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final bottomBarHeight = screenHeight * 0.2;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: _showProducts
          ? null
          : AppBar(
              backgroundColor: const Color(0xFF1A1A1A),
              elevation: 0,
              title: const Text(
                'AI Stylist',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
      body: Stack(
        children: [
          if (!_showProducts)
            Positioned.fill(
              bottom: bottomBarHeight,
              child: _buildInstructions(),
            ),

          if (!_showProducts)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: bottomBarHeight,
              child: _buildBottomBar(bottomBarHeight),
            ),

          // Fullscreen Expansion Circle
          if (_isThinking || _showProducts)
            AnimatedBuilder(
              animation: _expandAnimation,
              builder: (context, child) {
                final maxDim = math.max(screenWidth, screenHeight);
                final size = _expandAnimation.value * maxDim * 1.5;

                return Positioned.fill(
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          width: size,
                          height: size,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Color(0xFF6366F1),
                                Color(0xFF8B5CF6),
                                Color(0xFFEC4899),
                              ],
                            ),
                          ),
                        ),
                      ),

                      if (_showProducts)
                        Positioned.fill(child: _buildProductsGrid()),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(double height) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Color(0xFF6366F1), Color(0xFF8B5CF6), Color(0xFFEC4899)],
            ),
          ),
        ),

        AnimatedBuilder(
          animation: _bubbleController,
          builder: (context, child) {
            return CustomPaint(
              painter: BubblePainter(
                bubbles: _bubbles,
                animation: _bubbleController.value,
              ),
              size: Size.infinite,
            );
          },
        ),

        SlideTransition(
          position: _moveAnimation,
          child: Center(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                _onAvatarTapped();
              },
              onLongPressStart: (details) {
                _onAvatarLongPressStart(details);
              },
              onLongPressEnd: (details) {
                _onAvatarLongPressEnd(details);
              },
              child: SizedBox(
                width: 150,
                height: 150,
                child: AnimatedBuilder(
                  animation: _scaleAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: _buildAvatar(),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInstructions() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.auto_awesome,
            size: 80,
            color: Colors.white.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 20),
          const Text(
            'Tap the AI avatar below',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white70,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Press and hold to speak',
            style: TextStyle(fontSize: 14, color: Colors.white38),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.5),
            blurRadius: 30,
            spreadRadius: 10,
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/images/gif.gif',
          width: 120,
          height: 120,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(
              Icons.auto_awesome,
              size: 50,
              color: Color(0xFF6366F1),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProductsGrid() {
    final products = [
      {
        'name': 'Diamond Necklace',
        'price': '₹45,999',
        'image':
            'https://via.placeholder.com/400x400/8B5CF6/FFFFFF?text=Diamond+Necklace',
      },
      {
        'name': 'Gold Bracelet',
        'price': '₹32,499',
        'image':
            'https://via.placeholder.com/400x400/FFD700/000000?text=Gold+Bracelet',
      },
      {
        'name': 'Pearl Earrings',
        'price': '₹18,999',
        'image':
            'https://via.placeholder.com/400x400/FFC0CB/000000?text=Pearl+Earrings',
      },
      {
        'name': 'Silver Ring',
        'price': '₹12,999',
        'image':
            'https://via.placeholder.com/400x400/C0C0C0/000000?text=Silver+Ring',
      },
    ];

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                const Expanded(
                  child: Text(
                    'AI Recommendations',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: _resetState,
                  style: TextButton.styleFrom(foregroundColor: Colors.white70),
                  child: const Text('Ask Again'),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return TweenAnimationBuilder(
                  duration: Duration(milliseconds: 400 + (index * 100)),
                  tween: Tween<double>(begin: -100, end: 0),
                  curve: Curves.bounceOut,
                  builder: (context, double value, child) {
                    return Transform.translate(
                      offset: Offset(0, value),
                      child: _buildProductCard(products[index]),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Map<String, String> product) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('View ${product['name']}'),
            backgroundColor: const Color(0xFF1A1A1A),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Image.network(
                product['image']!,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 140,
                    color: Colors.white.withValues(alpha: 0.1),
                    child: const Icon(
                      Icons.image,
                      size: 50,
                      color: Colors.white38,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name']!,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product['price']!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('View ${product['name']}'),
                            backgroundColor: const Color(0xFF1A1A1A),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF6366F1),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'View Details',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BubbleData {
  final double x;
  double y;
  final double size;
  final double speed;

  BubbleData({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
  });
}

class BubblePainter extends CustomPainter {
  final List<BubbleData> bubbles;
  final double animation;

  BubblePainter({required this.bubbles, required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;

    for (var bubble in bubbles) {
      bubble.y = (bubble.y - bubble.speed * 0.01) % 1.0;
      if (bubble.y < 0) bubble.y = 1.0;

      final center = Offset(bubble.x * size.width, bubble.y * size.height);

      canvas.drawCircle(center, bubble.size, paint);
    }
  }

  @override
  bool shouldRepaint(BubblePainter oldDelegate) => true;
}

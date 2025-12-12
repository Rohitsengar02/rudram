import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:share_plus/share_plus.dart';
import '../utils/app_colors.dart';
import 'luxury_product_details_screen.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  final PageController _pageController = PageController();
  // Removed audio permission logic as requested. Audio is on by default.

  final List<String> _videoUrls = [
    "https://res.cloudinary.com/ds1wiqrdb/video/upload/v1765563533/LISA_Bulgari_Mediterranea_High_Jewelry_Collection_lnh1ks.mp4",
    "https://res.cloudinary.com/ds1wiqrdb/video/upload/v1765563533/Tanishq_Diamonds_Where_Rarity_Meets_Radiance_ruhfu7.mp4",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: _pageController,
        // Infinite scrolling
        itemBuilder: (context, index) {
          final url = _videoUrls[index % _videoUrls.length];
          // Pass startMuted: false for automatic audio
          return ReelPlayerItem(videoUrl: url, startMuted: false);
        },
      ),
    );
  }
}

class ReelPlayerItem extends StatefulWidget {
  final String videoUrl;
  final bool startMuted;

  const ReelPlayerItem({
    super.key,
    required this.videoUrl,
    required this.startMuted,
  });

  @override
  State<ReelPlayerItem> createState() => _ReelPlayerItemState();
}

class _ReelPlayerItemState extends State<ReelPlayerItem> {
  late VideoPlayerController _controller;
  bool _initialized = false;
  bool _isMuted = false;

  @override
  void initState() {
    super.initState();
    _isMuted = widget.startMuted;

    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize()
          .then((_) {
            if (mounted) {
              setState(() {
                _initialized = true;
                _controller.setLooping(true);
                _controller.setVolume(_isMuted ? 0.0 : 1.0);
                _controller.play();
              });
            }
          })
          .catchError((error) {
            debugPrint("Video Error: $error");
          });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
      _controller.setVolume(_isMuted ? 0.0 : 1.0);
    });
  }

  void _shareContent() {
    // ignore: deprecated_member_use
    Share.share(
      "Check out this exquisite piece from Rudram!\n\n"
      "Luxury Emerald Set - ₹45,00,000\n"
      "Watch the video: ${widget.videoUrl}\n\n"
      "#Rudram #Luxury #Jewelry #Emeralds",
      subject: "Luxury Emerald Set - Rudram",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Video
        _initialized
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    child: VideoPlayer(_controller),
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryOrange,
                ),
              ),

        if (_initialized && !_controller.value.isPlaying)
          const Center(
            child: Icon(
              Icons.play_circle_outline,
              color: Colors.white,
              size: 60,
            ),
          ),

        // Gradient & Overlays
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.2),
                Colors.transparent,
                Colors.black.withValues(alpha: 0.8),
              ],
            ),
          ),
        ),

        // Mute Toggle Icon
        if (_initialized)
          Positioned(
            top: 40,
            right: 16,
            child: IconButton(
              icon: Icon(
                _isMuted ? Icons.volume_off : Icons.volume_up,
                color: Colors.white,
              ),
              onPressed: _toggleMute,
            ),
          ),

        // Back Button
        Positioned(
          top: 40,
          left: 16,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),

        // Right Actions
        Positioned(
          right: 16,
          bottom: 140,
          child: Column(
            children: [
              _buildAction(Icons.favorite, "1.2k", onTap: () {}),
              const SizedBox(height: 16),
              _buildAction(Icons.share, "Share", onTap: _shareContent),
            ],
          ),
        ),

        // Bottom Product Card (Rectangular Card UI)
        Positioned(
          bottom: 20,
          left: 16,
          right: 16,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.95),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                // Product Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    "https://images.unsplash.com/photo-1617038260897-41a1f14a8ca0?w=200",
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                // Product Details
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Luxury Emerald Set",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "₹45,00,000",
                        style: TextStyle(
                          color: AppColors.primaryOrange,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                // Actions (Add to Cart & See Detail)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.add_shopping_cart,
                        color: AppColors.primaryOrange,
                      ),
                      tooltip: "Add to Cart",
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Added Luxury Emerald Set to Cart"),
                          ),
                        );
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to Product Details
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const LuxuryProductDetailsScreen(index: 0),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: const Size(0, 36), // Compact button
                      ),
                      child: const Text(
                        "See Detail",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAction(IconData icon, String label, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

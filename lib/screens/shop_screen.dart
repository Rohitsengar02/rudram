import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../utils/app_colors.dart';
import '../models/data_models.dart';
import '../widgets/product_card.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<String> _productImages = [
    "https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/6_mu5hap.jpg",
    "https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/5_lf1dgq.jpg",
    "https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/7_i3yykt.jpg",
    "https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/4_a7e9t3.jpg",
    "https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/3_i5pjnq.jpg",
    "https://res.cloudinary.com/ds1wiqrdb/image/upload/v1765716358/1_x3dvkl.jpg",
  ];

  bool _isLoading = false;
  int _currentPage = 0;
  final int _itemsPerPage = 8;

  // Categories Data
  final List<CategoryItem> categories = [
    CategoryItem(
      title: "All",
      icon: Icons.grid_view,
      color: Colors.blue.shade50,
    ),
    CategoryItem(
      title: "Rings",
      icon: Icons.panorama_fish_eye,
      color: Colors.purple.shade50,
    ),
    CategoryItem(
      title: "Necks",
      icon: Icons.circle_outlined,
      color: Colors.amber.shade50,
    ),
    CategoryItem(
      title: "Earrings",
      icon: Icons.ac_unit,
      color: Colors.pink.shade50,
    ),
    CategoryItem(
      title: "Bracelets",
      icon: Icons.watch,
      color: Colors.teal.shade50,
    ),
    CategoryItem(
      title: "Watches",
      icon: Icons.watch_later_outlined,
      color: Colors.indigo.shade50,
    ),
    CategoryItem(
      title: "Gold",
      icon: Icons.monetization_on_outlined,
      color: Colors.yellow.shade50,
    ),
    CategoryItem(
      title: "Silver",
      icon: Icons.stars,
      color: Colors.grey.shade50,
    ),
  ];

  List<ProductItem> products = [];
  List<ProductItem> allProducts = [];
  String _selectedCategory = "All";

  RangeValues _priceRange = const RangeValues(10000, 500000);

  List<ProductItem> get filteredProducts {
    if (_selectedCategory == "All") {
      return products;
    }
    return products.where((product) {
      return product.title.toLowerCase().contains(
        _selectedCategory.toLowerCase(),
      );
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _loadInitialProducts();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadInitialProducts() {
    products = _generateProducts(0, _itemsPerPage);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoading) {
      _loadMoreProducts();
    }
  }

  Future<void> _loadMoreProducts() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _currentPage++;
      final newProducts = _generateProducts(
        _currentPage * _itemsPerPage,
        _itemsPerPage,
      );
      products.addAll(newProducts);
      _isLoading = false;
    });
  }

  List<ProductItem> _generateProducts(int startIndex, int count) {
    return List.generate(count, (i) {
      final index = startIndex + i;
      final imageIndex = index % _productImages.length;

      if (index % 4 == 0) {
        return ProductItem(
          title: "Royal Emerald Ring ${index + 1}",
          currentPrice: 85000 + (index * 1000),
          oldPrice: 95000 + (index * 1000),
          discount: "10% Off",
          image: _productImages[imageIndex],
          bgColor: const Color(0xFFF5F5F5),
        );
      } else if (index % 4 == 1) {
        return ProductItem(
          title: "Gold Art Necklace ${index + 1}",
          currentPrice: 125000 + (index * 2000),
          oldPrice: 140000 + (index * 2000),
          discount: "15% Off",
          image: _productImages[imageIndex],
          bgColor: const Color(0xFFFFF8DC),
        );
      } else if (index % 4 == 2) {
        return ProductItem(
          title: "Diamond Studs ${index + 1}",
          currentPrice: 45000 + (index * 500),
          oldPrice: 50000 + (index * 500),
          discount: "10% Off",
          image: _productImages[imageIndex],
          bgColor: const Color(0xFFE8E8E8),
        );
      } else {
        return ProductItem(
          title: "Silver Bracelet ${index + 1}",
          currentPrice: 12000 + (index * 300),
          oldPrice: 15000 + (index * 300),
          discount: "20% Off",
          image: _productImages[imageIndex],
          bgColor: const Color(0xFFE0F7FA),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: _buildHeader()),
            SliverToBoxAdapter(child: _buildSearchBar()),
            SliverToBoxAdapter(child: _buildCategoriesSlider()),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "All Products",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${filteredProducts.length} items",
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: AnimationLimiter(
                child: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.65,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      columnCount: 2,
                      child: ScaleAnimation(
                        child: FadeInAnimation(
                          child: ProductCard(product: filteredProducts[index]),
                        ),
                      ),
                    );
                  }, childCount: filteredProducts.length),
                ),
              ),
            ),

            // Loading indicator
            if (_isLoading)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryOrange,
                    ),
                  ),
                ),
              ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ), // Bottom padding
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Shop",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Find your perfect sparkle",
                style: TextStyle(fontSize: 14, color: AppColors.textGrey),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                ),
              ],
            ),
            child: const Icon(
              Icons.notifications_outlined,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search jewelry...',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: Colors.grey),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          InkWell(
            onTap: () => _showFilterModal(context),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: AppColors.primaryOrange,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryOrange.withValues(alpha: 0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Icon(Icons.tune, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 24, 20, 16),
          child: Text(
            "Categories",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final cat = categories[index];
              final isSelected = _selectedCategory == cat.title;
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategory = cat.title;
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 65,
                        width: 65,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryOrange
                              : cat.color,
                          borderRadius: BorderRadius.circular(20),
                          border: isSelected
                              ? Border.all(
                                  color: AppColors.primaryOrange,
                                  width: 2,
                                )
                              : null,
                        ),
                        child: Icon(
                          cat.icon,
                          color: isSelected ? Colors.white : Colors.black87,
                          size: 28,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        cat.title,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.w500,
                          color: isSelected
                              ? AppColors.primaryOrange
                              : AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showFilterModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Column(
                children: [
                  // Handle
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 12, bottom: 12),
                      height: 5,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  // Header
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Filter & Sort",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            "Close",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Divider(),

                  // Content
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(24),
                      children: [
                        const Text(
                          "Sort By",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            _buildFilterChip("Popular", true),
                            _buildFilterChip("Newest", false),
                            _buildFilterChip("Price: Low to High", false),
                            _buildFilterChip("Price: High to Low", false),
                          ],
                        ),

                        const SizedBox(height: 32),

                        const Text(
                          "Price Range",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        RangeSlider(
                          values: _priceRange,
                          min: 0,
                          max: 1000000,
                          activeColor: AppColors.primaryOrange,
                          inactiveColor: Colors.grey[200],
                          labels: RangeLabels(
                            "₹${_priceRange.start.round()}",
                            "₹${_priceRange.end.round()}",
                          ),
                          onChanged: (values) {
                            setState(() {
                              _priceRange = values;
                            });
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "₹${_priceRange.start.round()}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "₹${_priceRange.end.round()}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 32),

                        const Text(
                          "Occasion",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            _buildFilterChip("Wedding", false),
                            _buildFilterChip("Party", false),
                            _buildFilterChip("Daily Wear", true),
                            _buildFilterChip("Office", false),
                            _buildFilterChip("Gift", false),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Bottom Buttons
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() {
                                // Reset logic
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              side: const BorderSide(color: Colors.grey),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text(
                              "Reset",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryOrange,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text(
                              "Apply Filters",
                              style: TextStyle(
                                color: Colors.white,
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
            );
          },
        );
      },
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (val) {},
      selectedColor: AppColors.primaryOrange.withValues(alpha: 0.1),
      checkmarkColor: AppColors.primaryOrange,
      backgroundColor: Colors.grey[100],
      labelStyle: TextStyle(
        color: isSelected ? AppColors.primaryOrange : Colors.black87,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? AppColors.primaryOrange : Colors.transparent,
        ),
      ),
    );
  }
}

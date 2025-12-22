import 'package:flutter/material.dart';
import '../../widgets/desktop/desktop_header.dart';
import '../../widgets/desktop/desktop_hero_section.dart';
import '../../widgets/promo_code_banner.dart';
import '../../widgets/desktop/desktop_flash_sale_section.dart';
import '../../widgets/desktop/desktop_new_arrivals_section.dart';
import '../../widgets/desktop/desktop_best_sellers_section.dart';
import '../../widgets/desktop/desktop_trending_now_section.dart';
import '../../widgets/desktop/desktop_exclusive_offers_section.dart';
import '../../widgets/desktop/desktop_shop_by_occasion_section.dart';
import '../../widgets/desktop/desktop_deals_of_the_day_section.dart';
import '../../widgets/desktop/desktop_perfect_match_section.dart';
import '../../widgets/luxury_section.dart';
import '../../widgets/watch_and_shop_section.dart';
import '../../widgets/blog_section.dart';
import '../../widgets/insta_family_section.dart';
import '../../widgets/all_products_section.dart';
import '../../widgets/our_features_section.dart';
import '../../widgets/temple_jewellery_section.dart';
import '../../widgets/celebrity_style_section.dart';
import '../../widgets/gold_scheme_section.dart';
import '../../widgets/designers_spotlight.dart';
import '../../widgets/gift_guide_section.dart';
import '../../widgets/testimonials_section.dart';
import '../../widgets/newsletter_section.dart';
import '../../widgets/brand_marquee_section.dart';
import '../../widgets/community_gallery_section.dart';
import '../../widgets/faq_section.dart';
import '../../widgets/awards_section.dart';
import '../../widgets/footer_section.dart';

class DesktopHomeScreen extends StatelessWidget {
  const DesktopHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Header (Full Width)
            const DesktopHeader(),

            // 2. Hero Section (Full Width)
            const DesktopHeroSection(),

            const SizedBox(height: 20),

            // 3. Promo Code Banner
            const SizedBox(height: 50),

            // Other Sections
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  const PromoCodeBanner(),
                  const DesktopFlashSaleSection(),
                  const SizedBox(height: 30),
                  const DesktopNewArrivalsSection(),
                  const SizedBox(height: 30),
                  const DesktopBestSellersSection(),
                  const SizedBox(height: 30),
                  const DesktopTrendingNowSection(),
                  const SizedBox(height: 30),
                  const DesktopExclusiveOffersSection(),
                  const SizedBox(height: 30),
                  const DesktopShopByOccasionSection(),
                  const SizedBox(height: 30),
                  const DesktopDealsOfTheDaySection(),
                  const SizedBox(height: 30),
                  const DesktopPerfectMatchSection(),
                  const SizedBox(height: 30),
                  const LuxurySection(),
                  const SizedBox(height: 30),
                  const WatchAndShopSection(),
                  const SizedBox(height: 30),
                  const BlogSection(),
                  const SizedBox(height: 30),
                  const InstaFamilySection(),
                  const SizedBox(height: 30),
                  AllProductsSection(),
                  const SizedBox(height: 30),
                  const OurFeaturesSection(),
                  const SizedBox(height: 30),
                  TempleJewellerySection(),
                  const SizedBox(height: 30),
                  CelebrityStyleSection(),
                  const SizedBox(height: 30),
                  GoldSchemeSection(),
                  const SizedBox(height: 30),
                  const DesignersSpotlight(),
                  const SizedBox(height: 30),
                  GiftGuideSection(),
                  const SizedBox(height: 30),
                  TestimonialsSection(),
                  const SizedBox(height: 30),
                  const NewsletterSection(),
                  const SizedBox(height: 30),
                  const BrandMarqueeSection(),
                  const SizedBox(height: 30),
                  CommunityGallerySection(),
                  const SizedBox(height: 30),
                  FaqSection(),
                  const SizedBox(height: 30),
                  const AwardsSection(),
                  const SizedBox(height: 30),
                  const FooterSection(),
                ],
              ),
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

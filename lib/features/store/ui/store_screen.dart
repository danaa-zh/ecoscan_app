import 'package:flutter/material.dart';
import 'package:ecoscan_app/core/theme/app_colors.dart';
import 'package:ecoscan_app/widgets/bottom_nav_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  final List<_StoreItemData> _items = const [
    _StoreItemData(imagePath: 'assets/item-shirt.png', title: 'Футболка'),
    _StoreItemData(imagePath: 'assets/item-charm.png', title: 'Брелок'),
    _StoreItemData(imagePath: 'assets/item-bag.png', title: 'Сумка'),
  ];

  String _query = '';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // Ensure search + spacer + filter fit available width.
    final double filterWidth = 80;
    final double horizontalPadding = 33;
    final double spacer = 5;
    final double searchWidth =
        width - horizontalPadding * 2 - filterWidth - spacer;

    final lowerQuery = _query.trim().toLowerCase();
    final visibleItems = lowerQuery.isEmpty
        ? _items
        : _items
            .where(
              (item) =>
                  item.title.toLowerCase().contains(lowerQuery) ||
                  item.title.contains(_query),
            )
            .toList();

    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        top: true,
        bottom: false,
        child: SingleChildScrollView(
          // Extra space so content never collides with bottom nav.
          padding: const EdgeInsets.only(bottom: 100),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 33),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 63),
                const Text(
                  'Магазин',
                  style: TextStyle(
                    // fontFamily: 'Inter',
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
                const Text(
                  'Все подукты из переработанных материалов',
                  style: TextStyle(
                    // fontFamily: 'Inter',
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: AppColors.theGrey,
                  ),
                ),
                const SizedBox(height: 7),
                Row(
                  children: [
                    // Search field
                    Container(
                      width: searchWidth,
                      height: 28,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: AppColors.theGrey, width: 1),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 5),
                          Image.asset(
                            'assets/search-icon.png',
                            width: 19,
                            height: 19,
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                setState(() => _query = value);
                              },
                              style: const TextStyle(
                                // fontFamily: 'Inter',
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: AppColors.black,
                              ),
                              decoration: const InputDecoration(
                                isCollapsed: true,
                                border: InputBorder.none,
                                hintText: 'Поиск',
                                hintStyle: TextStyle(
                                  // fontFamily: 'Inter',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.theGrey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 5),
                    // Filter button (same as in profile history)
                    SizedBox(
                      width: filterWidth,
                      height: 28,
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          side:
                              const BorderSide(color: AppColors.theGrey, width: 1),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          foregroundColor: AppColors.theGrey,
                          textStyle: const TextStyle(
                            // fontFamily: 'Inter',
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/filter.png',
                              width: 16,
                              height: 16,
                            ),
                            const SizedBox(width: 2),
                            const Text('Фильтр'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Items grid
                Wrap(
                  spacing: 0,
                  runSpacing: 5,
                  children: visibleItems
                      .map(
                        (item) => _StoreItemCard(
                          imagePath: item.imagePath,
                          title: item.title,
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const EcoBottomNavBar(active: BottomNavItem.store),
    );
  }
}

class _StoreItemData {
  const _StoreItemData({
    required this.imagePath,
    required this.title,
  });

  final String imagePath;
  final String title;
}

class _StoreItemCard extends StatefulWidget {
  const _StoreItemCard({
    required this.imagePath,
    required this.title,
  });

  final String imagePath;
  final String title;

  @override
  State<_StoreItemCard> createState() => _StoreItemCardState();
}

class _StoreItemCardState extends State<_StoreItemCard> {
  bool _isFavorite = false;

  Future<void> _openWhatsApp() async {
    final uri = Uri.parse('https://wa.me/77002719735');
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 161,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 14, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image with heart overlay
              Stack(
                children: [
                  SizedBox(
                    width: 140,
                    height: 166,
                    child: Image.asset(
                      widget.imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 5,
                    left: 4,
                    child: GestureDetector(
                      onTap: () {
                        setState(() => _isFavorite = !_isFavorite);
                      },
                      child: Container(
                        width: 20,
                        height: 20.84,
                        decoration: const BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Image.asset(
                            _isFavorite
                                ? 'assets/active-heart.png'
                                : 'assets/inactive-heart.png',
                            width: 12,
                            height: 12.45,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                widget.title,
                style: const TextStyle(
                  // fontFamily: 'Inter',
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 71,
                    child: Text(
                      '1200 бонусов/\n1200 тг',
                      style: TextStyle(
                        // fontFamily: 'Inter',
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: _openWhatsApp,
                    child: Container(
                      width: 25,
                      height: 25,
                      margin: const EdgeInsets.only(right: 2),
                      decoration: const BoxDecoration(
                        color: AppColors.lightGreen,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/go-shop.png',
                          width: 15,
                          height: 14,
                          fit: BoxFit.contain,
                        ),
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
}


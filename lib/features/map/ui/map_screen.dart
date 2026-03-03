import 'package:flutter/material.dart';
import 'package:ecoscan_app/core/theme/app_colors.dart';
import 'package:ecoscan_app/widgets/bottom_nav_bar.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 63),
                const Padding(
                  padding: EdgeInsets.only(left: 29),
                  child: Text(
                    'Точки фандоматов',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: AppColors.brandGreen,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 29),
                  child: Row(
                    children: [
                      // City button
                      SizedBox(
                        width: 82,
                        height: 26,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: AppColors.btn,
                              width: 1,
                            ),
                            foregroundColor: Colors.black,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            textStyle: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/mark-icon.png',
                                width: 10,
                                height: 14,
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                'Алматы',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Filter button
                      SizedBox(
                        width: 82,
                        height: 26,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: AppColors.btn,
                              width: 1,
                            ),
                            foregroundColor: Colors.black,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            textStyle: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/filter-green.png',
                                width: 10,
                                height: 14,
                              ),
                              const SizedBox(width: 4),
                              const Padding(
                                padding: EdgeInsets.only(
                                  top: 6,
                                  bottom: 8,
                                ),
                                child: Text(
                                  'Фильтр',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // Map area fills the rest
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
          // Location cards stacked above bottom nav bar
          Positioned(
            left: 0,
            right: 0,
            // bottom: kBottomNavigationBarHeight + 4,
            bottom: 16,
            child: SizedBox(
              height: 102,
              child: Center(
                child: SizedBox(
                  height: 102,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) {
                      return Container(
                        width: 299,
                        height: 102,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                              offset: Offset(0, 0),
                              blurRadius: 4,
                              spreadRadius: 3,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 19,
                            left: 22,
                            right: 22,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'ул. Розбакиева, 152',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 0),
                              const Text(
                                'ТРЦ “Mega Center”',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.theGrey,
                                ),
                              ),
                              const SizedBox(height: 29),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/route-icon.png',
                                    width: 12,
                                    height: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  const Text(
                                    '2.4 км',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.theGrey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 16),
                    itemCount: 3,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const EcoBottomNavBar(active: BottomNavItem.map),
    );
  }
}

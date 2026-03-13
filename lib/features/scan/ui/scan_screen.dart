import 'package:flutter/material.dart';
import 'package:ecoscan_app/core/theme/app_colors.dart';
import 'package:ecoscan_app/widgets/bottom_nav_bar.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:go_router/go_router.dart';
import 'package:ecoscan_app/core/router/route_names.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

void _goToProfile(BuildContext context) {
  context.go(RouteNames.profilePath);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: MobileScanner(
              fit: BoxFit.cover,
              onDetect: (BarcodeCapture capture) {
                for (final barcode in capture.barcodes) {
                  final String? code = barcode.rawValue;
                  if (code != null) {
                    print('QR: $code');
                  }
                }
              },
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: Container(
                    color: AppColors.brandGreen,
                    padding: const EdgeInsets.only(left: 2, right: 12, top: 5),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 33.5,
                              height: 33.5,
                              child: Image.asset(
                                'assets/logo.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              'ECOSCAN',
                              style: TextStyle(
                                // fontFamily: 'Outfit',
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: AppColors.accent,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => _goToProfile(context),
                          child: Container(
                            width: 37,
                            height: 35,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Center(
                              child: CircleAvatar(
                                radius: 14,
                                backgroundImage: AssetImage(
                                  'assets/avatar.jpg',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 7),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 19),
                  child: Container(
                    width: double.infinity,
                    height: 52,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: const Text(
                      'ОТСКАНИРУЙ QR КОД ЧТОБЫ ВОЙТИ\nВ АККАУНТ ECOSCAN',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        // fontFamily: 'Inter',
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 11),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 19),
                  child: GestureDetector(
                    onTap: () => _goToProfile(context),
                    child: Container(
                      width: double.infinity,
                      height: 43,
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: const EdgeInsets.fromLTRB(7, 3, 14, 5),
                      child: Row(
                        children: [
                          Container(
                            width: 37,
                            height: 35,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Center(
                              child: CircleAvatar(
                                radius: 14,
                                backgroundImage: AssetImage(
                                  'assets/avatar.jpg',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Expanded(
                            child: Text(
                              'danaa_zh',
                              style: TextStyle(
                                // fontFamily: 'Inter',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                          Image.asset(
                            'assets/black-down-arrow.png',
                            width: 14,
                            height: 8,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const EcoBottomNavBar(active: BottomNavItem.scan),
    );
  }
}

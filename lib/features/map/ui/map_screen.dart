import 'package:flutter/material.dart';
import 'package:ecoscan_app/core/theme/app_colors.dart';
import 'package:ecoscan_app/widgets/bottom_nav_bar.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: const Center(
        child: Text(
          'Map',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      bottomNavigationBar: const EcoBottomNavBar(active: BottomNavItem.map),
    );
  }
}


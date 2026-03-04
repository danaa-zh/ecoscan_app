import 'package:ecoscan_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ecoscan_app/core/router/route_names.dart';

enum BottomNavItem { profile, store, scan, leaderboard, map }

class EcoBottomNavBar extends StatelessWidget {
  const EcoBottomNavBar({
    super.key,
    required this.active,
  });

  final BottomNavItem active;

  String _assetFor(BottomNavItem item) {
    final isActive = item == active;
    final state = isActive ? 'active' : 'inactive';
    final name = switch (item) {
      BottomNavItem.profile => 'profile',
      BottomNavItem.store => 'store',
      BottomNavItem.scan => 'scan',
      BottomNavItem.leaderboard => 'leaderboard',
      BottomNavItem.map => 'map',
    };
    return 'assets/$state-$name.png';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 17, right: 18, bottom: 19),
      child: SizedBox(
        width: 358,
        height: 51,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.brandGreen,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 29),
              _NavIcon(
                assetPath: _assetFor(BottomNavItem.profile),
                onTap: () => navigateToBottomItem(context, BottomNavItem.profile),
              ),
              const SizedBox(width: 31),
              _NavIcon(
                assetPath: _assetFor(BottomNavItem.store),
                onTap: () => navigateToBottomItem(context, BottomNavItem.store),
              ),
              const SizedBox(width: 44),
              _NavIcon(
                assetPath: _assetFor(BottomNavItem.scan),
                onTap: () => navigateToBottomItem(context, BottomNavItem.scan),
              ),
              const SizedBox(width: 44),
              _NavIcon(
                assetPath: _assetFor(BottomNavItem.leaderboard),
                onTap: () => navigateToBottomItem(context, BottomNavItem.leaderboard),
              ),
              const SizedBox(width: 34),
              _NavIcon(
                assetPath: _assetFor(BottomNavItem.map),
                onTap: () => navigateToBottomItem(context, BottomNavItem.map),
              ),
              const SizedBox(width: 26),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  const _NavIcon({
    required this.assetPath,
    required this.onTap,
  });

  final String assetPath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 7, bottom: 10),
        child: SizedBox(
          width: 30,
          height: 34,
          child: Image.asset(
            assetPath,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

void navigateToBottomItem(BuildContext context, BottomNavItem item) {
  final path = switch (item) {
    BottomNavItem.profile => RouteNames.profilePath,
    BottomNavItem.store => RouteNames.storePath,
    BottomNavItem.scan => RouteNames.scanPath,
    BottomNavItem.leaderboard => RouteNames.leaderboardPath,
    BottomNavItem.map => RouteNames.mapPath,
  };
  context.go(path);
}
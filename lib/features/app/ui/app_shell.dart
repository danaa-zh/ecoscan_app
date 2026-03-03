import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/route_names.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child});
  final Widget child;

  int _indexFromLocation(String location) {
    if (location.startsWith(RouteNames.scanPath)) return 0;
    if (location.startsWith(RouteNames.storePath)) return 1;
    if (location.startsWith(RouteNames.leaderboardPath)) return 2;
    if (location.startsWith(RouteNames.mapPath)) return 3;
    if (location.startsWith(RouteNames.profilePath)) return 4;
    return 0;
  }

  void _goByIndex(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(RouteNames.scanPath);
        break;
      case 1:
        context.go(RouteNames.storePath);
        break;
      case 2:
        context.go(RouteNames.leaderboardPath);
        break;
      case 3:
        context.go(RouteNames.mapPath);
        break;
      case 4:
        context.go(RouteNames.profilePath);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = GoRouterState.of(context).matchedLocation;
    final idx = _indexFromLocation(loc);

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: idx,
        onTap: (i) => _goByIndex(context, i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner), label: 'Scan'),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Store'),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: 'Top'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
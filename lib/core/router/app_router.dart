import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/repositories/auth_repository.dart';
import '../../features/splash/ui/splash_screen.dart';
import '../../features/onboarding/ui/onboarding_screen.dart';
import '../../features/login/ui/login_screen.dart';
import '../../features/register/ui/register_screen.dart';
import '../../features/app/ui/app_shell.dart';
import '../../features/scan/ui/scan_screen.dart';
import '../../features/store/ui/store_screen.dart';
import '../../features/leaderboard/ui/leaderboard_screen.dart';
import '../../features/map/ui/map_screen.dart';
import '../../features/profile/ui/profile_screen.dart';
import 'route_names.dart';

class AppRouter {
  static GoRouter create({required AuthRepository authRepository}) {
    return GoRouter(
      initialLocation: RouteNames.splashPath,
      refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges),
      redirect: (context, state) {
        final isLoggedIn = authRepository.isLoggedIn;
        final loc = state.matchedLocation;

        final isAuthPage = loc == RouteNames.loginPath ||
            loc == RouteNames.registerPath ||
            loc == RouteNames.onboardingPath;

        final isSplash = loc == RouteNames.splashPath;

        if (isSplash) return null;

        if (!isLoggedIn) {
          if (isAuthPage) return null;
          return RouteNames.onboardingPath;
        }

        if (isAuthPage) return RouteNames.scanPath;

        return null;
      },
      routes: [
        GoRoute(
          name: RouteNames.splash,
          path: RouteNames.splashPath,
          builder: (_, __) => const SplashScreen(),
        ),
        GoRoute(
          name: RouteNames.onboarding,
          path: RouteNames.onboardingPath,
          builder: (_, __) => const OnboardingScreen(),
        ),
        GoRoute(
          name: RouteNames.login,
          path: RouteNames.loginPath,
          builder: (_, __) => const LoginPage(),
        ),
        GoRoute(
          name: RouteNames.register,
          path: RouteNames.registerPath,
          builder: (_, __) => const RegisterPage(),
        ),
        ShellRoute(
          builder: (context, state, child) => AppShell(child: child),
          routes: [
            GoRoute(
              name: RouteNames.scan,
              path: RouteNames.scanPath,
              builder: (_, __) => const ScanPage(),
            ),
            GoRoute(
              name: RouteNames.store,
              path: RouteNames.storePath,
              builder: (_, __) => const StorePage(),
            ),
            GoRoute(
              name: RouteNames.leaderboard,
              path: RouteNames.leaderboardPath,
              builder: (_, __) => const LeaderboardPage(),
            ),
            GoRoute(
              name: RouteNames.map,
              path: RouteNames.mapPath,
              builder: (_, __) => const MapPage(),
            ),
            GoRoute(
              name: RouteNames.profile,
              path: RouteNames.profilePath,
              builder: (_, __) => const ProfilePage(),
            ),
          ],
        ),
      ],
    );
  }
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen((_) {
      notifyListeners();
    });
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
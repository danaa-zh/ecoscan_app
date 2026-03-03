import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../data/repositories/auth_repository.dart';
import '../../features/app/bloc/app_bloc.dart';
import '../../features/app/ui/splash_screen.dart';
import '../../features/onboarding/ui/onboarding_screen.dart';
import '../../features/auth/ui/login_screen.dart';
import '../../features/auth/ui/register_screen.dart';
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

        final isAuthPage = loc == RouteNames.loginPath || loc == RouteNames.registerPath || loc == RouteNames.onboardingPath;
        final isSplash = loc == RouteNames.splashPath;

        if (isSplash) return null;

        if (!isLoggedIn) {
          // If user is not logged in, allow onboarding/auth pages only
          if (isAuthPage) return null;
          return RouteNames.onboardingPath;
        }

        // If logged in, prevent going back to auth pages
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
          builder: (context, __) => const LoginScreen(),
        ),
        GoRoute(
          name: RouteNames.register,
          path: RouteNames.registerPath,
          builder: (context, __) => const RegisterScreen(),
        ),

        /// Bottom tabs shell
        ShellRoute(
          builder: (context, state, child) => AppShell(child: child),
          routes: [
            GoRoute(
              name: RouteNames.scan,
              path: RouteNames.scanPath,
              builder: (_, __) => const ScanScreen(),
            ),
            GoRoute(
              name: RouteNames.store,
              path: RouteNames.storePath,
              builder: (_, __) => const StoreScreen(),
            ),
            GoRoute(
              name: RouteNames.leaderboard,
              path: RouteNames.leaderboardPath,
              builder: (_, __) => const LeaderboardScreen(),
            ),
            GoRoute(
              name: RouteNames.map,
              path: RouteNames.mapPath,
              builder: (_, __) => const MapScreen(),
            ),
            GoRoute(
              name: RouteNames.profile,
              path: RouteNames.profilePath,
              builder: (context, __) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    );
  }
}

/// Helper: go_router wants a Listenable for refresh; this is standard pattern.
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _sub = stream.asBroadcastStream().listen((_) => notifyListeners());
  }
  late final StreamSubscription<dynamic> _sub;

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}
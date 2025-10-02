import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/home/presentation/screens/main_screen.dart';
import '../../features/home/presentation/screens/home_tab_screen.dart';
import '../../features/orders/presentation/screens/orders_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/home',
    refreshListenable: GoRouterRefreshStream(ref),
    redirect: (context, state) {
      final authState = ref.read(authStateProvider);

      return authState.when(
        data: (user) {
          final isLoggedIn = user != null;
          final isLoggingIn = state.matchedLocation == '/login';

          if (!isLoggedIn && !isLoggingIn) {
            return '/login';
          }
          if (isLoggedIn && isLoggingIn) {
            return '/home';
          }
          return null;
        },
        loading: () => null,
        error: (_, __) => '/login',
      );
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeTabScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/orders',
                builder: (context, state) => const OrdersScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});

/// Helper class to refresh GoRouter when auth state changes
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Ref ref) {
    _subscription = ref.listen(
      authStateProvider,
      (previous, next) => notifyListeners(),
    );
  }

  late final ProviderSubscription _subscription;

  @override
  void dispose() {
    _subscription.close();
    super.dispose();
  }
}

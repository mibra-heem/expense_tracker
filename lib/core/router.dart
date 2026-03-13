import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/transactions/presentation/screens/presentation_dashboard.dart';
import '../features/transactions/presentation/screens/presentation_home_view.dart';
import '../features/transactions/presentation/screens/presentation_analytics.dart';
import '../features/transactions/presentation/screens/presentation_settings.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return PresentationDashboardScreen(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const PresentationHomeView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/analytics',
              builder: (context, state) => const PresentationAnalyticsScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/budget',
              builder: (context, state) => const Center(child: Text('Budget Coming Soon')),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => const PresentationSettingsScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);

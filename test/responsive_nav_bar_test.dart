import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_nav_barx/responsive_nav_bar.dart';

const _dotKey = ValueKey('responsive_nav_bar_notification_dot');

void main() {
  testWidgets('renders notification dot in phone bottom navigation', (
    tester,
  ) async {
    await _pumpNavigation(tester, width: 390);

    expect(find.byType(BottomNavigationBar), findsOneWidget);
    expect(find.byKey(_dotKey), findsOneWidget);
  });

  testWidgets('renders notification dot in tablet navigation rail', (
    tester,
  ) async {
    await _pumpNavigation(tester, width: 800);

    expect(find.byType(NavigationRail), findsOneWidget);
    expect(find.byKey(_dotKey), findsOneWidget);
  });

  testWidgets('renders notification dot in wide tab navigation', (
    tester,
  ) async {
    await _pumpNavigation(tester, width: 1200);

    expect(find.byType(TabBar), findsOneWidget);
    expect(find.byKey(_dotKey), findsOneWidget);
  });
}

Future<void> _pumpNavigation(
  WidgetTester tester, {
  required double width,
}) async {
  tester.view.physicalSize = Size(width, 900);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  final router = GoRouter(
    initialLocation: '/home',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => ResponsiveNavigationBar(
          navigationShell: navigationShell,
          barButtons: [
            BarItem(icon: const Icon(Icons.home), label: 'Home'),
            BarItem(
              icon: const Icon(Icons.settings),
              label: 'Settings',
              showNotificationDot: true,
            ),
          ],
        ),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) =>
                    const SizedBox(key: ValueKey('home')),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) =>
                    const SizedBox(key: ValueKey('settings')),
              ),
            ],
          ),
        ],
      ),
    ],
  );
  addTearDown(router.dispose);

  await tester.pumpWidget(MaterialApp.router(routerConfig: router));
  await tester.pumpAndSettle();
}

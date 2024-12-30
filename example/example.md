```Dart
// `go_router` routes
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MyApp',
      theme: baseTheme(brightness: Brightness.light),
      darkTheme: baseTheme(brightness: Brightness.dark),
      themeMode: ThemeMode.system,
      routerConfig: router(context),
    );
  }

  GoRouter router(BuildContext context) {
    List<RouteBase> routes = [
      GoRoute(
        path: '/${LoginView.path}',
        builder: (_, __) => const LoginView(),
      ),
      StatefulShellRoute.indexedStack(
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/${Home.path}',
                builder: (_, __) => const Home(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/${Profile.path}',
                builder: (_, __) => const Profile(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/${Settings.path}',
                builder: (_, __) => const Settings(),
              ),
            ],
          ),
        ],
        builder: (_, __, navigationShell) => ResponsiveNavigationBar(
            navigationShell: navigationShell,
            barButtons: [
              BarItem(icon: const Icon(Icons.home), label: 'Home'),
              BarItem(icon: const Icon(Icons.person), label: 'Profile'),
              BarItem(icon: const Icon(Icons.settings), label: 'Settings')
            ]),
      ),
    ];

    final viewModel = context.watch<LoginViewModel>();

    return GoRouter(
      initialLocation: '/${LoginView.path}',
      routes: routes,
      refreshListenable: viewModel,
      redirect: (context, state) {
        if (state.uri.toString() == '/${LoginView.path}' &&
            viewModel.loggedIn) {
          return '/${Home.path}';
        } else if (viewModel.loggedIn == false) {
          return '/${LoginView.path}';
        }
        return null;
      },
    );
  }
}
```
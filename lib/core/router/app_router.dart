import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/screens/screen.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

  static get appRouter => GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/home',
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: '/auth/login',
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: '/auth/register',
        builder: (context, state) => RegisterScreen(),
      ),
    ],
  );
}

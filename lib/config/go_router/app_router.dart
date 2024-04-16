import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/presentation/screen/screen.dart';

class RoutePath {
  static const String home = '/';
  static const String login = '/login';
}

class AppRouter {
  static get router => GoRouter(
    initialLocation: RoutePath.login,
    routes: [
      GoRoute(
        path: RoutePath.home,
        pageBuilder: (context, state) => const MaterialPage(child: HomeScreen()),
      ),
      GoRoute(
        path: RoutePath.login,
        pageBuilder: (context, state) => const MaterialPage(child: LoginScreen()),
      ),
    ],
  );
}
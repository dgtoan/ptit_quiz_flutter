import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/blocs/auth_bloc/auth_bloc.dart';

import '../../presentation/screens/screen.dart';

part 'app_routes.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

  static get appRouter => GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.home,
    redirect: (context, state) {
      final authState = context.read<AuthBloc>().state;
      
      if (
        authState is! AuthStateAuthenticated &&
        authState is! AuthStateAdminAuthenticated
      ) {
        if (!AppRoutes.publicRoutes.contains(state.matchedLocation)) {
          return AppRoutes.login;
        }
        return null;
      } else {
        if (
          AppRoutes.publicRoutes.contains(state.matchedLocation) ||
          state.matchedLocation == AppRoutes.initial
        ) {
          return AppRoutes.home;
        } else if (!AppRoutes.validRoutes.contains(state.matchedLocation)) {
          return AppRoutes.invalidRoute;
        }
        return null;
      }
    },
    routes: [
      // App Routes
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.exam,
        builder: (context, state) => Placeholder(),
      ),

      // Auth Routes
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminLogin,
        builder: (context, state) => LoginScreen(isAdmin: true),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => RegisterScreen(),
      ),

      // Invalid Route
      GoRoute(
        path: AppRoutes.invalidRoute,
        builder: (context, state) => Placeholder(),
      ),
    ],
  );
}

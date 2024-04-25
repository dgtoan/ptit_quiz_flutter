import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/blocs/auth_bloc/auth_bloc.dart';

import '../../presentation/screens/screen.dart';
import '../../presentation/screens/widgets/widgets.dart';

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
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => AppSideNavigation(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.home,
            pageBuilder: (context, state) => buildCustomTransitionPage<void>(
              context: context,
              state: state,
              child: const HomeScreen(),
            ),
          ),
          GoRoute(
            path: AppRoutes.exam,
            pageBuilder: (context, state) => buildCustomTransitionPage<void>(
              context: context,
              state: state,
              child: const HomeScreen(),
            ),
          ),
        ],
      ),
      // Auth Routes
      GoRoute(
        path: AppRoutes.login,
        pageBuilder: (context, state) => buildCustomTransitionPage<void>(
          context: context,
          state: state,
          child: const LoginScreen(isAdmin: false),
        ),
      ),
      GoRoute(
        path: AppRoutes.adminLogin,
        pageBuilder: (context, state) => buildCustomTransitionPage<void>(
          context: context,
          state: state,
          child: const LoginScreen(isAdmin: true),
        ),
      ),
      GoRoute(
        path: AppRoutes.register,
        pageBuilder: (context, state) => buildCustomTransitionPage<void>(
          context: context,
          state: state,
          child: const RegisterScreen(),
        ),
      ),

      // Invalid Route
      GoRoute(
        path: AppRoutes.invalidRoute,
        pageBuilder: (context, state) => buildCustomTransitionPage<void>(
          context: context,
          state: state,
          child: const Placeholder(),
        ),
      ),
    ],
  );
}


CustomTransitionPage buildCustomTransitionPage<T>({
  required BuildContext context, 
  required GoRouterState state, 
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) => 
      FadeTransition(opacity: animation, child: child)
  );
}

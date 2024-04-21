part of 'app_router.dart';

class AppRoutes {
  static const initial = '/';
  static const home = '/home';
  static const exam = '/exam';
  static const login = '/auth/login';
  static const adminLogin = '/auth/admin-login';
  static const register = '/auth/register';
  static const invalidRoute = '/404';

  static const validRoutes = [
    initial,
    home,
    exam,
    login,
    register,
  ];

  static const publicRoutes = [
    login,
    adminLogin,
    register,
  ];

}
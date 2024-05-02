part of 'app_router.dart';

class AppRoutes {
  // user routes
  static const initial = '/';
  static const home = '/home';
  static const exam = '/exam';
  static const examDetail = '/exam/:examId';
  static const result = '/result';
  static const resultDetail = '/result/:resultId';

  // admin routes
  static const adminExam = '/admin/exam-management';
  static const adminResult = '/admin/result-management';
  static const adminStatistics = '/admin/statistics';
  static const adminUser = '/admin/user-management';

  // auth routes
  static const login = '/auth/login';
  static const adminLogin = '/auth/admin-login';
  static const register = '/auth/register';
  static const invalidRoute = '/404';

  static const validRoutes = [
    initial,
    home,
    exam,
    result,
    resultDetail,
    adminExam,
    adminResult,
    adminStatistics,
    adminUser,
    login,
    adminLogin,
    register,
    invalidRoute,
  ];

  static const publicRoutes = [
    login,
    adminLogin,
    register,
  ];

}
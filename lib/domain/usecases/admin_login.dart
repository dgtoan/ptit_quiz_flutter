import 'package:ptit_quiz_frontend/domain/entities/account.dart';
import 'package:ptit_quiz_frontend/domain/repositories/auth_repository.dart';

import '../../data/models/account_model.dart';

class AdminLogin {
  final AuthRepository _authRepository;

  AdminLogin({required AuthRepository authRepository}) : _authRepository = authRepository;

  Future<Map<String, dynamic>> call(Account account) {
    return _authRepository.adminLogin(account);
  }
}
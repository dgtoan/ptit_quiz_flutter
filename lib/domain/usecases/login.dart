import 'package:ptit_quiz_frontend/data/models/account_model.dart';
import 'package:ptit_quiz_frontend/domain/entities/account.dart';
import 'package:ptit_quiz_frontend/domain/repositories/auth_repository.dart';

class Login {
  final AuthRepository _authRepository;

  Login({required AuthRepository authRepository}) : _authRepository = authRepository;

  Future<Map<String, dynamic>> call(Account account) {
    return _authRepository.login(account);
  }
}
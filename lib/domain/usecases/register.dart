import 'package:ptit_quiz_frontend/data/models/account_model.dart';
import 'package:ptit_quiz_frontend/data/models/profile_model.dart';
import 'package:ptit_quiz_frontend/domain/entities/profile.dart';
import 'package:ptit_quiz_frontend/domain/repositories/auth_repository.dart';

import '../entities/account.dart';

class Register {
  final AuthRepository _authRepository;

  Register({required AuthRepository authRepository}) : _authRepository = authRepository;

  Future<Map<String, dynamic>> call(Account account, Profile profile) {
    return _authRepository.register(account, profile);
  }
}
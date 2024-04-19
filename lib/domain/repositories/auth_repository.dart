import 'package:ptit_quiz_frontend/data/models/account_model.dart';
import 'package:ptit_quiz_frontend/data/models/profile_model.dart';

import '../entities/account.dart';
import '../entities/profile.dart';

abstract class AuthRepository {
  Future<Map<String, dynamic>> login(Account user);
  Future<Map<String, dynamic>> adminLogin(Account user);
  Future<Map<String, dynamic>> register(Account user, Profile profile);
}
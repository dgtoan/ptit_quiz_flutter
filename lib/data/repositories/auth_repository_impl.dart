
import 'package:ptit_quiz_frontend/data/models/account_model.dart';
import 'package:ptit_quiz_frontend/data/models/profile_model.dart';
import 'package:ptit_quiz_frontend/domain/entities/account.dart';
import 'package:ptit_quiz_frontend/domain/entities/profile.dart';

import '../../domain/repositories/auth_repository.dart';
import '../providers/local_data.dart';
import '../providers/remote_data.dart';

class AuthRepositoryImpl implements AuthRepository {
  final LocalData localData;
  final RemoteData remoteData;

  AuthRepositoryImpl({required this.localData, required this.remoteData});

  @override
  Future<Map<String, dynamic>> login(Account account) async {
    final response = await remoteData.login(AccountModel.fromEntity(account));
    await localData.saveToken(response['access_token']);
    await localData.saveRefreshToken(response['refresh_token']);
    return response;
  }

  @override
  Future<Map<String, dynamic>> adminLogin(Account account) async {
    final response = await remoteData.adminLogin(AccountModel.fromEntity(account));
    await localData.saveToken(response['access_token']);
    await localData.saveRefreshToken(response['refresh_token']);
    return response;
  }

  @override
  Future<Map<String, dynamic>> register(Account account, Profile profile) async {
    final response = await remoteData.register(AccountModel.fromEntity(account), ProfileModel.fromEntity(profile));
    await localData.saveToken(response['access_token']);
    await localData.saveRefreshToken(response['refresh_token']);
    return response;
  }
}
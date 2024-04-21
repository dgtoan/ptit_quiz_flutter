import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/account.dart';
import '../../../domain/entities/profile.dart';
import '../../../domain/usecases/admin_login.dart';
import '../../../domain/usecases/login.dart';
import '../../../domain/usecases/register.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late Login _login;
  late Register _register;
  late AdminLogin _adminLogin;
  late Stream<bool> _authSubscription;

  AuthBloc({
    required Login login,
    required Register register,
    required AdminLogin adminLogin,
    required Stream<bool> authSubscription,
  }) : super(const AuthStateUnauthenticated()) {
    _login = login;
    _register = register;
    _adminLogin = adminLogin;
    _authSubscription = authSubscription;

    on<AuthLoginEvent>(_onLogin);
    on<AuthAdminLoginEvent>(_onAdminLogin);
    on<AuthRegisterEvent>(_onRegister);
    on<AuthLogoutEvent>(_onLogout);

    _authSubscription.listen((isAuthenticated) {
      if (!isAuthenticated) {
        add(const AuthLogoutEvent());
      }
    });
  }

  Future<void> _onLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(const AuthStateLoading());
    try {
      await _login(event.account);
      emit(const AuthStateAuthenticated());
    } on DioException catch (e) {
      emit(AuthStateError(message: e.response?.data['message'] ?? e.toString()));
    }
  }

  Future<void> _onAdminLogin(AuthAdminLoginEvent event, Emitter<AuthState> emit) async {
    emit(const AuthStateLoading());
    try {
      await _adminLogin(event.account);
      emit(const AuthStateAdminAuthenticated());
    } on DioException catch (e) {
      emit(AuthStateError(message: e.response?.data['message'] ?? e.toString()));
    }
  }

  Future<void> _onRegister(AuthRegisterEvent event, Emitter<AuthState> emit) async {
    emit(const AuthStateLoading());
    try {
      await _register(event.account, event.profile);
      emit(const AuthStateAuthenticated());
    } on DioException catch (e) {
      emit(AuthStateError(message: e.response?.data['message'] ?? e.toString()));
    }
  }

  Future<void> _onLogout(AuthLogoutEvent event, Emitter<AuthState> emit) async {
    emit(const AuthStateUnauthenticated());
  }
}
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:ptit_quiz_frontend/domain/usecases/logout.dart';
import 'package:ptit_quiz_frontend/domain/usecases/validate.dart';
import 'package:ptit_quiz_frontend/domain/usecases/validate_admin.dart';

import '../../../domain/entities/account.dart';
import '../../../domain/entities/profile.dart';
import '../../../domain/usecases/admin_login.dart';
import '../../../domain/usecases/login.dart';
import '../../../domain/usecases/register.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late Login _login;
  late Logout _logout;
  late Register _register;
  late AdminLogin _adminLogin;
  late Validate _validate;
  late ValidateAdmin _validateAdmin;
  late Stream<bool> _authSubscription;

  AuthBloc({
    required Login login,
    required Logout logout,
    required Register register,
    required AdminLogin adminLogin,
    required Validate validate,
    required ValidateAdmin validateAdmin,
    required Stream<bool> authSubscription,
  }) : super(const AuthStateLoading()) {
    _login = login;
    _logout = logout;
    _register = register;
    _adminLogin = adminLogin;
    _validate = validate;
    _validateAdmin = validateAdmin;
    _authSubscription = authSubscription;

    on<AuthLoginEvent>(_onLogin);
    on<AuthAdminLoginEvent>(_onAdminLogin);
    on<AuthRegisterEvent>(_onRegister);
    on<AuthLogoutEvent>(_onLogout);
    on<AuthValidateEvent>(_onValidate);

    add(const AuthValidateEvent());

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
    await _logout();
    emit(const AuthStateUnauthenticated());
  }

  Future<void> _onValidate(AuthValidateEvent event, Emitter<AuthState> emit) async {
    emit(const AuthStateLoading());
    try {
      await _validate();
      emit(const AuthStateAuthenticated());
    } on DioException {
      try {
        await _validateAdmin();
        emit(const AuthStateAdminAuthenticated());
      } on DioException {
        emit(const AuthStateUnauthenticated());
      }
    }
  }
}
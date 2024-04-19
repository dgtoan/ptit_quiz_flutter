import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ptit_quiz_frontend/domain/entities/account.dart';
import 'package:ptit_quiz_frontend/domain/entities/profile.dart';
import 'package:ptit_quiz_frontend/presentation/blocs/app_bloc.dart';

import '../../../domain/usecases/admin_login.dart';
import '../../../domain/usecases/login.dart';
import '../../../domain/usecases/register.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late Login _login;
  late Register _register;
  late AdminLogin _adminLogin;

  AuthBloc({
    required Login login,
    required Register register,
    required AdminLogin adminLogin,
  }) : super(const AuthStateUnauthenticated()) {
    _login = login;
    _register = register;
    _adminLogin = adminLogin;

    on<AuthLoginEvent>(_onLogin);
    on<AuthAdminLoginEvent>(_onAdminLogin);
    on<AuthRegisterEvent>(_onRegister);
    on<AuthLogoutEvent>(_onLogout);
  }

  Future<void> _onLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(const AuthStateLoading());
    try {
      final response = await _login(event.account);
      emit(const AuthStateAuthenticated());
    } catch (e) {
      emit(AuthStateError(message: e.toString()));
    }
  }

  Future<void> _onAdminLogin(AuthAdminLoginEvent event, Emitter<AuthState> emit) async {
    emit(const AuthStateLoading());
    try {
      final response = await _adminLogin(event.account);
      emit(const AuthStateAdminAuthenticated());
    } catch (e) {
      emit(AuthStateError(message: e.toString()));
    }
  }

  Future<void> _onRegister(AuthRegisterEvent event, Emitter<AuthState> emit) async {
    emit(const AuthStateLoading());
    try {
      final response = await _register(event.account, event.profile);
      emit(const AuthStateAuthenticated());
    } catch (e) {
      emit(AuthStateError(message: e.toString()));
    }
  }

  Future<void> _onLogout(AuthLogoutEvent event, Emitter<AuthState> emit) async {
    emit(const AuthStateUnauthenticated());
  }
}
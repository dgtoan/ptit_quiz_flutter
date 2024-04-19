part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthStateLoading extends AuthState {
  const AuthStateLoading();

  @override
  List<Object> get props => [];
}

class AuthStateAuthenticated extends AuthState {
  const AuthStateAuthenticated();

  @override
  List<Object> get props => [];
}

class AuthStateAdminAuthenticated extends AuthState {
  const AuthStateAdminAuthenticated();

  @override
  List<Object> get props => [];
}

class AuthStateUnauthenticated extends AuthState {
  const AuthStateUnauthenticated();

  @override
  List<Object> get props => [];
}

class AuthStateError extends AuthState {
  final String message;
  const AuthStateError({required this.message});

  @override
  List<Object> get props => [message];
}
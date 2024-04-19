part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
} 

class AuthLoginEvent extends AuthEvent {
  final Account account;
  const AuthLoginEvent({required this.account});

  @override
  List<Object> get props => [account];
}

class AuthAdminLoginEvent extends AuthEvent {
  final Account account;
  const AuthAdminLoginEvent({required this.account});

  @override
  List<Object> get props => [account];
}

class AuthRegisterEvent extends AuthEvent {
  final Account account;
  final Profile profile;
  const AuthRegisterEvent({required this.account, required this.profile});

  @override
  List<Object> get props => [account];
}

class AuthLogoutEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

part of 'auth_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class InitEvent extends LoginEvent {
  const InitEvent();

  @override
  List<Object> get props => [];
}

class LogoutEvent extends LoginEvent {
  const LogoutEvent();

  @override
  List<Object> get props => [];
}

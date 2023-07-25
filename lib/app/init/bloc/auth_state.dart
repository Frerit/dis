part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class UserloggingInState extends AuthState {
  const UserloggingInState(this.idToken);
  final String idToken;

  @override
  List<Object> get props => [idToken];
}

class ProgressState extends AuthState {
  final String step;

  const ProgressState(this.step);

  @override
  List<Object> get props => [step];
}

class ErrorState extends AuthState {
  final String error;

  const ErrorState(this.error);

  @override
  List<Object> get props => [error];
}

part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
}

class SignUpInitial extends SignUpState {
  @override
  List<Object> get props => [];
}

class LoadingPasswordState extends SignUpState {
  @override
  List<Object?> get props => [];
}

class FailureEmailState extends SignUpState {
  final String message;

  const FailureEmailState({required this.message});

  @override
  List<Object?> get props => [];
}

class SuccesLoginState extends SignUpState {
  final SignUpModel signup;

  const SuccesLoginState(this.signup);

  @override
  List<Object?> get props => [signup];
}

class SuccesAccountState extends SignUpState {
  final SignUpModel signup;

  const SuccesAccountState(this.signup);

  @override
  List<Object?> get props => [signup];
}

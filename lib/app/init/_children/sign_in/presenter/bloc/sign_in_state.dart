part of 'sign_in_bloc.dart';

class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

class SignInInitialState extends SignInState {}

class LoadingEmailState extends SignInState {}

class FailureEmailState extends SignInState {
  final String message;

  const FailureEmailState({required this.message});
}

class SuccessEmailState extends SignInState {
  final String email;
  final EmailExistModel exist;

  const SuccessEmailState({
    required this.email,
    required this.exist,
  });
}

class CreateAccountNewState extends SignInState {
  final String email;

  const CreateAccountNewState({required this.email});
}

class CreateAccountFromDisState extends SignInState {
  final EmailExistModel exist;

  const CreateAccountFromDisState({
    required this.exist,
  });
}

class SuccessNoEmailState extends SignInState {
  final String email;

  const SuccessNoEmailState({required this.email});
}

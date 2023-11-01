part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
}

class InitialSignUpEvent extends SignUpEvent {
  final SignUpModel signup;

  InitialSignUpEvent({required this.signup});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ContinueWithPasswordEvent extends SignUpEvent {
  final SignUpModel signup;

  const ContinueWithPasswordEvent(this.signup);

  @override
  List<Object?> get props => [signup];
}

class LoginWithPasswordEvent extends SignUpEvent {
  final SignUpModel signup;

  const LoginWithPasswordEvent(this.signup);

  @override
  List<Object?> get props => [signup];
}

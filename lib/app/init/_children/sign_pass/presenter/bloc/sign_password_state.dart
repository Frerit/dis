part of 'sign_password_bloc.dart';

@immutable
abstract class SignPasswordState extends Equatable {
  const SignPasswordState();

  @override
  List<Object?> get props => [];
}

class SignPasswordInitial extends SignPasswordState {}

class LoadingValidatePasswordState extends SignPasswordState {}

class SuccessDistributorState extends SignPasswordState {}

class SuccessNewDistributorState extends SignPasswordState {}

class FailureLoginState extends SignPasswordState {
  final String message;

  const FailureLoginState(this.message);

  @override
  List<Object?> get props => [message];
}

part of 'sign_user_bloc.dart';

@immutable
abstract class SignUserState {}

class SignUserInitial extends SignUserState {}

class FailureGetUerState extends SignUserState {}

class SuccessGetUserClientState extends SignUserState {
  final SignUpModel model;

  SuccessGetUserClientState({required this.model});
}

class SuccessGetUserDisState extends SignUserState {}

part of 'sign_password_bloc.dart';

@immutable
abstract class SignPasswordEvent {}

class InitalPasswordEvent extends SignPasswordEvent {}

class LoginWithPasswordEvent extends SignPasswordEvent {
  final EmailExistModel exist;
  final String password;

  LoginWithPasswordEvent(this.exist, this.password);
}

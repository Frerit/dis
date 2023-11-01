part of 'sign_in_bloc.dart';

class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class SearchEmailEvent extends SignInEvent {
  final String email;

  const SearchEmailEvent({required this.email});

  @override
  List<Object> get props => [email];
}

part of 'sign_user_bloc.dart';

@immutable
abstract class SignUserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialSignUserEvent extends SignUserEvent {
  final bool newDis;

  InitialSignUserEvent({required this.newDis});
}

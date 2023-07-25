import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<LoginEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<InitEvent>(_initEvent);
  }

  void _initEvent(InitEvent event, Emitter<AuthState> emit) {
    emit(const ProgressState("Cargando"));
  }
}

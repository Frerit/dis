import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:progressprodis/app/init/data/repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<LoginEvent, AuthState> {
  AuthBloc(this._repository) : super(const AuthState()) {
    on<InitEvent>(_initEvent);
  }

  final AuthRepository _repository;

  void _initEvent(InitEvent event, Emitter<AuthState> emit) async {
    emit(const ProgressState("Cargando"));
    await Future.delayed(const Duration(seconds: 1));
    try {
      final lookOnboarding = await _repository.isLookOnboarding();
      if (!lookOnboarding) {
        await Future.delayed(const Duration(seconds: 4));
        emit(GoToGetStartState());
      } else {
        emit(GoToOnboardingState());
      }
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}

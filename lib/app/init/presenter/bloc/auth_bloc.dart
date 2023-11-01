import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:progressprodis/app/init/data/repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<LoginEvent, AuthState> {
  AuthBloc(this._repository) : super(const AuthState()) {
    on<InitEvent>(_initEvent);
    on<LogoutEvent>(_onLogoutEvent);
  }

  final AuthRepository _repository;

  void _initEvent(InitEvent event, Emitter<AuthState> emit) async {
    emit(const ProgressState("Cargando"));
    try {
      final isSigned = await _repository.isSignedIn();
      await Future.delayed(const Duration(seconds: 1));
      if (!isSigned) {
        final lookOnboarding = await _repository.isLookOnboarding();
        if (!lookOnboarding) {
          await Future.delayed(const Duration(seconds: 4));
          emit(GoToGetStartState());
        } else {
          emit(GoToOnboardingState());
        }
      } else {
        emit(GoToHomeState());
      }
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  _onLogoutEvent(LogoutEvent event, Emitter<AuthState> emit) async {
    final _ = await _repository.logoutSession();
    emit(SessionInitialState());
  }
}

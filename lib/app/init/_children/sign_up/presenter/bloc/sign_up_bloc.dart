import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:progressprodis/app/init/data/repository.dart';
import 'package:progressprodis/app/init/domain/models/sign_up_model.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc(this._repository) : super(SignUpInitial()) {
    on<InitialSignUpEvent>(onInitialSignUpEvent);
    on<ContinueWithPasswordEvent>(onContinueWithPasswordEvent);
    on<LoginWithPasswordEvent>(onLoginWithPasswordEvent);
  }

  final AuthRepository _repository;
  SignUpModel model = SignUpModel(
    firstName: "",
    email: "",
    password: "",
  );

  void onInitialSignUpEvent(
      InitialSignUpEvent event, Emitter<SignUpState> emit) {
    model = event.signup;
    emit(SignUpInitial());
  }

  void onLoginWithPasswordEvent(
    LoginWithPasswordEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(LoadingPasswordState());
    model = event.signup;
    final loginOrFailure = await _repository.loginWhitPassword(model);
    loginOrFailure.fold(
      (l) => emit(FailureEmailState(message: l)),
      (r) => emit(SuccesLoginState(model)),
    );
  }

  void onContinueWithPasswordEvent(
    ContinueWithPasswordEvent event,
    Emitter<SignUpState> emit,
  ) {
    emit(LoadingPasswordState());
    model = event.signup;
    emit(SuccesAccountState(model));
  }
}

enum CountryLabel {
  colombia('Colombia', 'https://flagicons.lipis.dev/flags/4x3/co.svg', "+57"),
  mexico('Mexico', 'https://flagicons.lipis.dev/flags/4x3/mx.svg', "+52"),
  brasil('Ecuador', "https://flagicons.lipis.dev/flags/4x3/ec.svg", "+593");

  const CountryLabel(this.label, this.flag, this.indi);

  final String label;
  final String flag;
  final String indi;
}

enum ProfecionLabel {
  enprovir('Entrenador profesional', "1"),
  nutricio('Nutricionista', "2"),
  enperson('Entrenador Personal fisico', "3"),
  coachbl('Coach Nutricion HBL', "4");

  const ProfecionLabel(this.label, this.id);

  final String label;
  final String id;
}

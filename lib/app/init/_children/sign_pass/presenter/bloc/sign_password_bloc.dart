import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:progressprodis/app/init/data/repository.dart';
import 'package:progressprodis/app/init/domain/models/email_exist_model.dart';
import 'package:progressprodis/global/user/user_data.dart';

part 'sign_password_event.dart';
part 'sign_password_state.dart';

class SignPasswordBloc extends Bloc<SignPasswordEvent, SignPasswordState> {
  SignPasswordBloc(this._repository) : super(SignPasswordInitial()) {
    on<LoginWithPasswordEvent>(onLoginWithPasswordEvent);
    on<InitalPasswordEvent>(onInitalPasswordEvent);
  }

  final AuthRepository _repository;

  onInitalPasswordEvent(
    InitalPasswordEvent event,
    Emitter<SignPasswordState> emit,
  ) {
    emit(SignPasswordInitial());
  }

  onLoginWithPasswordEvent(
      LoginWithPasswordEvent event, Emitter<SignPasswordState> emit) async {
    emit(LoadingValidatePasswordState());
    final loginOrFailure = await _repository.validateAccess(
      event.exist.email,
      event.password,
    );
    loginOrFailure.fold(
      (l) => emit(FailureLoginState(l)),
      (r) {
        if (event.exist.isCliente) {
          UserData.setHash(event.password);
          if (event.exist.isDistributor) {
            emit(SuccessDistributorState());
          } else {
            emit(SuccessNewDistributorState());
          }
        } else {
          emit(SuccessDistributorState());
        }
      },
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progressprodis/app/init/data/repository.dart';
import 'package:progressprodis/app/init/domain/models/email_exist_model.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc(this._repository) : super(SignInInitialState()) {
    on<SearchEmailEvent>(onSearchEmailEvent);
  }

  final AuthRepository _repository;

  void onSearchEmailEvent(
      SearchEmailEvent event, Emitter<SignInState> emit) async {
    emit(LoadingEmailState());
    try {
      final failureOrExist = await _repository.thisEmailExist(event.email);
      failureOrExist.fold(
        (l) => emit(FailureEmailState(message: l)),
        (r) {
          if (r.isCliente && !r.isDistributor) {
            emit(CreateAccountFromDisState(exist: r));
          } else if (r.isDistributor) {
            emit(SuccessEmailState(email: r.email, exist: r));
          } else {
            emit(CreateAccountNewState(email: r.email));
          }
        },
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Ha ocurrido un error: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 11.0,
      );
    }
  }
}

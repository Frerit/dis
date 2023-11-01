import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:progressprodis/app/init/data/repository.dart';
import 'package:progressprodis/app/init/domain/models/sign_up_model.dart';
import 'package:progressprodis/global/user/user_data.dart';

part 'sign_user_event.dart';
part 'sign_user_state.dart';

class SignUserBloc extends Bloc<SignUserEvent, SignUserState> {
  SignUserBloc(this._repository) : super(SignUserInitial()) {
    on<InitialSignUserEvent>(onInitialSignUserEvent);
  }

  final AuthRepository _repository;

  onInitialSignUserEvent(
      InitialSignUserEvent event, Emitter<SignUserState> emit) async {
    final failureOrUser = await _repository.getUserbyId(
      event.newDis,
    );
    failureOrUser.fold(
      (l) => emit(FailureGetUerState()),
      (user) {
        UserData.saveFromLogin(user);
        if (user.isNewDis!) {
          final userFromClient = SignUpModel(
            firstName: user.name ?? "",
            lastName: user.lastName ?? "",
            email: user.email ?? "",
            password: UserData.hash,
            country: user.country ?? "",
            sponsor: user.sponsor ?? "",
            isNewDis: true,
          );
          emit(SuccessGetUserClientState(model: userFromClient));
        } else {
          emit(SuccessGetUserDisState());
        }
      },
    );
  }
}

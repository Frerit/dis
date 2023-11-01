import 'package:flutter_modular/flutter_modular.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:progressprodis/app/init/_children/sign_up/presenter/bloc/sign_up_bloc.dart';
import 'package:progressprodis/app/init/_children/sign_up/presenter/page/sign_profecion_page.dart';
import 'package:progressprodis/app/init/_children/sign_up/presenter/page/sign_register_page.dart';
import 'package:progressprodis/app/init/_children/sign_up/presenter/page/sign_sponsor_page.dart';
import 'package:progressprodis/app/init/_children/sign_up/presenter/page/sign_up_page.dart';
import 'package:progressprodis/app/init/_children/sign_user/presenter/page/sign_user_page.dart';
import 'package:progressprodis/app/init/data/repository.dart';

class RegisterModule extends Module {
  static const String signUpRoute = "/sign_up";
  static const String signUpRegister = "$signUpRoute/sign_register";
  static const String signUpProfecion = "$signUpRoute/sign_profecion";
  static const String signUpSponsor = "$signUpRoute/sign_sponsor";
  static const String signUser = "$signUpRoute/sign_user";

  @override
  void binds(Injector i) {
    i.addInstance(Supabase.instance.client);

    i.add(AuthRepository.new);

    i.addLazySingleton(SignUpBloc.new);
  }

  @override
  void routes(RouteManager r) {
    r.child("/", child: (context) => SignUpPage(email: r.args.data));

    r.child(
      "/sign_register",
      child: (context) => SignRegisterPage(signup: r.args.data),
    );
    r.child(
      "/sign_profecion",
      child: (context) => SignProfecionPage(signup: r.args.data),
    );
    r.child(
      "/sign_sponsor",
      child: (context) => SignSponsorPage(),
    );
    r.child(
      "/sign_user",
      child: (context) => SignUserPage(isNewDis: r.args.data),
    );
  }
}

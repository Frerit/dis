import 'package:flutter_modular/flutter_modular.dart';
import 'package:progressprodis/app/init/_children/onboarding/page/onboarding_page.dart';
import 'package:progressprodis/app/init/_children/sign_in/presenter/page/sign_in_page.dart';
import 'package:progressprodis/app/init/_children/started/presenter/page/get_starter_page.dart';
import 'package:progressprodis/app/init/bloc/auth_bloc.dart';
import 'package:progressprodis/app/init/data/repository.dart';
import 'package:progressprodis/app/init/page/page.dart';
import 'package:progressprodis/global/init/appconfig.dart';

class AppModule extends Module {
  static const String getStarted = "/get_started";
  static const String onboardingRoute = "/onboarding";
  static const String signInRoute = "/sign_in";
  static const String signUpRoute = "/sign_up";

  @override
  void binds(Injector i) {
    i.add(AuthRepository.new);
    i.addSingleton(AuthBloc.new);
    i.addInstance(AppConfig(name: "ProgressPro"));
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const InitPage());
    r.child(
      getStarted,
      transition: TransitionType.fadeIn,
      child: (context) => const GetStarterPage(),
    );
    r.child(
      onboardingRoute,
      transition: TransitionType.fadeIn,
      child: (context) => const OnboardingPage(),
    );
    r.child(
      signInRoute,
      transition: TransitionType.rightToLeft,
      child: (context) => const SignInPage(),
    );
  }
}

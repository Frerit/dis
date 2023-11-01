import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:progressprodis/app/home/presenter/module.dart';
import 'package:progressprodis/app/init/presenter/bloc/auth_bloc.dart';
import 'package:progressprodis/module.dart';

class AuthManager extends StatelessWidget {
  const AuthManager({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: Modular.get<AuthBloc>(),
      child: AuthManagerBody(children: child),
    );
  }
}

class AuthManagerBody extends StatelessWidget {
  const AuthManagerBody({Key? key, required this.children}) : super(key: key);
  final Widget children;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is GoToOnboardingState) {
          Modular.to.pushReplacementNamed(AppModule.onboardingRoute);
        } else if (state is GoToGetStartState) {
          Modular.to.pushReplacementNamed(AppModule.getStarted);
        } else if (state is SessionInitialState) {
          Modular.to.pushReplacementNamed(AppModule.getStarted);
        } else if (state is GoToHomeState) {
          Modular.to.pushReplacementNamed(HomeModule.getHome);
        }
      },
      builder: (context, state) => children,
    );
  }
}

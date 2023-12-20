import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:progressprodis/desing/tokens/_tokens.dart';
import 'package:progressprodis/app/home/presenter/module.dart';
import 'package:progressprodis/app/init/_children/sign_user/presenter/bloc/sign_user_bloc.dart';
import 'package:progressprodis/app/init/module.dart';

class SignUserPage extends StatelessWidget {
  const SignUserPage({Key? key, required this.isNewDis}) : super(key: key);

  final bool isNewDis;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUserBloc>(
      create: (context) => Modular.get<SignUserBloc>()
        ..add(
          InitialSignUserEvent(newDis: isNewDis),
        ),
      child: BlocListener<SignUserBloc, SignUserState>(
        listener: (context, state) {
          if (state is SuccessGetUserDisState) {
            Modular.to.pushReplacementNamed(HomeModule.getHome);
          } else if (state is SuccessGetUserClientState) {
            Modular.to.pushNamed(
              RegisterModule.signUpProfecion,
              arguments: state.model,
            );
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xFF20D156),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SvgPicture.asset(
                  "assets/logos/logo_white.svg",
                  height: 150,
                  width: 150,
                ),
              ),
              const SizedBox(height: 20),
              SvgPicture.asset(
                "assets/logos/name.svg",
                width: 150,
              ),
              const SizedBox(height: 20),
              const SizedBox(
                width: 21,
                height: 21,
                child: CircularProgressIndicator(
                  color: AppColors.white,
                  strokeWidth: 1.9,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:progressprodis/app/init/bloc/auth_bloc.dart';
import 'package:progressprodis/global/init/appconfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';

class InitPage extends StatelessWidget {
  const InitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: Modular.get<AuthBloc>()..add(const InitEvent()),
      child: const InitBody(),
    );
  }
}

class InitBody extends StatelessWidget {
  const InitBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
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
              Text(
                state is ProgressState ? state.step : "Cargando..",
                style: const TextStyle(
                  color: Colors.white,
                ),
              )
            ],
          ),
          bottomNavigationBar: SizedBox(
            height: 50,
            child: Text(
              Modular.get<AppConfig>().version,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}

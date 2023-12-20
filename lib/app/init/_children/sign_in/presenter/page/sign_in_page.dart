import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progressprodis/desing/tokens/_tokens.dart';
import 'package:progressprodis/app/init/_children/sign_in/presenter/bloc/sign_in_bloc.dart';
import 'package:progressprodis/module.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInBloc>(
      create: (context) => Modular.get<SignInBloc>(),
      child: BlocListener<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is CreateAccountNewState) {
            Modular.to.pushNamed(
              AppModule.signUpRoute,
              arguments: state.email,
            );
          } else if (state is CreateAccountFromDisState) {
            Modular.to.pushNamed(
              AppModule.signPassRoute,
              arguments: state.exist,
            );
          } else if (state is SuccessEmailState) {
            Modular.to.pushNamed(
              AppModule.signPassRoute,
              arguments: state.exist,
            );
          } else if (state is FailureEmailState) {
            Fluttertoast.showToast(
              msg: "Ha ocurrido un error: ${state.message}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 11.0,
            );
          }
        },
        child: _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  _Body();

  final fieldText = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final _emailRegex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: AppColors.primaryDarkColor,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 30, right: 50, top: 20),
                child: Text(
                  "¿Cual es tu correo electronico?",
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 30,
                ),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: fieldText,
                    cursorColor: Theme.of(context).dividerColor,
                    autofocus: true,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa un email';
                      }
                      if (value != null && !_emailRegex.hasMatch(value)) {
                        return 'Por favor ingresa una correo valido';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'EMAIL',
                      labelStyle: const TextStyle(
                        color: AppColors.quickSilver,
                        fontWeight: FontWeight.w600,
                      ),
                      errorStyle: const TextStyle(
                        color: AppColors.lila,
                      ),
                      errorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lila, width: 2),
                      ),
                      focusedErrorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lila, width: 2),
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.close_rounded,
                          color: AppColors.disabeleColor,
                          size: 15,
                        ),
                        onPressed: () => fieldText.clear(),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.dividerColor, width: 2),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.dividerColor, width: 0.2),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: BlocBuilder<SignInBloc, SignInState>(
                    builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Modular.get<SignInBloc>().add(
                          SearchEmailEvent(
                            email: fieldText.text,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: state is LoadingEmailState
                        ? const SizedBox(
                            width: 21,
                            height: 21,
                            child: CircularProgressIndicator(
                              color: AppColors.white,
                              strokeWidth: 1.9,
                            ),
                          )
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.email),
                              SizedBox(width: 9),
                              Text(
                                "Continuar con tu email",
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                  );
                }),
              )
            ],
          ),
        ),
      )),
    );
  }
}

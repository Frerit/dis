import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:progress_desing/progress_desing.dart';
import 'package:progressprodis/app/init/_children/sign_up/presenter/bloc/sign_up_bloc.dart';
import 'package:progressprodis/app/init/domain/models/sign_up_model.dart';
import 'package:progressprodis/app/init/module.dart';

class SignUpPage extends StatefulWidget {
  final String email;

  const SignUpPage({super.key, required this.email});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final fieldName = TextEditingController();
  final fieldPassword = TextEditingController();
  bool _obscureText = true;
  final _formRegKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpBloc>(
      create: (context) => Modular.get<SignUpBloc>(),
      child: BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SuccesAccountState) {
            Modular.to.pushNamed(
              RegisterModule.signUpRegister,
              arguments: state.signup,
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 1,
            backgroundColor: AppColors.primaryDarkColor,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Form(
                  key: _formRegKey,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                            left: 30, right: 50, top: 20, bottom: 20),
                        child: Row(
                          children: [
                            Text(
                              "Crear Cuenta",
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 35,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Row(
                            children: [
                              const Text(
                                "Usando ",
                                style: TextStyle(color: AppColors.dividerColor),
                              ),
                              Text(
                                widget.email,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700),
                              ),
                              const Text(" para registrarse")
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 30,
                        ),
                        child: TextFormField(
                          controller: fieldName,
                          cursorColor: Theme.of(context).dividerColor,
                          autofocus: true,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            labelText: 'NOMBRE',
                            labelStyle: TextStyle(
                              color: AppColors.quickSilver,
                              fontWeight: FontWeight.w600,
                            ),
                            errorStyle: TextStyle(
                              color: AppColors.lila,
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.lila, width: 2),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.lila, width: 2),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.dividerColor,
                                width: 2,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.dividerColor,
                                width: 0.2,
                              ),
                            ),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingresa un nombre';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 30, right: 30, top: 0, bottom: 30),
                        child: TextFormField(
                          controller: fieldPassword,
                          cursorColor: Theme.of(context).dividerColor,
                          autofocus: true,
                          obscureText: _obscureText,
                          textInputAction: TextInputAction.continueAction,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            labelText: 'CONTRASEÑA',
                            labelStyle: const TextStyle(
                              color: AppColors.quickSilver,
                              fontWeight: FontWeight.w600,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColors.disabeleColor,
                                size: 15,
                              ),
                              onPressed: () =>
                                  setState(() => _obscureText = !_obscureText),
                            ),
                            errorStyle: const TextStyle(
                              color: AppColors.lila,
                            ),
                            errorBorder: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.lila, width: 2),
                            ),
                            focusedErrorBorder: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.lila, width: 2),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.dividerColor, width: 2),
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.dividerColor, width: 0.2),
                            ),
                          ),
                          validator: (String? value) {
                            RegExp regex = RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$',
                            );
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingresa una contraseña valida';
                            }
                            if (!regex.hasMatch(value)) {
                              return 'Ingresa un contraseña valida \n(Mayor a 8 palabras, Mayusculas y digitos)';
                            }
                            return null;
                          },
                        ),
                      ),
                      BlocBuilder<SignUpBloc, SignUpState>(
                        builder: (context, state) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formRegKey.currentState!.validate()) {
                                  Modular.get<SignUpBloc>().add(
                                    ContinueWithPasswordEvent(
                                      SignUpModel(
                                        firstName: fieldName.text,
                                        email: widget.email,
                                        password: fieldPassword.text,
                                      ),
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
                              child: state is LoadingPasswordState
                                  ? const SizedBox(
                                      width: 21,
                                      height: 21,
                                      child: CircularProgressIndicator(
                                        color: AppColors.white,
                                        strokeWidth: 1.9,
                                      ),
                                    )
                                  : const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.email),
                                        SizedBox(width: 9),
                                        Text(
                                          "Continuar",
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

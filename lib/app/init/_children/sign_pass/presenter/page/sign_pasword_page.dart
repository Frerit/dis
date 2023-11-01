import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:progress_desing/progress_desing.dart';
import 'package:progressprodis/app/init/_children/sign_pass/presenter/bloc/sign_password_bloc.dart';
import 'package:progressprodis/app/init/domain/models/email_exist_model.dart';
import 'package:progressprodis/app/init/module.dart';

class SignPasswordPage extends StatefulWidget {
  final EmailExistModel exist;

  const SignPasswordPage({super.key, required this.exist});

  @override
  State<SignPasswordPage> createState() => _SignPasswordPageState();
}

class _SignPasswordPageState extends State<SignPasswordPage> {
  final fieldPassword = TextEditingController();
  bool _obscureText = true;
  var messageError = "";
  final _formLoginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignPasswordBloc>(
      create: (context) => Modular.get<SignPasswordBloc>(),
      child: BlocListener<SignPasswordBloc, SignPasswordState>(
        listener: (context, state) {
          if (state is FailureLoginState) {
            messageError = state.message;
            _formLoginKey.currentState?.validate();
          } else if (state is SuccessNewDistributorState) {
            Modular.to.pushNamed(
              RegisterModule.signUser,
              arguments: true,
            );
          } else if (state is SuccessDistributorState) {
            Modular.to.pushNamed(
              RegisterModule.signUser,
              arguments: false,
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
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 30, right: 50, top: 20, bottom: 20),
                    child: Row(
                      children: [
                        Text(
                          "Login",
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
                            widget.exist.email,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          const Text(" para ingresar")
                        ],
                      ),
                    ),
                  ),
                  Form(
                    key: _formLoginKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 30,
                      ),
                      child: BlocBuilder<SignPasswordBloc, SignPasswordState>(
                        builder: (context, state) {
                          return TextFormField(
                            controller: fieldPassword,
                            cursorColor: Theme.of(context).dividerColor,
                            autofocus: true,
                            obscureText: _obscureText,
                            keyboardType: TextInputType.visiblePassword,
                            onChanged: (value) {
                              Modular.get<SignPasswordBloc>().add(
                                InitalPasswordEvent(),
                              );
                              setState(() {
                                messageError = "";
                                _formLoginKey.currentState?.validate();
                              });
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingresa una constraseña valida';
                              } else if (value.isNotEmpty &&
                                  messageError.isNotEmpty) {
                                return messageError;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'CONTRASEÑA',
                              labelStyle: const TextStyle(
                                color: AppColors.quickSilver,
                                fontWeight: FontWeight.w600,
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
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: AppColors.disabeleColor,
                                  size: 15,
                                ),
                                onPressed: () => setState(
                                  () => _obscureText = !_obscureText,
                                ),
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
                          );
                        },
                      ),
                    ),
                  ),
                  BlocBuilder<SignPasswordBloc, SignPasswordState>(
                    builder: (context, state) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ElevatedButton(
                          onPressed: () {
                            if (fieldPassword.text.isNotEmpty) {
                              Modular.get<SignPasswordBloc>().add(
                                LoginWithPasswordEvent(
                                  widget.exist,
                                  fieldPassword.text,
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
                          child: state is LoadingValidatePasswordState
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
                                      "Ingresar",
                                      style: TextStyle(fontSize: 15),
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
          )),
        ),
      ),
    );
  }
}

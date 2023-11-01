import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:progress_desing/progress_desing.dart';
import 'package:progressprodis/app/home/presenter/module.dart';
import 'package:progressprodis/app/init/_children/sign_up/presenter/bloc/sign_up_bloc.dart';
import 'package:progressprodis/app/init/domain/models/sign_up_model.dart';
import 'package:progressprodis/app/init/module.dart';
import 'package:uuid/uuid.dart';

class SignProfecionPage extends StatefulWidget {
  final SignUpModel signup;

  const SignProfecionPage({Key? key, required this.signup}) : super(key: key);

  @override
  State<SignProfecionPage> createState() => _SignProfecionPageState();
}

class _SignProfecionPageState extends State<SignProfecionPage> {
  TextEditingController fielProfecion = TextEditingController();
  TextEditingController fieldid = TextEditingController();

  ProfecionLabel? selectedProfecion;
  var uuid = const Uuid();

  void generateID(ProfecionLabel profecion) {
    setState(() {
      selectedProfecion = profecion;
      String idRand = uuid.v4();
      if (profecion.id == "4") {
        fieldid.clear();
      } else {
        final letter = widget.signup.country.substring(0, 1);
        fieldid.text = "$letter${idRand.substring(27, 36)}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<ProfecionLabel>> iconEntries = [];
    for (final ProfecionLabel profecion in ProfecionLabel.values) {
      iconEntries.add(
        DropdownMenuEntry<ProfecionLabel>(
          value: profecion,
          label: profecion.label,
        ),
      );
    }

    return BlocProvider<SignUpBloc>(
      create: (context) {
        if (widget.signup.isNewDis) {
          return Modular.get<SignUpBloc>()
            ..add(
              InitialSignUpEvent(signup: widget.signup),
            );
        }
        return Modular.get<SignUpBloc>();
      },
      child: BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SuccesLoginState) {
            Modular.to.pushReplacementNamed(
              HomeModule.getHome,
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
                        child: const Text(
                          "Personalizaremos tu experiencia acorde a tu profecion ",
                          style: TextStyle(color: AppColors.dividerColor),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 0),
                      child: DropdownMenu<ProfecionLabel>(
                        controller: fielProfecion,
                        enableFilter: false,
                        label: const Text('Profecion que mejor te describa'),
                        width: MediaQuery.of(context).size.width * 0.85,
                        dropdownMenuEntries: iconEntries,
                        inputDecorationTheme: const InputDecorationTheme(
                          filled: false,
                          contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                        ),
                        onSelected: (ProfecionLabel? profecion) {
                          generateID(profecion!);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 30, left: 30, right: 30),
                      child: TextField(
                        controller: fieldid,
                        cursorColor: Theme.of(context).dividerColor,
                        autofocus: true,
                        maxLength: 10,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp("[a-zA-Z-0-9]"),
                          ),
                        ],
                        decoration: InputDecoration(
                          suffixIcon: selectedProfecion?.id != "4"
                              ? IconButton(
                                  onPressed: () =>
                                      generateID(selectedProfecion!),
                                  icon: const Icon(Icons.refresh),
                                )
                              : null,
                          labelText:
                              "ID ${selectedProfecion?.id == "4" ? "Herbalife" : ""}",
                          counterText: selectedProfecion?.id != "4"
                              ? "Identificador para compartir a tus clientes"
                              : null,
                          labelStyle: const TextStyle(
                            color: AppColors.quickSilver,
                            fontWeight: FontWeight.w600,
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.dividerColor,
                              width: 2,
                            ),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.dividerColor,
                              width: 0.2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: BlocBuilder<SignUpBloc, SignUpState>(
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: () {
                              final model = Modular.get<SignUpBloc>().model;
                              if (selectedProfecion?.id == "4") {
                                model.profesionType = selectedProfecion!.id;
                                model.profesionID = fieldid.text;
                                Modular.to.pushNamed(
                                  RegisterModule.signUpSponsor,
                                );
                              } else {
                                model.profesionType = selectedProfecion!.id;
                                model.profesionID = fieldid.text;
                                Modular.get<SignUpBloc>().add(
                                  LoginWithPasswordEvent(model),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.email),
                                      SizedBox(width: 9),
                                      Text(
                                        "Continuar",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

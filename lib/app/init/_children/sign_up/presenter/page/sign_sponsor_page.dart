import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:progress_desing/progress_desing.dart';
import 'package:progressprodis/app/init/_children/sign_up/presenter/bloc/sign_up_bloc.dart';

class SignSponsorPage extends StatelessWidget {
  SignSponsorPage({Key? key}) : super(key: key);

  final TextEditingController fieldStatus = TextEditingController();
  final TextEditingController fieldSponsor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpBloc>(
      create: (context) => Modular.get<SignUpBloc>(),
      child: BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          // TODO: implement listener
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
                            "Ultimo paso",
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
                          "Personaliza tu status y vinculate con tu sponsor",
                          style: TextStyle(color: AppColors.dividerColor),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 20, left: 30, right: 30),
                      child: TextField(
                        controller: fieldStatus,
                        cursorColor: Theme.of(context).dividerColor,
                        autofocus: true,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: 'Status de Herbalife',
                          labelStyle: TextStyle(
                            color: AppColors.quickSilver,
                            fontWeight: FontWeight.w600,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.dividerColor, width: 2),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.dividerColor, width: 0.2),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 0, bottom: 30, left: 30, right: 30),
                      child: TextField(
                        controller: fieldSponsor,
                        cursorColor: Theme.of(context).dividerColor,
                        autofocus: true,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: 'ID de Sponsor',
                          labelStyle: TextStyle(
                            color: AppColors.quickSilver,
                            fontWeight: FontWeight.w600,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.dividerColor, width: 2),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.dividerColor, width: 0.2),
                          ),
                        ),
                      ),
                    ),
                    BlocBuilder<SignUpBloc, SignUpState>(
                      builder: (context, state) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: ElevatedButton(
                            onPressed: () {
                              if (fieldSponsor.text.isNotEmpty) {
                                final model = Modular.get<SignUpBloc>().model;
                                model.status = fieldStatus.text;
                                model.sponsor = fieldSponsor.text;
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
    );
  }
}

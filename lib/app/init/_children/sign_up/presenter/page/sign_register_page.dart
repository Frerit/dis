import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:progress_desing/progress_desing.dart';
import 'package:progressprodis/app/init/_children/sign_up/presenter/bloc/sign_up_bloc.dart';
import 'package:progressprodis/app/init/domain/models/sign_up_model.dart';
import 'package:progressprodis/app/init/module.dart';

class SignRegisterPage extends StatefulWidget {
  final SignUpModel signup;

  const SignRegisterPage({
    Key? key,
    required this.signup,
  }) : super(key: key);

  @override
  State<SignRegisterPage> createState() => _SignRegisterPageState();
}

class _SignRegisterPageState extends State<SignRegisterPage> {
  TextEditingController fieldName = TextEditingController();
  TextEditingController fieldLastName = TextEditingController();
  TextEditingController fieldPhone = TextEditingController();
  TextEditingController fielCountry = TextEditingController();
  CountryLabel? selectedcountry;

  @override
  Widget build(BuildContext context) {
    fieldName = TextEditingController(text: widget.signup.firstName);
    final List<DropdownMenuEntry<CountryLabel>> iconEntries = [];
    for (final CountryLabel country in CountryLabel.values) {
      iconEntries.add(
        DropdownMenuEntry<CountryLabel>(
          value: country,
          label: country.label,
        ),
      );
    }
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
                  padding:
                      EdgeInsets.only(left: 30, right: 50, top: 20, bottom: 20),
                  child: Row(
                    children: [
                      Text(
                        "Crear Cuenta",
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.84,
                  child: const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(
                      "Ayudanos a personalizar la aplicación de acuerdo a tus necesidades ",
                      style: TextStyle(color: AppColors.dividerColor),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, top: 20, bottom: 20),
                  child: TextField(
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
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.dividerColor, width: 2),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.dividerColor,
                          width: 0.2,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                    right: 30,
                    bottom: 30,
                  ),
                  child: TextField(
                    controller: fieldLastName,
                    cursorColor: Theme.of(context).dividerColor,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                      labelText: 'APELLIDO',
                      labelStyle: TextStyle(
                        color: AppColors.quickSilver,
                        fontWeight: FontWeight.w600,
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
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 0, bottom: 30),
                    child: DropdownMenu<CountryLabel>(
                      controller: fielCountry,
                      enableFilter: false,
                      trailingIcon: selectedcountry != null
                          ? SvgPicture.network(
                              selectedcountry?.flag ?? "",
                              width: 20,
                            )
                          : const Icon(Icons.flag),
                      label: const Text('PAIS DE RESIDENCIA'),
                      width: MediaQuery.of(context).size.width * 0.85,
                      dropdownMenuEntries: iconEntries,
                      inputDecorationTheme: const InputDecorationTheme(
                        filled: false,
                        contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                      ),
                      onSelected: (CountryLabel? country) {
                        setState(() {
                          selectedcountry = country;
                        });
                      },
                    )),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton(
                    onPressed: () {
                      final model = Modular.get<SignUpBloc>().model;
                      model.lastName = fieldLastName.text;
                      model.country = selectedcountry?.label ?? "";
                      Modular.to.pushNamed(
                        RegisterModule.signUpProfecion,
                        arguments: model,
                      );
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
                    child: const Row(
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
                ),
                const SizedBox(height: 20)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

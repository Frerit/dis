import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:progress_desing/progress_desing.dart';
import 'package:progressprodis/app/activity/module.dart';
import 'package:progressprodis/global/user/user_data.dart';

class AddGroup extends StatefulWidget {
  AddGroup({Key? key}) : super(key: key);

  @override
  State<AddGroup> createState() => _AddGroupState();
}

class _AddGroupState extends State<AddGroup> {
  TextEditingController fieldNameTeam = TextEditingController();
  MaterialColor? randomColor;
  List<int> teams = [0, 1];

  void generateColor() {
    setState(() {
      randomColor = Colors.primaries[Random().nextInt(18)];
    });
  }

  @override
  Widget build(BuildContext context) {
    generateColor();
    final viewSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        child: Container(
          height: viewSize.height * 0.33,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 19, 19, 20),
            borderRadius: BorderRadius.circular(
              20,
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
                height: 3,
                width: 100,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 50,
                    child: IconButton(
                      icon: Container(
                        height: 15,
                        width: 15,
                        margin: const EdgeInsets.only(top: 0),
                        decoration: BoxDecoration(
                            color: randomColor,
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      onPressed: () => generateColor(),
                    ),
                  ),
                  SizedBox(
                    width: viewSize.width * 0.7,
                    child: TextFormField(
                      controller: fieldNameTeam,
                      cursorColor: Theme.of(context).dividerColor,
                      autofocus: true,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        hintText: "Nombre del Grupo...",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.raisenBlak,
                        ),
                        labelStyle: TextStyle(
                          color: AppColors.quickSilver,
                          fontWeight: FontWeight.w600,
                        ),
                        focusedBorder: InputBorder.none,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10, bottom: 20),
                child: InkWell(
                  onTap: () async {
                    final result = await Modular.to.pushNamed(
                      ActivityModule.newGroupRoute,
                    );
                    print(result);
                  },
                  child: InkWell(
                    onTap: () async {
                      List<int> teamsList = await Modular.to.pushNamed(
                            ActivityModule.newGroupRoute,
                          ) ??
                          [];
                      setState(() async {
                        teams = teamsList;
                      });
                    },
                    child: Row(
                      children: [
                        const Text("Integrantes  "),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 2, top: 2),
                          margin: const EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: AppColors.lila, width: 1.0),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(
                                15.0,
                              ), //
                            ),
                          ),
                          child: const Text("Sin asignar"),
                        ),
                        const Icon(Icons.edit),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    Stack(
                      children: List.generate(
                        teams.length + 1,
                        (index) => Padding(
                          padding: EdgeInsets.only(left: 0 + index * 25),
                          child: index == teams.length
                              ? Container(
                                  height: 37,
                                  width: 37,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "2",
                                      style: TextStyle(
                                        color: AppColors.primaryDarkColor,
                                      ),
                                    ),
                                  ),
                                )
                              : CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    UserData.profile,
                                    scale: 4,
                                  ),
                                  radius: 20,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 25, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Column(
                      children: [
                        Row(
                          children: [
                            Text("Template"),
                            Icon(Icons.keyboard_arrow_down),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 20),
                          child: Text(
                            "Reto 10 dias",
                            style: TextStyle(
                              color: AppColors.raisenBlak,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      onPressed: () => print("object"),
                      child: const Row(
                        children: [
                          Icon(Icons.add),
                          Text("Crear"),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

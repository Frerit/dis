import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:progressprodis/app/activity/_children/add_template/domain/models/templates_generic_model.dart';
import 'package:progressprodis/desing/tokens/_tokens.dart';

class AddTemplatePage extends StatefulWidget {
  const AddTemplatePage({super.key});

  @override
  State<AddTemplatePage> createState() => _AddTemplatePageState();
}

class _AddTemplatePageState extends State<AddTemplatePage> {
  final searchController = TextEditingController();
  List<int> indexSelect = [];
  TemplatesGenericModel? selected;

  List<TemplatesGenericModel> templates = [
    TemplatesGenericModel(
      name: "General 10 dias",
      description: "",
      periodicity: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
    ),
    TemplatesGenericModel(
      name: "General 15 dias",
      description: "",
      periodicity: [1, 2, 4, 7, 10, 13, 15],
    ),
    TemplatesGenericModel(
      name: "General 30 dias",
      description: "",
      periodicity: [1, 2, 5, 10, 15, 20, 25, 30],
    ),
    TemplatesGenericModel(
      name: "Tips de fin de semana",
      description: "",
      periodicity: [5, 6, 7],
    ),
    TemplatesGenericModel(
      name: "Frases motivacioneles",
      description: "",
      periodicity: [2, 4, 6, 8, 10],
    ),
    TemplatesGenericModel(
      name: "Recetas saludables",
      description: "",
      periodicity: [2, 4, 6, 8, 10, 12, 14, 16, 18, 20],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final ramdom = Colors.primaries[Random().nextInt(18)].shade200;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: () => Modular.to.pop(),
          child: const Padding(
            padding: EdgeInsets.only(top: 20, left: 20),
            child: Text("Atras"),
          ),
        ),
        backgroundColor: AppColors.primaryDarkColor,
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
            child: TextField(
              textAlign: TextAlign.left,
              controller: searchController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search_rounded),
                hintText: 'Buscar',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                contentPadding: const EdgeInsets.all(16),
                fillColor: Colors.grey.withOpacity(0.2),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(
                  templates.length,
                  (index) {
                    final temp = templates[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.withOpacity(0.2),
                        border: Border.all(
                          width: 2,
                          style: indexSelect.contains(index)
                              ? BorderStyle.solid
                              : BorderStyle.none,
                          color: indexSelect.contains(index)
                              ? AppColors.lila
                              : AppColors.transparent,
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            indexSelect.add(index);
                            Future.delayed(
                              const Duration(milliseconds: 500),
                              () {
                                final select = templates[index];
                                Modular.to.pop(select);
                              },
                            );
                          });
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: ramdom,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: SvgPicture.asset(
                                  "assets/icons/template.svg",
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.62,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    temp.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Row(
                                    children: List.generate(
                                      temp.periodicity.length,
                                      (index) {
                                        final period = temp.periodicity[index];
                                        return Container(
                                          margin: const EdgeInsets.only(
                                              right: 5, top: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(
                                                16,
                                              ), //                 <--- border radius here
                                            ),
                                            border: Border.all(
                                              color: Colors.blueGrey,
                                            ),
                                          ),
                                          child: SizedBox(
                                            width: 16,
                                            height: 16,
                                            child: Center(
                                              child: Text(
                                                "$period",
                                                style: const TextStyle(
                                                    fontSize: 11),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                            indexSelect.contains(index)
                                ? SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 136, 199, 114),
                                        shape: BoxShape.circle,
                                      ),
                                      child: IconButton(
                                        iconSize: 16,
                                        icon: const Icon(Icons.check),
                                        onPressed: () {},
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:progressprodis/desing/tokens/_tokens.dart';
import 'package:progressprodis/app/home/presenter/page/home_page.dart';
import 'package:progressprodis/app/progress/domain/models/add_model.dart';

import 'widgets/add_group.dart';
import 'widgets/add_progress.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({Key? key}) : super(key: key);

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  int pageView = 0;

  List<String> categories = [
    "Generales",
    "Planes",
    "Retos",
  ];

  void openModal(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return AddProgress(onTap: (AddPressedType type) {
              Modular.to.pop();
              createGroup(context);
            });
          },
        );
      },
    );
  }

  void createGroup(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: AppColors.primaryDarkColor.withOpacity(0.8),
      backgroundColor: Colors.transparent,
      builder: (context) {
        return AddGroup();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    openModal(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryDarkColor,
        title: const Text("Plantillas"),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              color: AppColors.primaryDarkColor,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              iconSize: 30,
              icon: const Icon(Icons.add),
              onPressed: () {
                openModal(context);
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 20),
                child: Row(
                  children: [
                    ...List.generate(
                      categories.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: pageView == index
                                ? AppColors.primaryColor
                                : AppColors.primaryDarkColor,
                            shape: const StadiumBorder(),
                            side: BorderSide(
                              width: 2,
                              color: pageView == index
                                  ? AppColors.primaryColor
                                  : AppColors.primaryDarkColor,
                            ),
                          ),
                          onPressed: () {
                            setState(() => pageView = index);
                          },
                          child: Text(
                            categories[index],
                            style: const TextStyle(color: AppColors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  ...List.generate(
                    3,
                    (index) => Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: const BoxDecoration(
                        color: AppColors.transparent,
                        borderRadius: BorderRadiusDirectional.all(
                          Radius.circular(12),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, top: 5, bottom: 5),
                                child: SvgPicture.asset(
                                  "assets/icons/tags.svg",
                                  width: 40,
                                ),
                              ),
                              const SizedBox(
                                width: 200,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Reto 10 dias 🔥",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      "12 Dec - 30 Dec",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                  onPressed: () => print("object "),
                                  icon: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 15,
                                  ))
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 70, top: 10, bottom: 5),
                            child: LinearPercentIndicator(
                              width: MediaQuery.of(context).size.width * 0.4,
                              lineHeight: 4,
                              percent: (100 * (6 + index + 1) / 12) / 100,
                              trailing: Text(
                                "${2 + index}/12  Completadas",
                                style: const TextStyle(fontSize: 10),
                              ),
                              barRadius: const Radius.circular(12),
                              backgroundColor: Colors.white,
                              progressColor: AppColors.primaryDarkColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavigationAppBar(),
    );
  }
}

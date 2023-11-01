import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:progress_desing/progress_desing.dart';
import 'package:progressprodis/app/home/presenter/page/home_page.dart';
import 'package:progressprodis/global/user/user_data.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  int pageView = 0;
  List<String> categories = [
    "General",
    "Grupos",
    "Retos",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryDarkColor,
        title: const Text("Equipos"),
      ),
      body: SingleChildScrollView(
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
                    width: MediaQuery.of(context).size.width * 0.45,
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
                        const Padding(
                          padding: EdgeInsets.only(
                            top: 2,
                            bottom: 8,
                            left: 10,
                          ),
                          child: Text(
                            "Reto 10 dias",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 9),
                          child: Stack(
                            children: List.generate(
                              3 + 1,
                              (index) => Padding(
                                padding: EdgeInsets.only(left: 0 + index * 25),
                                child: index == 3
                                    ? Container(
                                        height: 37,
                                        width: 37,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.7),
                                          borderRadius:
                                              BorderRadius.circular(25),
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
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 0, top: 30, bottom: 5),
                          child: LinearPercentIndicator(
                            width: 100,
                            lineHeight: 4,
                            percent: (100 * (6 + index + 1) / 12) / 100,
                            trailing: Text(
                              "${2 + index}/12",
                              style: const TextStyle(fontSize: 10),
                            ),
                            barRadius: const Radius.circular(12),
                            backgroundColor: Colors.white,
                            progressColor: AppColors.lila,
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
      bottomNavigationBar: const NavigationAppBar(),
    );
  }
}

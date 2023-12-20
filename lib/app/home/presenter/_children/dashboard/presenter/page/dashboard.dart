import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:progressprodis/app/home/domain/models/distributor_task.dart';
import 'package:progressprodis/app/home/presenter/page/home_page.dart';
import 'package:progressprodis/app/home/presenter/page/widgets/simple_card.dart';
import 'package:progressprodis/app/home/presenter/page/widgets/swipe_card.dart';
import 'package:progressprodis/desing/atoms/buttons/buttons.dart';
import 'package:progressprodis/desing/tokens/_tokens.dart';
import 'package:progressprodis/global/user/user_data.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final SwipeableCardSectionController _cardController =
      SwipeableCardSectionController();

  final List<DistTask> task = [
    DistTask("0", "Retos completados", "estan completos", 10, 2),
    DistTask("1", "Toma de medidas", "completaron este reto", 40, 10),
    DistTask("1", "Rutinas realizadas", "completaron este reto", 5, 3),
  ];

  int pageView = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20,
                        top: 0,
                        right: MediaQuery.of(context).size.width * 0.28),
                    child: const Text(
                      "Dashboard",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10, top: 5),
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: SvgPicture.asset(
                            "assets/navigation/notification_.svg",
                          ),
                        ),
                      ),
                      const Positioned(
                        top: 0,
                        right: 0,
                        child: Badge(
                          padding: EdgeInsets.all(5),
                          backgroundColor: AppColors.lila,
                          alignment: AlignmentDirectional.topStart,
                          largeSize: 22,
                          textStyle: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                          textColor: Colors.yellow,
                          label: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3),
                            child: Text("2"),
                          ),
                          isLabelVisible: true,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(UserData.profile, scale: 4),
                      radius: 40,
                    ),
                  ),
                  const SizedBox(width: 5)
                ],
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "Hola,",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, bottom: 5),
                            child: Text(
                              "${UserData.name} ${UserData.lastName} 👋",
                              style: const TextStyle(fontSize: 27),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Row(
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: pageView == 0
                            ? AppColors.primaryColor
                            : AppColors.primaryDarkColor,
                        shape: const StadiumBorder(),
                        side: BorderSide(
                          width: 2,
                          color: pageView == 0
                              ? AppColors.primaryColor
                              : AppColors.primaryDarkColor,
                        ),
                      ),
                      onPressed: () {
                        setState(() => pageView = 0);
                      },
                      child: const Text(
                        'General',
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                    const SizedBox(width: 10),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: pageView == 1
                            ? AppColors.primaryColor
                            : AppColors.primaryDarkColor,
                        shape: StadiumBorder(),
                        side: BorderSide(
                          width: 2,
                          color: pageView == 1
                              ? AppColors.primaryColor
                              : AppColors.primaryDarkColor,
                        ),
                      ),
                      onPressed: () {
                        setState(() => pageView = 1);
                      },
                      child: const Text(
                        'Productividad',
                        style: TextStyle(color: AppColors.white),
                      ),
                    )
                  ],
                ),
              ),
              pageView == 1
                  ? SizedBox(
                      child: Column(children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: AppColors.transparent,
                            borderRadius: BorderRadiusDirectional.all(
                              Radius.circular(12),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Text(
                                        "Reto del dia",
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: AppColors.quickSilver,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        SmallButton(
                                          onTap: () {},
                                          color: AppColors.success,
                                          active: true,
                                          title: "3 / 5",
                                        ),
                                        const Text(
                                          "  tareas",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                CircularPercentIndicator(
                                  radius: 40.0,
                                  lineWidth: 10.0,
                                  animation: true,
                                  percent: 80 / 100,
                                  center: const Icon(Icons.check),
                                  backgroundColor:
                                      AppColors.silver.withAlpha(20),
                                  circularStrokeCap: CircularStrokeCap.round,
                                  progressColor: AppColors.lila,
                                )
                              ]),
                        )
                      ]),
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height * 0.22,
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          SwipeableCardsSection(
                            cardController: _cardController,
                            context: context,
                            cardHeight:
                                MediaQuery.of(context).size.height * 0.19,
                            onCardSwiped: (dir, index, widget) {
                              if (task.length > index) {
                                _cardController.addItem(
                                  SimpleCard(
                                    task: task[index],
                                    close: () =>
                                        _cardController.triggerSwipeLeft(),
                                  ),
                                );
                              }
                            },
                            enableSwipeUp: true,
                            enableSwipeDown: false,
                            items: List.generate(
                              task.length,
                              (index) {
                                return SimpleCard(
                                  task: task[index],
                                  close: () =>
                                      _cardController.triggerSwipeLeft(),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavigationAppBar(),
    );
  }
}

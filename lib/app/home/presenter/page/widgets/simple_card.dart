import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:progressprodis/app/home/domain/models/distributor_task.dart';
import 'package:progressprodis/desing/tokens/_tokens.dart';

class SimpleCard extends StatelessWidget {
  const SimpleCard({
    Key? key,
    required this.task,
    required this.close,
  }) : super(key: key);

  final DistTask task;

  final Function() close;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.2),
            blurRadius: 9,
            offset: const Offset(0, 3),
          )
        ],
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomCenter,
          stops: [0.1, 0.5, 1.2],
          colors: [
            AppColors.primaryColor,
            AppColors.secondaryColor,
            AppColors.lila,
          ],
        ),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  task.title,
                  style: const TextStyle(
                      color: AppColors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Text(
                  "${task.completed.toInt()}/${task.total.toInt()} ${task.subtitle}",
                  style: const TextStyle(
                      color: AppColors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 15),
                child: LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width * 0.6,
                  lineHeight: 13.0,
                  percent: (100 * task.completed / task.total) / 100,
                  trailing: Text("${100 * task.completed / task.total} %"),
                  barRadius: const Radius.circular(12),
                  backgroundColor: Colors.white,
                  progressColor: AppColors.primaryDarkColor,
                ),
              )
            ],
          ),
          Positioned(
            right: 5,
            top: 5,
            child: InkWell(
              onTap: close,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: AppColors.purple,
                    borderRadius: BorderRadius.circular(15)),
                child: const Icon(
                  Icons.close_rounded,
                  color: AppColors.white,
                  size: 18,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:progressprodis/desing/tokens/_tokens.dart';

class GeneralDetailPage extends StatelessWidget {
  const GeneralDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: AppColors.primaryDarkColor),
      body: Column(
        children: [
          Text("Name"),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20, top: 10, bottom: 8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: () => Modular.to.pop(),
                  child: const Icon(Icons.calendar_month),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Creacion",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: AppColors.silver),
                  ),
                  Text(DateFormat.yMMMd().format(DateTime.now()))
                ],
              ),
              SizedBox(width: 30),
              Padding(
                padding: const EdgeInsets.only(right: 20, top: 10, bottom: 8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: () => Modular.to.pop(),
                  child: const Icon(Icons.calendar_month),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

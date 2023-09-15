import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:progress_desing/progress_desing.dart';
import 'package:progressprodis/module.dart';

class GetStarterPage extends StatelessWidget {
  const GetStarterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDarkColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40, top: 70),
                child: Image.asset("assets/images/starter-image.png"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, bottom: 10),
                child: SizedBox(
                  height: 20,
                  child: AnimatedTextKit(
                      totalRepeatCount: 1,
                      pause: const Duration(milliseconds: 1000),
                      isRepeatingAnimation: false,
                      stopPauseOnTap: true,
                      animatedTexts: [
                        FadeAnimatedText(
                          "Gestiona sus progresos",
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ColorizeAnimatedText("Gestiona sus progresos",
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            colors: [Colors.white, Colors.white]),
                      ]),
                ),
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 40),
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Este sera un",
                          style: TextStyle(
                              color: AppColors.white,
                              fontSize: 38,
                              fontWeight: FontWeight.w600),
                        ),
                        const Text(
                          "espacio",
                          style: TextStyle(
                              color: AppColors.white,
                              fontSize: 38,
                              fontWeight: FontWeight.w600),
                        ),
                        const Text(
                          "para",
                          style: TextStyle(
                              color: AppColors.white,
                              fontSize: 38,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 45,
                          child: DefaultTextStyle(
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 38,
                              fontWeight: FontWeight.w700,
                            ),
                            child: AnimatedTextKit(
                              isRepeatingAnimation: true,
                              repeatForever: true,
                              animatedTexts: [
                                FadeAnimatedText('gestionar'),
                                FadeAnimatedText('motivar'),
                                FadeAnimatedText('valorar'),
                              ],
                            ),
                          ),
                        ),
                        const Text(
                          "a tus clientes",
                          style: TextStyle(
                              color: AppColors.white,
                              fontSize: 38,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      SvgPicture.asset(
                        "assets/images/polygon.svg",
                        alignment: Alignment.center,
                        height: 170,
                      ),
                      Positioned(
                        right: 10,
                        top: 0,
                        bottom: 0,
                        child: IconButton(
                          onPressed: () {
                            Modular.to.pushReplacementNamed(
                              AppModule.onboardingRoute,
                            );
                          },
                          icon: const Icon(
                            Icons.arrow_forward_rounded,
                            size: 40,
                            color: AppColors.black,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, top: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Modular.to.pushReplacementNamed(
                      AppModule.onboardingRoute,
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
                  child: const Text(
                    "Empecemos",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

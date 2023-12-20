import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:progressprodis/desing/tokens/_tokens.dart';
import 'package:progressprodis/module.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: const SliderCarrousel(),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                  onPressed: () {
                    Modular.to.pushNamed(
                      AppModule.signInRoute,
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
                        "Ingresar con tu email",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonLoginIcons(
                      logo: "assets/icons/apple.svg",
                      brand: "Apple",
                      onTap: () {},
                    ),
                    const SizedBox(width: 10),
                    ButtonLoginIcons(
                      logo: "assets/icons/google.svg",
                      brand: "Google",
                      onTap: () {},
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}

class ButtonLoginIcons extends StatelessWidget {
  const ButtonLoginIcons({
    super.key,
    required this.logo,
    required this.brand,
    this.onTap,
  });

  final String logo;
  final String brand;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: ElevatedButton(
        onPressed: () {
          Modular.to.pushNamed(
            AppModule.signInRoute,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              logo,
              height: 16,
            ),
            const SizedBox(width: 5),
            Text(
              brand,
              style: const TextStyle(color: AppColors.raisenBlak, fontSize: 15),
            )
          ],
        ),
      ),
    );
  }
}

class SliderCarrousel extends StatefulWidget {
  const SliderCarrousel({super.key});

  @override
  State<SliderCarrousel> createState() => _SliderCarrouselState();
}

class _SliderCarrouselState extends State<SliderCarrousel> {
  int _current = 0;

  List<OnboardingModel> onboardingItems = [
    OnboardingModel(
      index: 0,
      title: "Trabaja Desde Cualquier Lugar",
      asset: "assets/images/step-on.png",
    ),
    OnboardingModel(
      index: 1,
      title: "Gestiona Todo Desde tu Celular",
      asset: "assets/images/step-on.png",
    ),
    OnboardingModel(
      index: 2,
      title: "Lleva a Tus Clientes a Sus Objetivos",
      asset: "assets/images/step-on.png",
    )
  ];

  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CarouselSlider(
            carouselController: _controller,
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 20),
              autoPlayAnimationDuration: const Duration(milliseconds: 350),
              autoPlayCurve: Curves.fastOutSlowIn,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              height: MediaQuery.of(context).size.height * 0.5,
              onPageChanged: (index, reason) {
                setState(() => _current = index);
              },
            ),
            items: onboardingItems
                .map((item) => Center(
                      child: Image.asset(item.asset,
                          fit: BoxFit.cover, width: 1000.0),
                    ))
                .toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40, bottom: 20),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text(
                  onboardingItems[_current].title,
                  style: const TextStyle(
                      fontSize: 35, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: onboardingItems.asMap().entries.map(
              (entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == entry.key
                          ? AppColors.primaryColor.withOpacity(0.6)
                          : AppColors.dividerColor.withOpacity(0.13),
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }
}

class OnboardingModel {
  int index;
  String title;
  String asset;

  OnboardingModel({
    required this.index,
    required this.title,
    required this.asset,
  });
}

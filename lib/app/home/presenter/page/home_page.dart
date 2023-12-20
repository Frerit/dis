import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:progressprodis/desing/tokens/_tokens.dart';
import 'package:progressprodis/app/activity/presenter/page/activity_page.dart';
import 'package:progressprodis/app/calendar/presenter/page/calendar_page.dart';
import 'package:progressprodis/app/home/presenter/_children/dashboard/presenter/page/dashboard.dart';
import 'package:progressprodis/app/home/presenter/bloc/home_bloc.dart';
import 'package:progressprodis/app/profile/presenter/page/profile_page.dart';
import 'package:progressprodis/app/progress/presenter/page/progress_page.dart';
import 'package:progressprodis/global/ui_values.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationCubit>(
          create: (context) => NavigationCubit(),
        ),
      ],
      child: const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        switch (state.navbarItem) {
          case NavbarItem.home:
            return DashboardView();
          case NavbarItem.calendar:
            return CalendarPage();
          case NavbarItem.progress:
            return ProgressPage();
          case NavbarItem.activity:
            return ActivityPage();
          case NavbarItem.profile:
            return ProfilePage();
        }
      },
    );
  }
}

class NavigationAppBar extends StatelessWidget {
  const NavigationAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return BottomNavigationBar(
          currentIndex: state.index,
          enableFeedback: true,
          showSelectedLabels: false,
          backgroundColor: AppColors.primaryDarkColor,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          iconSize: 35,
          elevation: 0,
          onTap: (int index) {
            switch (index) {
              case 0:
                BlocProvider.of<NavigationCubit>(context).getNavBarItem(
                  NavbarItem.home,
                );
                break;
              case 1:
                BlocProvider.of<NavigationCubit>(context).getNavBarItem(
                  NavbarItem.calendar,
                );
                break;
              case 2:
                BlocProvider.of<NavigationCubit>(context).getNavBarItem(
                  NavbarItem.progress,
                );
                break;
              case 3:
                BlocProvider.of<NavigationCubit>(context).getNavBarItem(
                  NavbarItem.activity,
                );
                break;
              case 4:
                BlocProvider.of<NavigationCubit>(context).getNavBarItem(
                  NavbarItem.profile,
                );
                break;
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                UiValues.home,
                width: 30,
              ),
              activeIcon: SvgPicture.asset(
                UiValues.home_,
                width: 30,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                UiValues.calendar,
                width: 30,
              ),
              activeIcon: SvgPicture.asset(
                UiValues.calendar_,
                width: 30,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  Icons.add,
                  color: AppColors.primaryDarkColor.withOpacity(0.6),
                ),
              ),
              activeIcon: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.success,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.add,
                  color: AppColors.white,
                ),
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                UiValues.activity,
                width: 30,
              ),
              activeIcon: SvgPicture.asset(
                UiValues.activity_,
                width: 30,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                UiValues.profile,
                width: 30,
              ),
              activeIcon: SvgPicture.asset(
                UiValues.profile_,
                width: 30,
              ),
              label: "",
            ),
          ],
        );
      },
    );
  }
}

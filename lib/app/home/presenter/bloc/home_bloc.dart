import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_events.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const InitialState());
}

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(NavbarItem.home, 0));

  void getNavBarItem(NavbarItem navbarItem) {
    switch (navbarItem) {
      case NavbarItem.home:
        emit(const NavigationState(NavbarItem.home, 0));
        break;
      case NavbarItem.calendar:
        emit(const NavigationState(NavbarItem.calendar, 1));
        break;
      case NavbarItem.progress:
        emit(const NavigationState(NavbarItem.progress, 2));
        break;
      case NavbarItem.activity:
        emit(const NavigationState(NavbarItem.activity, 3));
        break;
      case NavbarItem.profile:
        emit(const NavigationState(NavbarItem.profile, 4));
        break;
    }
  }
}

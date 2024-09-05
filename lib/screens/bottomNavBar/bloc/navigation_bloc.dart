import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_care/screens/bottomNavBar/bloc/navigation_event.dart';
import 'package:mind_care/screens/bottomNavBar/bloc/navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationChange(index: 0)) {
    on<NavigateTo>((event, emit) {
      emit(NavigationChange(index: event.index));
    });
  }
}

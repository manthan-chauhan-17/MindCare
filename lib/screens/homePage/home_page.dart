import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_care/features/meditation/presentation/pages/meditation_screen.dart';
import 'package:mind_care/features/music/presentation/pages/playlist.dart';
import 'package:mind_care/screens/bottomNavBar/bloc/navigation_bloc.dart';
import 'package:mind_care/screens/bottomNavBar/bloc/navigation_state.dart';
import 'package:mind_care/screens/bottomNavBar/widgets/bottom_nav_bar.dart';
import 'package:mind_care/theme.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key, required this.name}) {
    pages = [
      MeditationScreen(name: name),
      Playlist(),
    ];
  }
  final String name;

  late List<Widget> pages = [];

  BottomNavigationBarItem createBottomNavItem(
      {required String assetName,
      required bool isActive,
      required BuildContext context}) {
    return BottomNavigationBarItem(
        icon: Image.asset(
          assetName,
          height: 45,
          color: isActive
              ? AppTheme.lightTheme.focusColor
              : AppTheme.lightTheme.primaryColor,
        ),
        label: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          debugPrint("state name : $state");
          if (state is NavigationChange) {
            return pages[state.index];
          }
          return pages[0];
        },
      ),
      bottomNavigationBar: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
        int currentIndex = 0;
        if (state is NavigationChange) {
          currentIndex = state.index;
        }
        final List<BottomNavigationBarItem> bottomNavItems = [
          createBottomNavItem(
              assetName: "assets/images/menu_home.png",
              isActive: currentIndex == 0,
              context: context),
          createBottomNavItem(
              assetName: "assets/images/menu_songs.png",
              isActive: currentIndex == 1,
              context: context),
        ];
        return BottomNavBar(
          items: bottomNavItems,
          currentIndex: currentIndex,
        );
      }),
    );
  }
}

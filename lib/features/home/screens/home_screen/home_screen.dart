import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kptube_mobile/features/home/widgets/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:kptube_mobile/features/main/screens/main_screen/main_screen.dart';
import 'package:kptube_mobile/features/profile/bloc/profile_bloc.dart';
import 'package:kptube_mobile/features/profile/screens/profile_screen/profile_screen.dart';
import 'package:kptube_mobile/features/registration/screens/registration_screen/registration_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PageController pageController;
  int selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
    context.read<ProfileBloc>().add(GetProfileEvent());
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _onPageSelected(int index) {
    setState(() => selectedPageIndex = index);
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.linearToEaseOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          body: PageView(
            controller: pageController,
            onPageChanged: (index) {
              setState(() => selectedPageIndex = index);
            },
            children: [
              Material(
                type: MaterialType.transparency,
                child: Theme(data: theme, child: MainScreen()),
              ),
              const Scaffold(body: Center(child: Text('3'))),
              if (state is ProfileGetSuccess || state is ProfileLoading)
                Material(
                  type: MaterialType.transparency,
                  child: Theme(data: theme, child: const ProfileScreen()),
                )
              else if (state is ProfileFailed)
                Material(
                  type: MaterialType.transparency,
                  child: Theme(data: theme, child: const RegistrationScreen()),
                )
              else
                Material(
                  type: MaterialType.transparency,
                  child: Theme(data: theme, child: const RegistrationScreen()),
                ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBarWidget(
            selectedPageIndex: selectedPageIndex,
            onPageSelected: _onPageSelected,
          ),
        );
      },
    );
  }
}

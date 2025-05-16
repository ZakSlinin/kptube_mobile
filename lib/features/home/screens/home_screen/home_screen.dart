import 'package:auto_route/auto_route.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kptube_mobile/core/di/injection.dart';
import 'package:kptube_mobile/features/home/widgets/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:kptube_mobile/features/main/bloc/main_bloc.dart';
import 'package:kptube_mobile/features/main/screens/main_screen/main_screen.dart';
import 'package:kptube_mobile/features/profile/bloc/profile_bloc.dart';
import 'package:kptube_mobile/features/profile/screens/profile_screen/profile_screen.dart';
import 'package:kptube_mobile/features/registration/screens/registration_screen/registration_screen.dart';
import 'package:kptube_mobile/core/routing/app_router.dart';

@RoutePage()
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
    Future.microtask(() {
      if (mounted) {
        context.read<ProfileBloc>().add(GetProfileEvent());
      }
    });
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

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const MainScreen();
      case 1:
        return const Center(child: Text('3'));
      case 2:
        return BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            print('Current ProfileState: $state');
            if (state is ProfileGetSuccess || state is ProfileLoading) {
              return const ProfileScreen();
            } else if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileFailed) {
              return const RegistrationScreen();
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MainBloc(mainRepository: getIt())),
      ],
      child: Scaffold(
        body: PageView.builder(
          controller: pageController,
          onPageChanged: (index) {
            setState(() => selectedPageIndex = index);
          },
          itemBuilder: (context, index) => _buildPage(index),
          itemCount: 3,
        ),
        bottomNavigationBar: BottomNavigationBarWidget(
          selectedPageIndex: selectedPageIndex,
          onPageSelected: _onPageSelected,
        ),
      ),
    );
  }
}

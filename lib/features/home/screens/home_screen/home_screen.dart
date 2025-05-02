import 'package:flutter/material.dart';
import 'package:kptube_mobile/features/home/widgets/bottom_navigation_bar/bottom_navigation_bar.dart';
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
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          setState(() => selectedPageIndex = index);
        },
        children: const [
          Scaffold(body: Center(child: Text('1'))),
          Scaffold(body: Center(child: Text('2'))),
          Scaffold(body: Center(child: Text('3'))),
          Scaffold(body: Center(child: Text('4'))),
          RegistrationScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        selectedPageIndex: selectedPageIndex,
        onPageSelected: _onPageSelected,
      ),
    );
  }
}

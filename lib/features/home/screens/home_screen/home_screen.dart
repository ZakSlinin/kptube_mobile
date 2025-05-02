import 'package:flutter/material.dart';
import 'package:kptube_mobile/features/home/widgets/bottom_navigation_bar/bottom_navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          Scaffold(),
          Scaffold(),
          Scaffold(),
          Scaffold(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}

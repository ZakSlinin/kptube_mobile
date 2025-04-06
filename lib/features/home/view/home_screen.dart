import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kptube_mobile/features/add_content/presentation/pages/add_content/add_content.dart';
import 'package:kptube_mobile/features/library/library.dart';
import 'package:kptube_mobile/features/music/music.dart';
import 'package:kptube_mobile/features/profile/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _selectedPageIndex = 0;

  void _openPage(int index) {
    setState(() => _selectedPageIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.linearToEaseOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          setState(() => _selectedPageIndex = value);
        },
        children: const [
          Scaffold(
            body: Center(
              child: Text('home', style: TextStyle(color: Colors.white)),
            ),
          ),
          MusicScreen(),
          AddContentScreen(),
          LibraryScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _openPage,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/svg/Home.svg', color: Colors.white),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/svg/Music.svg', color: Colors.white),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/svg/Add_content.svg'),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/Library.svg',
              color: Colors.white,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/svg/User.svg', color: Colors.white),
            label: '',
          ),
        ],
      ),
    );
  }
}

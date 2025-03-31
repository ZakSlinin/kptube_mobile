import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(),
      bottomNavigationBar: BottomNavigationBar(
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
            icon: SvgPicture.asset('assets/svg/Library.svg', color: Colors.white),
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

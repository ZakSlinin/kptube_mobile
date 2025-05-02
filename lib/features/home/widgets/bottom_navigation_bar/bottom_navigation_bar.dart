import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/svg/Home.svg',
            color: Colors.white,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/svg/Music.svg',
            color: Colors.white,
          ),
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
          icon: SvgPicture.asset(
            'assets/svg/User.svg',
            color: Colors.white,
          ),
          label: '',
        ),
      ],
    );
  }
}

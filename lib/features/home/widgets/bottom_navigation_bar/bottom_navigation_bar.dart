import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final int selectedPageIndex;
  final Function(int) onPageSelected;

  const BottomNavigationBarWidget({
    super.key,
    required this.selectedPageIndex,
    required this.onPageSelected,
  });

  @override
  State<BottomNavigationBarWidget> createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.selectedPageIndex,
      onTap: widget.onPageSelected,
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
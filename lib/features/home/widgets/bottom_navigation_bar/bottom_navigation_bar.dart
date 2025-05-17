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
    return SizedBox(
      height: 105,
      child: BottomNavigationBar(
        currentIndex: widget.selectedPageIndex,
        onTap: widget.onPageSelected,
        type: BottomNavigationBarType.fixed,
        iconSize: 0,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(6),
              alignment: Alignment.center,
              width: 60,
              height: 60,
              child: SvgPicture.asset(
                'assets/svg/Home.svg',
                fit: BoxFit.contain,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(6),
              alignment: Alignment.center,
              width: 60,
              height: 60,
              child: SvgPicture.asset(
                'assets/svg/Add_content.svg',
                fit: BoxFit.contain,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(6),
              alignment: Alignment.center,
              width: 60,
              height: 60,
              child: SvgPicture.asset(
                'assets/svg/User.svg',
                fit: BoxFit.contain,
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
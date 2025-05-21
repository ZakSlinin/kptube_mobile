import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kptube_mobile/features/main/bloc/main_bloc.dart';
import 'package:kptube_mobile/features/profile/bloc/profile_bloc.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final int selectedPageIndex;
  final Function(int) onPageSelected;

  const BottomNavigationBarWidget({
    super.key,
    required this.selectedPageIndex,
    required this.onPageSelected,
  });

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  void _handleNavigation(int index) {
    if (index == 0) {
      context.read<MainBloc>().add(NavigateToHomeEvent());
    } else if (index == 2) {
      context.read<ProfileBloc>().add(ProfileNavigateBackEvent());
    }
    widget.onPageSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 105,
      child: BottomNavigationBar(
        currentIndex: widget.selectedPageIndex,
        onTap: _handleNavigation,
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

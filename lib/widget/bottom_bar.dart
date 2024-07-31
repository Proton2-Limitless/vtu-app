import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    required this.selectScreen,
    required this.screenIndex,
  });

  final void Function(int val) selectScreen;
  final int screenIndex;

  @override
  Widget build(BuildContext context) {
    double iconSize = 30;
    double homeButtonSize = 60;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          margin: const EdgeInsets.all(20),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(40)),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                offset: const Offset(0, -10),
                blurRadius: 40,
              ),
            ],
          ),
          child: BottomNavigationBar(
            iconSize: iconSize,
            type: BottomNavigationBarType.fixed,
            onTap: selectScreen,
            currentIndex: screenIndex,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Theme.of(context).colorScheme.secondary,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_repair_service_rounded),
                label: 'Services',
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.history),
              //   label: 'History',
              // ),
              BottomNavigationBarItem(
                icon: SizedBox.shrink(), // Placeholder for Home
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.person_2),
              //   label: 'Profile',
              // ),
            ],
          ),
        ),
        Positioned(
          bottom: 7, // Adjust this value based on your design
          child: GestureDetector(
            onTap: () {
              selectScreen(1);
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: Container(
                width: homeButtonSize * 1.4,
                height: homeButtonSize * 1.4,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.home_filled,
                  size: homeButtonSize * 0.5,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

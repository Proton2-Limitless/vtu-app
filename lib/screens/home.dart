import 'package:flutter/material.dart';
import 'package:vtu_client/utils/constant_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double iconSize = 35;
  int _initialIndex = 1;
  String title = "Home";

  _selectScreen(int value) {
    setState(() {
      _initialIndex = value;
      if (_initialIndex == 0) {
        title = "Services";
      }
      if (_initialIndex == 1) {
        title = "Home";
      }
      if (_initialIndex == 2) {
        title = "Settings";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int notificationCount = 0;

    return Scaffold(
      backgroundColor: scafoldColor(context),
      appBar: AppBar(
        title: Text(
          title,
          style: fadeTextStyle(fsize: 20, context).copyWith(
            color: secondaryColor(context),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: secondaryColor(context),
                  size: 30,
                ),
                onPressed: () {},
              ),
              Positioned(
                right: 12,
                top: 8,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: customColor(context).withRed(255),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: Text(
                    '$notificationCount',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ],
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.all(5),
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        clipBehavior: Clip.hardEdge,
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Icon(
            Icons.home_filled,
            size: iconSize * 1.3,
            color: secondaryColor(context),
          ),
          onPressed: () {
            _selectScreen(1);
          },
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: BottomAppBar(
          color: Theme.of(context).colorScheme.primary,
          padding: EdgeInsets.all(0),
          height: 60,
          shape: CircularNotchedRectangle(),
          notchMargin: 4.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.home_repair_service_rounded,
                        size: iconSize,
                        color: _initialIndex == 0
                            ? Colors.black87
                            : secondaryColor(context),
                      ),
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        _selectScreen(0);
                      },
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    Icons.settings,
                    size: iconSize,
                  ),
                  highlightColor: Colors.transparent,
                  color: _initialIndex == 2
                      ? Colors.black87
                      : secondaryColor(context),
                  onPressed: () {
                    _selectScreen(2);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: bottomBarScreen[_initialIndex],
    );
  }
}

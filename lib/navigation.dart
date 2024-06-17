import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/other.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  static const _screens = [
    HomeScreen(),
    OtherScreen()
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildConteThemeDatat) {
    //final ThemeData theme = theme.of(context);

    return Scaffold(
      body: _screens[_selectedIndex],

      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index){
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Timetable',
          ),
          NavigationDestination(
            icon: Icon(Icons.more_horiz),
            label: 'Other',
          ),
        ],
      )
    );
  }

}
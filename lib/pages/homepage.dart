import 'package:flutter/material.dart';

import 'package:water_reminder/pages/settings.dart';

import 'home.dart';

class Homepage extends StatefulWidget {
  const Homepage(
      {Key? key, this.bedtime, this.waketime, required this.gender, this.enAdd})
      : super(key: key);
  final DateTime? bedtime;
  final DateTime? waketime;
  final String gender;
  final bool? enAdd;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final editingController = TextEditingController();

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      const Home(),
      SettingsPage(
          title: 'title',
          waketime: widget.waketime,
          bedtime: widget.bedtime,
          gender: widget.gender),
    ];
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 247, 249),
      body: widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_sharp, size: 28),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, size: 28),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}

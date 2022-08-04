import 'package:flutter/material.dart';
import 'package:water_reminder/pages/settings.dart';

import 'dashboard.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final editingController = TextEditingController();
  int _selectedIndex = 0;
  static List<Widget> widgetOptions = <Widget>[
    const Dashboard(
      title: 'title',
    ),
    const SettingsPage(title: 'title'),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 247, 249),
      appBar: AppBar(
        title: const Text(
          "Water Reminder",
          textScaleFactor: 1,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fact_check_outlined),
            label: 'Dashboard',
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

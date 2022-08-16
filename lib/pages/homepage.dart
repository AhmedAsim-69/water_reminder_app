import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:water_reminder/pages/settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'home.dart';
import 'notification/local_notification_service.dart';

class Homepage extends StatefulWidget {
  const Homepage(
      {Key? key,
      required this.bedtime,
      required this.waketime,
      required this.gender})
      : super(key: key);
  final DateTime? bedtime;
  final DateTime? waketime;
  final String gender;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late var wakeTime2 = widget.waketime;
  late var bedTime2 = widget.bedtime;
  late var gender1 = widget.gender;
  final editingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    LocalNotificationService.initialize(context);

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final routeFromMessage = message.data["route"];

        Navigator.of(context).pushNamed(routeFromMessage);
      }
    });

    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        log('${message.notification!.body}');
        log('${message.notification!.title}');
      }

      LocalNotificationService.display(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFromMessage = message.data["route"];
      log('Notification received');
      Navigator.of(context).pushNamed(routeFromMessage);
    });
  }

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      const Home(
        title: 'title',
      ),
      SettingsPage(
          title: 'title',
          waketime: wakeTime2,
          bedtime: bedTime2,
          gender: gender1),
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

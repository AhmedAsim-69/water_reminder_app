import 'package:flutter/material.dart';
// import 'package:water_reminder/pages/sleep_cycle_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Dashboard> createState() => _DashboardState();
}

enum SingingCharacter { male, female }

class _DashboardState extends State<Dashboard> {
  // SingingCharacter? _character = SingingCharacter.male;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 79, 168, 197),
        title: const Text(
          "Water Reminder",
          textScaleFactor: 1,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 241, 247, 249),
      body: const Center(
        child: Text(
          "Nothing to show yet",
          style: TextStyle(
            color: Colors.black,
            fontSize: 34,
          ),
        ),
      ),
    );
  }
}

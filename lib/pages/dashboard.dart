import 'package:flutter/material.dart';
import 'package:water_reminder/pages/sleep_cycle_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Dashboard> createState() => _DashboardState();
}

enum SingingCharacter { male, female }

class _DashboardState extends State<Dashboard> {
  SingingCharacter? _character = SingingCharacter.male;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 247, 249),
      body: Center(
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

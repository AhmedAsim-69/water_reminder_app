import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:water_reminder/pages/sleep_cycle_page.dart';
// Import the generated file
// import 'firebase_options.dart';
// import 'package:water_reminder/pages/gender_page.dart';
// import 'package:water_reminder/pages/settings.dart';
// import 'package:water_reminder/pages/sleep_cycle_page.dart';
import 'package:water_reminder/pages/weight_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // fontFamily: 'GoogleFonts.openSans().fontFamily',
        textTheme: GoogleFonts.openSansTextTheme(
          Theme.of(context).textTheme,
        ),
        primaryColor: const Color.fromARGB(255, 79, 168, 197),
      ),
      home: const WeightPage(title: 'title'),
    );
  }
}

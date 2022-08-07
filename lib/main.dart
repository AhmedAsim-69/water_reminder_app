import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:water_reminder/pages/sleep_cycle_page.dart';
// Import the generated file
// import 'firebase_options.dart';
// import 'package:water_reminder/pages/gender_page.dart';
// import 'package:water_reminder/pages/settings.dart';
// import 'package:water_reminder/pages/sleep_cycle_page.dart';
import 'package:water_reminder/pages/weight_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went Wrong!");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
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
      },
    );
  }
}

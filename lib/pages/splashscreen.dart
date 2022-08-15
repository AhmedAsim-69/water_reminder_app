import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:water_reminder/pages/homepage.dart';
import 'package:water_reminder/pages/weight_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

bool? flag;

class _SplashScreenState extends State<SplashScreen> {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('Default-User');

  String gender = '';
  DateTime bedTime = DateTime.now();
  Timestamp stamp1 = Timestamp.now();
  Timestamp stamp2 = Timestamp.now();
  DateTime wakeTime = DateTime.now();

  @override
  void initState() {
    getData(gender);
    checkstate();
    super.initState();

    Future.delayed(const Duration(seconds: 3), (() {
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => (flag == true)
              ? Homepage(
                  bedtime: bedTime,
                  gender: gender,
                  waketime: wakeTime,
                )
              : const WeightPage(
                  title: 'title',
                ),
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 247, 249),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text(
            "Water Reminder App",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      )),
    );
  }

  checkstate() async {
    await FirebaseFirestore.instance
        .collection('Default-User')
        .doc('user1')
        .get()
        .then(
      (DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          flag = true;
        } else {
          flag = false;
        }
      },
    );
  }

  void getData(String gender) {
    collectionReference.doc('user1').get().then((value) {
      setState(() {
        gender = (value)['gender'];

        stamp1 = (value)['bedTime'];

        bedTime = stamp1.toDate();

        stamp2 = (value)['bedTime'];

        wakeTime = stamp2.toDate();
      });
    });
  }
}

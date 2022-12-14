import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:water_reminder/pages/home.dart';

import 'package:water_reminder/pages/reminder_page.dart';
import 'package:water_reminder/pages/sleep_cycle_page.dart';
import 'package:water_reminder/pages/splashscreen.dart';
import 'package:water_reminder/pages/weight_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage(
      {Key? key,
      required this.title,
      required this.bedtime,
      required this.waketime,
      required this.gender})
      : super(key: key);
  final DateTime? bedtime;
  final DateTime? waketime;
  final String title;
  final String gender;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

enum SingingCharacter { male, female }

class _SettingsPageState extends State<SettingsPage> {
  bool flagGender = false;
  bool flagBedTime = false;
  bool flagWakeTime = false;
  String tempGender = '';
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('Default-User');
  final format = DateFormat("hh:mm a");
  final _formKey = GlobalKey<FormState>();
  SingingCharacter? character = SingingCharacter.male;
  late var wakeTime1 = widget.waketime;
  late var bedTime1 = widget.bedtime;
  @override
  void initState() {
    super.initState();
    getData(null, tempGender, null, null, null, null, callback);
  }

  callback(varGender) {
    setState(() {
      character = (varGender == 'SingingCharacter.male')
          ? SingingCharacter.male
          : SingingCharacter.female;
    });
  }

  callback1(varTopic) {
    setState(() {
      wakeTime1 = varTopic;
      flagWakeTime = true;
    });
  }

  callback2(varTopic) {
    setState(() {
      bedTime1 = varTopic;
      flagBedTime = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 241, 247, 249),
        title: const Text(
          "Settings",
          textScaleFactor: 1,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 241, 247, 249),
      body: StreamBuilder<List<User>>(
        stream: readUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('${snapshot.data} 12345678');
          }
          if (snapshot.hasData) {
            final users = snapshot.data!;
            return ListView(children: users.map(buildUser).toList());
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget buildUser(User user) {
    DateTime? tempWakeTime = user.wakeTime;
    DateTime? tempBedTime = user.bedTime;
    final weightctrl = TextEditingController(text: '${user.weight}');
    final waterctrl = TextEditingController(text: '${user.waterIntake}');

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        left: 25,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(
                          bottom: 5,
                        ),
                        child: Text(
                          'Weight',
                          style: TextStyle(
                            color: Color.fromARGB(255, 79, 168, 197),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: weightctrl,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 79, 168, 197),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 79, 168, 197),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: Colors.green),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              errorStyle: const TextStyle(
                                  color: Colors.redAccent, fontSize: 14),
                              suffixIcon: const Padding(
                                padding: EdgeInsets.only(left: 10, top: 13),
                                child: Text(
                                  'Kg',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your weight';
                              } else if (int.parse(value) < 20 ||
                                  int.parse(value) > 350) {
                                return 'Please enter weight between 20-350 Kgs';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('Male'),
                      leading: Radio<SingingCharacter>(
                        value: SingingCharacter.male,
                        groupValue: character,
                        onChanged: (SingingCharacter? value) {
                          setState(() {
                            character = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Female'),
                      leading: Radio<SingingCharacter>(
                        value: SingingCharacter.female,
                        groupValue: character,
                        onChanged: (SingingCharacter? value) {
                          setState(() {
                            character = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    const BuildPadding(
                      text: 'Wakeup Time',
                      textcolor: Color.fromARGB(255, 79, 168, 197),
                    ),
                    BuildTime(
                        format: format,
                        context: context,
                        time: 'Wakeup',
                        tempTime: tempWakeTime,
                        callbackFunction: callback1,
                        flag: flagWakeTime),
                    const BuildPadding(
                      text: 'Bed Time',
                      textcolor: Color.fromARGB(255, 79, 168, 197),
                    ),
                    BuildTime(
                      format: format,
                      context: context,
                      time: 'Bed',
                      tempTime: tempBedTime,
                      callbackFunction: callback2,
                      flag: flagBedTime,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        left: 25,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(
                          bottom: 5,
                        ),
                        child: Text(
                          'Water In-Take',
                          style: TextStyle(
                            color: Color.fromARGB(255, 79, 168, 197),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: waterctrl,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 79, 168, 197),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 79, 168, 197),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: Colors.green),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              errorStyle: const TextStyle(
                                  color: Colors.redAccent, fontSize: 14),
                              suffixIcon: const Padding(
                                padding: EdgeInsets.only(left: 10, top: 13),
                                child: Text(
                                  'ml',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your daily water in-take in 'ml'";
                              } else if (int.parse(value) < 1000) {
                                return 'Please enter water intake above 1000ml';
                              }
                              return null;
                            },
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ReminderPage()));
                          },
                          child: const Text(
                            'Reminder Schedule',
                            style: TextStyle(
                              color: Color.fromARGB(255, 79, 168, 197),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 79, 168, 197),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  minimumSize: const Size(325, 45),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    int diff = (bedTime1!.hour - wakeTime1!.hour).abs();
                    log('$diff');

                    if (diff >= 4 || diff == 0) {
                      setState(
                        () {
                          final docUser = FirebaseFirestore.instance
                              .collection('Default-User')
                              .doc('user1');
                          if (flagBedTime) {
                            docUser.update({'bedTime': bedTime1});
                            flagBedTime = false;
                          }
                          if (flagWakeTime) {
                            docUser.update({'wakeTime': wakeTime1});
                            flagWakeTime = false;
                          }
                          docUser.update({
                            'weight': int.parse(weightctrl.text),
                            'gender': '$character',
                            'waterIntake': int.parse(waterctrl.text)
                          });
                          snackbar("Changes Saved", context);
                        },
                      );
                    } else {
                      snackbar(
                          "WakeTime and BedTime must be atleast 4 hour apart",
                          context,
                          Colors.red);
                    }
                  }
                },
                child: const Text(
                  "SAVE",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Stream<List<User>> readUsers() => FirebaseFirestore.instance
      .collection('Default-User')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
}

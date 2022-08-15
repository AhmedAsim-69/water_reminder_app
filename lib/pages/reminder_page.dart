import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

List<TimeOfDay> reminder = [];
List<bool> switchValue = [];

class _ReminderPageState extends State<ReminderPage> {
  final format = DateFormat("hh:mm a");
  TimeOfDay setTime = TimeOfDay.now();
  int intake = 0;

  @override
  void initState() {
    reminder = [];
    switchValue = [];
    getdata();
    getintake();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 241, 247, 249),
        title: const Text(
          "Reminder Schedule",
          textScaleFactor: 1,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 241, 247, 249),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: reminder.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          tileColor: Colors.white,
                          title: Text(
                            reminder[index].format(context),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textScaleFactor: 1.3,
                          ),
                          subtitle: const Text('Everyday'),
                          trailing: SizedBox(
                            width: 110,
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 50.0,
                                  width: 50,
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: CupertinoSwitch(
                                      activeColor: const Color.fromARGB(
                                          255, 79, 168, 197),
                                      value: switchValue[index],
                                      onChanged: (value) {
                                        setState(() {
                                          switchValue[index] = value;
                                        });
                                        FirebaseFirestore.instance
                                            .collection('Default-User-Water')
                                            .doc('bool')
                                            .set({"switchValue": switchValue});
                                      },
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      _deleteTime(index);
                                      setState(() {});
                                    },
                                    icon: const Icon(Icons.close)),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              heroTag: 'Add',
              backgroundColor: const Color.fromARGB(255, 79, 168, 197),
              onPressed: () {
                _selectTime(context);
              },
              child: const Icon(Icons.add),
            ),
            FloatingActionButton(
              heroTag: 'Schedule',
              backgroundColor: const Color.fromARGB(255, 79, 168, 197),
              onPressed: () {
                dynamicGeneration();
              },
              child: const Icon(Icons.schedule),
            ),
          ],
        ),
      ),
    );
  }

  _addItemToList(TimeOfDay setTime) {
    List<TimeOfDay> tempList = reminder;
    tempList.add(setTime);
    setState(() {
      reminder = tempList;
    });
  }

  Future<void> _selectTime(BuildContext context, [TimeOfDay? time]) async {
    TimeOfDay? picked = (time == null)
        ? await showTimePicker(
            context: context,
            initialTime: setTime,
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(alwaysUse24HourFormat: false),
                child: child!,
              );
            },
          )
        : time;

    if (picked != null && picked != setTime) {
      setState(() {
        setTime = picked;
        _addItemToList(setTime);

        switchValue.add(true);
        List<String> tempReminder = [];

        for (var item in reminder) {
          tempReminder.add(item.format(context));
        }

        FirebaseFirestore.instance
            .collection('Default-User-Water')
            .doc('reminders')
            .set({"reminders": tempReminder});

        FirebaseFirestore.instance
            .collection('Default-User-Water')
            .doc('bool')
            .set({"switchValue": switchValue});
      });
    }
  }

  Future<void> _deleteTime(int index) async {
    reminder.removeAt(index);
    switchValue.removeAt(index);
    List<String> tempReminder = [];

    for (var item in reminder) {
      tempReminder.add(item.format(context));
    }
    FirebaseFirestore.instance
        .collection('Default-User-Water')
        .doc('reminders')
        .set({"reminders": tempReminder});
    FirebaseFirestore.instance
        .collection('Default-User-Water')
        .doc('bool')
        .set({"switchValue": switchValue});
  }

  getdata() async {
    final format = DateFormat.jm();
    var docUser = FirebaseFirestore.instance.collection("Default-User-Water");

    docUser.doc('reminders').get().then((value) {
      setState(() {
        for (var element in List.from(value['reminders'])) {
          TimeOfDay data = TimeOfDay.fromDateTime(format.parse(element));
          reminder.add(data);
        }
      });
    });
    docUser.doc('bool').get().then((value) {
      setState(() {
        for (var element in List.from(value['switchValue'])) {
          bool data1 = element;

          switchValue.add(data1);
        }
      });
    });
  }

  dynamicGeneration() {
    log('$intake');
    if (reminder.length * 250 < intake) {
      for (int x = 0; (x * 250) < getintake(); x++) {
        _selectTime(context,
            TimeOfDay.fromDateTime(DateTime.now().add(Duration(hours: x))));
        if (reminder.length * 250 >= intake) break;
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color.fromARGB(255, 104, 176, 200),
          content: Text(
            'You have enough reminders set, or delete some reminders to dynamically set new ones',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
            textScaleFactor: 1,
          ),
        ),
      );
    }
  }

  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('Default-User');
  int getintake() {
    collectionReference.doc('user1').get().then((value) {
      setState(() {
        intake = (value)['waterIntake'];
      });
    });
    return intake;
  }
}

// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:water_reminder/pages/home.dart';
import 'package:water_reminder/pages/homepage.dart';
import 'package:water_reminder/pages/services/local_notification_service.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ReminderPage> createState() => ReminderPageState();
}

class ReminderPageState extends State<ReminderPage> {
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'high_importance_channel', 'High Importance Notifications',
      importance: Importance.high, playSound: true);

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  List<TimeOfDay> reminder = [];
  List<bool> switchValue = [];
  final format = DateFormat("hh:mm a");
  TimeOfDay setTime = TimeOfDay.now();
  DateTime now = DateTime.now();
  final LocalNotificationService service = LocalNotificationService();
  bool isLoadingDone = false;
  @override
  void initState() {
    reminder = [];
    switchValue = [];
    isLoadingDone = false;
    super.initState();
    getdata();
    service.intialize();
    listenToNotification();
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
      body: !isLoadingDone
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 80, left: 10, right: 10, top: 20),
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
                                            DateTime noti = DateTime(
                                                now.year,
                                                now.month,
                                                now.day,
                                                reminder[index].hour,
                                                reminder[index].minute);

                                            int id = int.parse(
                                                "${noti.hour}${noti.minute}");
                                            if (value == false) {
                                              flutterLocalNotificationsPlugin
                                                  .cancel(id);
                                              log('notification removed for id = $id');
                                            }
                                            if (value == true) {
                                              service.showScheduledNotificationWithPayload(
                                                  id: id,
                                                  title: 'Water Intake Time',
                                                  body:
                                                      'It is time for you to drink 250ml water.',
                                                  hour: 0,
                                                  mins: 0,
                                                  payload: 'payload',
                                                  toSet: noti);
                                            }
                                          });
                                          FirebaseFirestore.instance
                                              .collection('Default-User-Water')
                                              .doc('bool')
                                              .set(
                                                  {"switchValue": switchValue});
                                        },
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                            title: const Text(
                                                "Delete Water Intake Reminder!"),
                                            content: const Text(
                                                "Are you sure you want to delete this Intake Reminder?"),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  _deleteTime(index);
                                                  setState(() {});
                                                  Navigator.pop(context, true);
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(14),
                                                  child: const Text(
                                                    "Delete",
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context, true);
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(14),
                                                  child: const Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                        color: Colors.green),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
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
              ),
            ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'Add',
        backgroundColor: const Color.fromARGB(255, 79, 168, 197),
        onPressed: () {
          bool check = true;
          _selectTime(context, null, check);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  _addItemToList(TimeOfDay setTime, [bool? update]) {
    List<TimeOfDay> tempList = reminder;
    tempList.add(setTime);
    reminder = tempList;
    if (update == true) {
      setState(() {
        reminder = tempList;
      });
    }
  }

  Future<void> _selectTime(BuildContext context,
      [TimeOfDay? time, bool? ss]) async {
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
      setTime = picked;
      if (ss != null) {
        _addItemToList(setTime, ss);
      } else {
        _addItemToList(setTime);
      }

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
      if (time == null) {
        DateTime noti =
            DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
        int id = int.parse("${noti.hour}${noti.minute}");
        service.showScheduledNotificationWithPayload(
            id: id,
            title: 'Water Intake Time',
            body: 'It is time for you to drink 250ml water.',
            hour: 0,
            mins: 0,
            payload: 'payload',
            toSet: noti);
      }
    }
  }

  Future<void> _deleteTime(int index) async {
    DateTime noti = DateTime(now.year, now.month, now.day, reminder[index].hour,
        reminder[index].minute);
    int id = int.parse("${noti.hour}${noti.minute}");
    flutterLocalNotificationsPlugin.cancel(id);
    log('notification cancelled for id = $id');
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

  Future<void> getdata() async {
    final format = DateFormat.jm();
    var docUser = FirebaseFirestore.instance.collection("Default-User-Water");
    docUser.doc('bool').get().then((value) {
      setState(() {
        for (var element in List.from(value['switchValue'])) {
          bool data1 = element;
          switchValue.add(data1);
        }
        isLoadingDone = true;
      });
    });
    docUser.doc('reminders').get().then((value) {
      setState(() {
        for (var element in List.from(value['reminders'])) {
          TimeOfDay data = TimeOfDay.fromDateTime(format.parse(element));
          reminder.add(data);
        }
      });
    });
  }

  void dynamicGeneration(BuildContext context, TimeOfDay bedTimeee,
      TimeOfDay wakeTimeee, int rem, int intake, DateTime wakeTime1) {
    TimeOfDay temp = (bedTimeee.hour < 12)
        ? TimeOfDay(
            hour: (23 - wakeTimeee.hour - bedTimeee.hour).abs(),
            minute: (wakeTimeee.minute - bedTimeee.minute - 60).abs())
        : TimeOfDay(
            hour: (wakeTimeee.hour - bedTimeee.hour).abs(),
            minute: (wakeTimeee.minute - bedTimeee.minute - 60).abs());
    double glass = intake / 250;
    int hour = temp.hour ~/ glass;
    double addMin = temp.hour / glass;
    int min = (temp.minute ~/ glass + ((addMin % 1) * 60)).ceil();
    int hour1 = hour;
    int min1 = min;
    if (bedTimeee.hour >= 12) {
      min = temp.minute ~/ glass;
    }
    if (reminder.length * 250 < intake) {
      for (int x = 0; x <= glass; x++) {
        _selectTime(
            context,
            TimeOfDay.fromDateTime(
                wakeTime1.add(Duration(hours: hour1, minutes: min1))));

        DateTime noti = DateTime(
            now.year, now.month, now.day, wakeTimeee.hour, wakeTimeee.minute);
        DateTime noti1 = DateTime(now.year, now.month, now.day,
            noti.hour + hour1, noti.minute + min1);
        int id = int.parse("${noti1.hour}${noti1.minute}");

        service.showScheduledNotificationWithPayload(
            id: id,
            title: 'Water Intake Time',
            body: 'It is time for you to drink 250ml water.',
            hour: hour1,
            mins: min1,
            payload: 'payload',
            toSet: noti);
        hour1 += hour;
        min1 += min;
        if (reminder.length * 250 >= intake) break;
      }
    }
  }

  void listenToNotification() =>
      service.onNotificationClick.stream.listen(onNoticationListener);

  void onNoticationListener(String? payload) {
    log("listened");
    if (payload != null && payload.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) => Homepage(
                gender: genderrrr,
              )),
        ),
      );
      var list = [TimeOfDay.now().format(context)];
      FirebaseFirestore.instance
          .collection('Default-User-Water')
          .doc('user1')
          .update({"user1": FieldValue.arrayUnion(list)});
      setState(() {
        log('done with updating time $list');
      });
    }
  }
}

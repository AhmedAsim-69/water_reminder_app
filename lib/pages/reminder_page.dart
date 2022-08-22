import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:water_reminder/pages/home.dart';
import 'package:water_reminder/pages/homepage.dart';
import 'package:water_reminder/pages/services/local_notification_service.dart';
import 'package:water_reminder/pages/splashscreen.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ReminderPage> createState() => ReminderPageState();
}

class ReminderPageState extends State<ReminderPage> {
  final format = DateFormat("hh:mm a");
  HomeState callMethod = HomeState();
  TimeOfDay setTime = TimeOfDay.now();
  DateTime now = DateTime.now();
  final LocalNotificationService service = LocalNotificationService();

  @override
  void initState() {
    reminder = [];
    switchValue = [];
    getdata();
    service.intialize();
    listenToNotification();

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
                                  activeColor:
                                      const Color.fromARGB(255, 79, 168, 197),
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
                                      if (value == false) {
                                        flutterLocalNotificationsPlugin
                                            .cancel(index);
                                        log('notification removed for id = ${noti.hashCode}');
                                      }
                                      if (value == true) {
                                        service.showScheduledNotificationWithPayload(
                                            id: noti.hashCode,
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'Add',
        backgroundColor: const Color.fromARGB(255, 79, 168, 197),
        onPressed: () {
          _selectTime(context);
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  _addItemToList(TimeOfDay setTime) {
    List<TimeOfDay> tempList = reminder;
    tempList.add(setTime);
    reminder = tempList;
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
          .set({"reminders ${DateTime.now().day}": tempReminder});

      FirebaseFirestore.instance
          .collection('Default-User-Water')
          .doc('bool')
          .set({"switchValue": switchValue});
      if (time == null) {
        DateTime noti =
            DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
        service.showScheduledNotificationWithPayload(
            id: noti.hashCode,
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
    flutterLocalNotificationsPlugin.cancel(noti.hashCode);
    log('notification cancelled for id = ${noti.hashCode}');
    reminder.removeAt(index);
    switchValue.removeAt(index);
    List<String> tempReminder = [];

    for (var item in reminder) {
      tempReminder.add(item.format(context));
    }
    FirebaseFirestore.instance
        .collection('Default-User-Water')
        .doc('reminders')
        .set({"reminders ${DateTime.now().day}": tempReminder});
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
        for (var element
            in List.from(value['reminders ${DateTime.now().day}'])) {
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

  dynamicGeneration(BuildContext context, TimeOfDay bedTimeee,
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

          service.showScheduledNotificationWithPayload(
              id: noti1.hashCode,
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
  }

  void listenToNotification() =>
      service.onNotificationClick.stream.listen(onNoticationListener);

  void onNoticationListener(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) => Homepage(
                gender: genderrrr,
                enAdd: true,
              )),
        ),
      );
      callMethod.selectTime(context);
      setState(() {});
    }
  }
}

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:water_reminder/pages/reminder_page.dart';

import 'package:water_reminder/pages/water_intake.dart';
import 'package:water_reminder/pages/weight_page.dart';

class SleepCyclePage extends StatefulWidget {
  const SleepCyclePage(
      {Key? key,
      required this.title,
      required this.weight,
      required this.gender})
      : super(key: key);

  final String title;
  final int weight;
  final String gender;

  @override
  State<SleepCyclePage> createState() => _SleepCyclePageState();
}

class _SleepCyclePageState extends State<SleepCyclePage> {
  final weightctrl = TextEditingController();
  final format = DateFormat("hh:mm a");
  late var weight1 = widget.weight;
  late var gender1 = widget.gender;
  DateTime? tempWakeTime = DateTime(2017, 9, 7, 9, 30);
  DateTime? tempBedTime = DateTime(2017, 9, 7, 22, 30);
  ReminderPageState generate = ReminderPageState();

  DateTime? wakeTime = DateTime(2017, 9, 7, 9, 30);
  DateTime? bedTime = DateTime(2017, 9, 7, 22, 30);
  callback1(varTopic) {
    setState(() {
      wakeTime = varTopic;
    });
  }

  callback2(varTopic) {
    setState(() {
      bedTime = varTopic;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 247, 249),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 180),
                alignment: Alignment.center,
                child: const Text(
                  'SLEEP CYCLE',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 79, 168, 197),
                  ),
                ),
              ),
              const SizedBox(
                height: 130,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const BuildPadding(
                      text: 'Wakeup Time',
                      textcolor: Color.fromARGB(255, 97, 97, 97),
                    ),
                    BuildTime(
                        format: format,
                        context: context,
                        time: 'Wakeup',
                        tempTime: tempWakeTime,
                        callbackFunction: callback1),
                    const BuildPadding(
                      text: 'Bed Time',
                      textcolor: Color.fromARGB(255, 97, 97, 97),
                    ),
                    BuildTime(
                        format: format,
                        context: context,
                        time: 'Bed',
                        tempTime: tempBedTime,
                        callbackFunction: callback2),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 79, 168, 197),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                        minimumSize: const Size(325, 45),
                      ),
                      onPressed: () {
                        createUser(
                            weight: widget.weight,
                            gender: widget.gender,
                            bedTime: bedTime,
                            wakeTime: wakeTime);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => WaterIntakePage(
                                  title: 'title',
                                  weight: weight1,
                                  gender: gender1,
                                  bedTime: bedTime,
                                  wakeTime: wakeTime,
                                )));
                        // Navigator.of(context).pushAndRemoveUntil(
                        //     MaterialPageRoute(
                        //       builder: (context) => WaterIntakePage(
                        //         title: 'title',
                        //         weight: weight1,
                        //         gender: gender1,
                        //         bedTime: bedTime,
                        //         wakeTime: wakeTime,
                        //       ),
                        //     ),
                        //     (Route<dynamic> route) => false);
                        // generate.dynamicGeneration(
                        //     TimeOfDay.fromDateTime(bedTime!),
                        //     TimeOfDay.fromDateTime(wakeTime!),
                        //     0);
                      },
                      child: const Text(
                        "CONTINUE",
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildTime extends StatelessWidget {
  final String time;
  final DateTime? tempTime;
  final Function callbackFunction;
  bool? flag;

  BuildTime({
    Key? key,
    required this.format,
    required this.context,
    required this.time,
    required this.tempTime,
    required this.callbackFunction,
    this.flag,
  }) : super(key: key);

  final DateFormat format;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: DateTimeField(
        decoration: InputDecoration(
          hintText: ('Enter $time Time'),
          suffixIcon: const Icon(
            Icons.alarm,
            color: Color.fromARGB(255, 79, 168, 197),
          ),
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
        ),
        format: format,
        initialValue: tempTime,
        validator: (val) {
          if (val != null) {
            return null;
          } else {
            return 'Date Field is Empty';
          }
        },
        onShowPicker: (context, currentValue) async {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          flag = true;

          return DateTimeField.convert(time);
        },
        onChanged: (value) {
          callbackFunction(value);
          flag = true;
        },
      ),
    );
  }
}

class BuildPadding extends StatelessWidget {
  final String text;
  final Color textcolor;
  const BuildPadding({Key? key, required this.text, required this.textcolor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 5,
        bottom: 5,
        right: 250,
      ),
      child: Text(
        text,
        style: TextStyle(color: textcolor),
      ),
    );
  }
}

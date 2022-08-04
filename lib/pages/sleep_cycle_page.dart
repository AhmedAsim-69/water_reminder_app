import 'package:flutter/material.dart';
import 'package:water_reminder/pages/gender_page.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:water_reminder/pages/homepage.dart';

class SleepCyclePage extends StatefulWidget {
  const SleepCyclePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SleepCyclePage> createState() => _SleepCyclePageState();
}

class _SleepCyclePageState extends State<SleepCyclePage> {
  final weightctrl = TextEditingController();
  final format = DateFormat("hh:mm a");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 247, 249),
      body: SingleChildScrollView(
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
                  BuildTime(format: format, context: context, time: 'Wakeup'),
                  const BuildPadding(
                    text: 'Bed Time',
                    textcolor: Color.fromARGB(255, 97, 97, 97),
                  ),
                  BuildTime(format: format, context: context, time: 'Bed'),
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
                    onPressed: () => {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const Homepage(),
                          ),
                          (Route<dynamic> route) => false),
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
    );
  }
}

class BuildTime extends StatelessWidget {
  final String time;
  const BuildTime({
    Key? key,
    required this.format,
    required this.context,
    required this.time,
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
        onShowPicker: (context, currentValue) async {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );

          return DateTimeField.convert(time);
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

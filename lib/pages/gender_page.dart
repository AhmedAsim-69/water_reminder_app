import 'package:flutter/material.dart';
import 'package:water_reminder/pages/sleep_cycle_page.dart';
import 'package:water_reminder/pages/weight_page.dart';

class GenderPage extends StatefulWidget {
  const GenderPage({Key? key, required this.title, required this.weight})
      : super(key: key);

  final String title;
  final int weight;

  @override
  State<GenderPage> createState() => _GenderPageState();
}

enum SingingCharacter { male, female }

class _GenderPageState extends State<GenderPage> {
  SingingCharacter? character = SingingCharacter.male;
  late var weight = widget.weight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 247, 249),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 180),
            alignment: Alignment.center,
            child: const Text(
              'GENDER',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 79, 168, 197),
              ),
            ),
          ),
          Center(
            heightFactor: 2.8,
            // widthFactor: 9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
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
                      switch (character) {
                        case SingingCharacter.male:
                          {
                            createUser(weight: widget.weight, gender: 'Male');
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => SleepCyclePage(
                                          title: 'title',
                                          weight: widget.weight,
                                          gender: 'Female',
                                        )),
                                (Route<dynamic> route) => false);
                            return;
                          }
                        case SingingCharacter.female:
                          {
                            createUser(weight: widget.weight, gender: 'Female');
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => SleepCyclePage(
                                          title: 'title',
                                          weight: weight,
                                          gender: 'Female',
                                        )),
                                (Route<dynamic> route) => false);
                            return;
                          }
                        default:
                          break;
                      }

                      // Navigator.of(context).pushAndRemoveUntil(
                      //     MaterialPageRoute(
                      //         builder: (context) => const SleepCyclePage(
                      //               title: 'title',
                      //             )),
                      //     (Route<dynamic> route) => false);
                    },
                    child: const Text(
                      "CONTINUE",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}

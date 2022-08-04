import 'package:flutter/material.dart';
import 'package:water_reminder/pages/gender_page.dart';
import 'package:water_reminder/pages/sleep_cycle_page.dart';
import 'package:intl/intl.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final weightctrl = TextEditingController();
  SingingCharacter? _character = SingingCharacter.male;
  final format = DateFormat("hh:mm a");

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              controller: weightctrl,
                              decoration: InputDecoration(
                                labelText: 'Enter your weight: ',
                                labelStyle:
                                    const TextStyle(color: Colors.black),
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
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('Male'),
                      leading: Radio<SingingCharacter>(
                        value: SingingCharacter.male,
                        groupValue: _character,
                        onChanged: (SingingCharacter? value) {
                          setState(
                            () {
                              _character = value;
                            },
                          );
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Female'),
                      leading: Radio<SingingCharacter>(
                        value: SingingCharacter.female,
                        groupValue: _character,
                        onChanged: (SingingCharacter? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    const BuildPadding(
                      text: 'Wakeup Time',
                      textcolor: Color.fromARGB(255, 79, 168, 197),
                    ),
                    BuildTime(format: format, context: context, time: 'Wakeup'),
                    const BuildPadding(
                      text: 'Bed Time',
                      textcolor: Color.fromARGB(255, 79, 168, 197),
                    ),
                    BuildTime(format: format, context: context, time: 'Bed'),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 79, 168, 197),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  minimumSize: const Size(325, 45),
                ),
                onPressed: () => {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const GenderPage(
                                title: 'title',
                              )),
                      (Route<dynamic> route) => false),
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
}

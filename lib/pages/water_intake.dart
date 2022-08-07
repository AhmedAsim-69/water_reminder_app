import 'package:flutter/material.dart';
import 'package:water_reminder/pages/homepage.dart';
import 'package:water_reminder/pages/weight_page.dart';

class WaterIntakePage extends StatefulWidget {
  const WaterIntakePage(
      {Key? key,
      required this.title,
      required this.weight,
      required this.gender,
      required this.bedTime,
      required this.wakeTime})
      : super(key: key);

  final String title;
  final int weight;
  final String gender;
  final DateTime? bedTime;
  final DateTime? wakeTime;

  @override
  State<WaterIntakePage> createState() => _WaterIntakePageState();
}

class _WaterIntakePageState extends State<WaterIntakePage> {
  late var waterCal = widget.weight * 0.033 * 1000;
  late var waterIntake = waterCal.round().toInt();

  late var weightctrl = TextEditingController(text: waterIntake.toString());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 247, 249),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BuildText(
                text: 'WATER IN-TAKE',
              ),
              const SizedBox(
                height: 188,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                  bottom: 5,
                ),
                child: Text(
                  'Daily Water In-take',
                  style: TextStyle(color: Colors.grey.shade700),
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
                        // initialValue: '20',
                        keyboardType: TextInputType.number,
                        controller: weightctrl,
                        readOnly: true,
                        decoration: InputDecoration(
                          // labelText: 'Enter your weight: ',
                          // labelStyle: const TextStyle(color: Colors.black),
                          // enabledBorder: OutlineInputBorder(
                          //   borderSide: const BorderSide(
                          //     width: 2,
                          //     color: Color.fromARGB(255, 79, 168, 197),
                          //   ),
                          //   borderRadius: BorderRadius.circular(8),
                          // ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 79, 168, 197),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          // border: OutlineInputBorder(
                          //   borderSide:
                          //       const BorderSide(width: 2, color: Colors.green),
                          //   borderRadius: BorderRadius.circular(8),
                          // ),
                          // errorStyle: const TextStyle(
                          //     color: Colors.redAccent, fontSize: 14),
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
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter your weight';
                        //   }
                        //   return null;
                        // },
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
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            waterIntake = int.parse(weightctrl.text);
                            createUser(
                              weight: widget.weight,
                              gender: widget.gender,
                              wakeTime: widget.bedTime,
                              bedTime: widget.bedTime,
                              waterIntake: waterIntake,
                            );
                          });
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => const Homepage(),
                              ),
                              (Route<dynamic> route) => false);
                        }
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

class BuildText extends StatelessWidget {
  final String text;
  const BuildText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 180),
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 79, 168, 197),
        ),
      ),
    );
  }
}

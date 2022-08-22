import 'package:flutter/material.dart';
import 'package:water_reminder/pages/gender_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WeightPage extends StatefulWidget {
  const WeightPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<WeightPage> createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  final weightctrl = TextEditingController();
  var weight = 0;
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
                text: 'WEIGHT',
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
                  'Weight',
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
                        keyboardType: TextInputType.number,
                        controller: weightctrl,
                        decoration: InputDecoration(
                          labelText: 'Enter your weight: ',
                          labelStyle: const TextStyle(color: Colors.black),
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
                            borderSide:
                                const BorderSide(width: 2, color: Colors.green),
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
                          }
                          return null;
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
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            weight = int.parse(weightctrl.text);
                            createUser(weight: weight);
                          });
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => GenderPage(
                                    title: 'title',
                                    weight: weight,
                                  )));
                          // Navigator.of(context).pushAndRemoveUntil(
                          //     MaterialPageRoute(
                          //         builder: (context) => GenderPage(
                          //               title: 'title',
                          //               weight: weight,
                          //             )),
                          //     (Route<dynamic> route) => false);
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

Future createUser({
  int? weight,
  String? gender,
  DateTime? wakeTime,
  DateTime? bedTime,
  int? waterIntake,
}) async {
  final docUser =
      FirebaseFirestore.instance.collection('Default-User').doc('user1');

  final json = {
    'weight': weight,
    'gender': gender,
    'bedTime': bedTime,
    'wakeTime': wakeTime,
    'waterIntake': waterIntake,
  };

  await docUser.set(json);
}

class User {
  int? weight;
  String? gender;
  DateTime? wakeTime;
  DateTime? bedTime;
  int? waterIntake;

  User({
    required this.weight,
    required this.gender,
    required this.wakeTime,
    required this.bedTime,
    required this.waterIntake,
  });

  Map<String, dynamic> toJson() => {
        'weight': weight,
        'gender': gender,
        'bedTime': bedTime,
        'wakeTime': wakeTime,
        'waterIntake': waterIntake,
      };

  static User fromJson(Map<String, dynamic> json) => User(
        weight: json['weight'],
        gender: json['gender'],
        wakeTime: (json['wakeTime'] as Timestamp).toDate(),
        bedTime: (json['bedTime'] as Timestamp).toDate(),
        waterIntake: json['waterIntake'],
      );
}

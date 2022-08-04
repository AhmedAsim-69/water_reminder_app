import 'package:flutter/material.dart';
import 'package:water_reminder/pages/gender_page.dart';

class WeightPage extends StatefulWidget {
  const WeightPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<WeightPage> createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  final weightctrl = TextEditingController();
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
                'WEIGHT',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 79, 168, 197),
                ),
              ),
            ),
            const SizedBox(
              height: 188,
            ),
            Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                  bottom: 5,
                ),
                child: Text('Weight',
                    style: TextStyle(color: Colors.grey.shade700))),
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
                              builder: (context) => const GenderPage(
                                    title: 'title',
                                  )),
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

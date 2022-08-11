import 'dart:math';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:water_reminder/pages/sleep_cycle_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final format = DateFormat("hh:mm a");
  List<TimeOfDay?> times = [];
  TimeOfDay? setTime = TimeOfDay.now();
  // DateTime setTime = DateTime.now();
  // callback(varTopic) {
  //   setState(() {
  //     setTime = varTopic;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 241, 247, 249),
        title: const Text(
          "Home",
          textScaleFactor: 1,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 241, 247, 249),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(
                    Icons.water_drop_outlined,
                    color: Colors.blue,
                    size: 40.0,
                  ),
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 104, 176, 200),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Do not drink cold water immediately after hot drinks',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(20),
                height: 85,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: const [
                        ImageIcon(
                          AssetImage("assets/waterglassicon.png"),
                          color: Colors.blue,
                          size: 40,
                        ),
                        Text(
                          'Ideal Water Intake',
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          '2810 ml',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 60,
                      child: VerticalDivider(
                        color: Color.fromARGB(255, 104, 176, 200),
                        thickness: 2,
                      ),
                    ),
                    Column(
                      children: const [
                        Icon(
                          Icons.emoji_events,
                          color: Colors.yellow,
                          size: 40,
                        ),
                        Text(
                          'Ideal Water Intake',
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          '2810 ml',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(20),
                height: 300,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 30,
                        bottom: 20,
                        left: 15,
                      ),
                      child: const RotatedBox(
                        quarterTurns: -1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: LinearProgressIndicator(
                            minHeight: 90,
                            value: 0.5,
                            valueColor: AlwaysStoppedAnimation(
                              Color.fromARGB(255, 104, 176, 200),
                            ),
                            backgroundColor: Color.fromARGB(255, 241, 247, 249),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 20,
                          left: 20,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: '800',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 104, 176, 200),
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: '/2600',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 30),
                                  ),
                                  WidgetSpan(
                                    child: Transform.translate(
                                      offset: const Offset(0.0, 4.0),
                                      child: const Text(
                                        'ml',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              alignment: Alignment.center,
                              child: const Expanded(
                                child: Text(
                                  'Your have completed this %age of your Daily Target',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                            TextButton.icon(
                              style: ElevatedButton.styleFrom(
                                primary:
                                    const Color.fromARGB(255, 79, 168, 197),
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                minimumSize: const Size(325, 45),
                              ),
                              onPressed: () {
                                _selectTime(context);
                              },
                              icon: const Icon(
                                Icons.add_sharp,
                                color: Colors.white,
                              ),
                              label: const Text(
                                'Add 250ml',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.white,
                    child: const Text(
                      "Today's Records",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: times.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          tileColor: Colors.white,
                          leading: const Icon(
                            Icons.water_drop,
                            color: Colors.blueAccent,
                          ),
                          title: const Text(
                            '250ml',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          trailing: SizedBox(
                            width: 110,
                            child: Row(
                              children: [
                                Text(
                                  '${times[index]?.format(context)}',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                                PopupMenuButton<String>(
                                  color:
                                      const Color.fromARGB(255, 241, 247, 249),
                                  onSelected: (choice) {
                                    handleClick(choice, index);
                                  },
                                  itemBuilder: (BuildContext context) {
                                    return {'Edit', 'Delete'}
                                        .map((String choice) {
                                      return PopupMenuItem<String>(
                                        value: choice,
                                        child: Text(choice),
                                      );
                                    }).toList();
                                  },
                                ),
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
    );
  }

  _addItemToList(TimeOfDay? setTime) {
    List<TimeOfDay?> tempList = times;
    tempList.add(setTime);
    setState(() {
      times = tempList;
    });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked_s = await showTimePicker(
      context: context,
      initialTime: setTime!,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (picked_s != null && picked_s != setTime) {
      setState(() {
        setTime = picked_s;
        _addItemToList(setTime);
      });
    }
  }

  Future<void> _editTime(BuildContext context, int index) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: setTime!,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (picked != null && picked != setTime) {
      setState(() {
        setTime = picked;
        times[index] = setTime;
      });
    }
  }

  void handleClick(String value, int index) {
    switch (value) {
      case 'Edit':
        _editTime(context, index);
        break;

      case 'Delete':
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Delete Password!"),
            content:
                const Text("Are you sure you want to delete this Password?"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  times.removeAt(index);
                  Navigator.pop(context, true);
                },
                child: Container(
                  padding: const EdgeInsets.all(14),
                  child: const Text(
                    "Delete",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: Container(
                  padding: const EdgeInsets.all(14),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ),
            ],
          ),
        );
        break;
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

List<TimeOfDay> times = [];

class _HomeState extends State<Home> {
  final format = DateFormat("hh:mm a");
  TimeOfDay setTime = TimeOfDay.now();
  int intake = 1;

  @override
  void initState() {
    times = [];
    getdata();
    getintake();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double val = (times.length) / intake * 250;
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
                      child: RotatedBox(
                        quarterTurns: -1,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: LinearProgressIndicator(
                            minHeight: 90,
                            value: val,
                            valueColor: const AlwaysStoppedAnimation(
                              Color.fromARGB(255, 104, 176, 200),
                            ),
                            backgroundColor:
                                const Color.fromARGB(255, 241, 247, 249),
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
                                  TextSpan(
                                    text: '${(times.length) * 250}',
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 104, 176, 200),
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "/ $intake",
                                    style: const TextStyle(
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
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Your have completed ${(times.length * 250 / intake * 100).round()}% of your Daily Target",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
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
                                (times.length * 250 >= intake)
                                    ? snackbar("You have achieved today's goal",
                                        context)
                                    : _selectTime(context);
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
                                  times[index].format(context),
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

  _addItemToList(TimeOfDay setTime) {
    List<TimeOfDay> tempList = times;
    tempList.add(setTime);
    setState(() {
      times = tempList;
    });
  }

  Future<void> _selectTime(BuildContext context, [int? index]) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: setTime,
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
        (index == null) ? _addItemToList(setTime) : times[index] = setTime;

        List<String> tempTimes = [];

        for (var item in times) {
          tempTimes.add(item.format(context));
        }
        FirebaseFirestore.instance
            .collection('Default-User-Water')
            .doc('user1')
            .set({"user1": tempTimes});
      });
    }
  }

  Future<void> _deleteTime(int index) async {
    times.removeAt(index);
    List<String> tempTimes = [];

    for (var item in times) {
      tempTimes.add(item.format(context));
    }
    FirebaseFirestore.instance
        .collection('Default-User-Water')
        .doc('user1')
        .set({"user1": tempTimes});
  }

  void handleClick(String value, int index) {
    switch (value) {
      case 'Edit':
        _selectTime(context, index);
        break;

      case 'Delete':
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Delete Water Intake Time!"),
            content:
                const Text("Are you sure you want to delete this Intake Time?"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  _deleteTime(index);
                  setState(() {});
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

  getdata() async {
    final format = DateFormat.jm();
    await FirebaseFirestore.instance
        .collection("Default-User-Water")
        .doc('user1')
        .get()
        .then((value) {
      setState(() {
        for (var element in List.from(value['user1'])) {
          TimeOfDay data = TimeOfDay.fromDateTime(format.parse(element));
          times.add(data);
        }
      });
    });
  }

  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('Default-User');
  int getintake() {
    collectionReference.doc('user1').get().then((value) {
      setState(() {
        intake = (value)['waterIntake'];
      });
    });
    return intake;
  }
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackbar(
    String msg, BuildContext context) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: const Color.fromARGB(255, 104, 176, 200),
      content: Text(
        msg,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
        textScaleFactor: 1,
      ),
    ),
  );
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:developer' as developer;

class Page3 extends StatefulWidget {
  final String username;
  const Page3({required this.username, Key? key}) : super(key: key);
  @override
  State<Page3> createState() => _Page3();
}

DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

class _Page3 extends State<Page3> {
  Map<dynamic, dynamic>? waterObject = {
    'control': false,
    'sensor': 0,
    'setting': 0
  };
  Map<dynamic, dynamic>? foodObject = {
    'control': false,
    'sensor': 0,
    'setting': 0
  };
  Map<dynamic, dynamic>? tempObject = {
    'control': false,
    'sensor': 0,
    'setting': 0
  };
  Map<dynamic, dynamic>? humidityObject = {
    'control': false,
    'sensor': 0,
    'setting': 0
  };

  @override
  void initState() {
    super.initState();
    databaseReference
        .child("${widget.username}/controller/water_control")
        .onValue
        .listen((event) {
      if (event.snapshot.value.toString() != 'null') {
        setState(() {
          waterObject = event.snapshot.value as Map<dynamic, dynamic>?;
        });
      }
    });
    databaseReference
        .child("${widget.username}/controller/food_control")
        .onValue
        .listen((event) {
      if (event.snapshot.value.toString() != 'null') {
        setState(() {
          foodObject = event.snapshot.value as Map<dynamic, dynamic>?;
        });
      }
    });
    databaseReference
        .child("${widget.username}/controller/temperature")
        .onValue
        .listen((event) {
      if (event.snapshot.value.toString() != 'null') {
        setState(() {
          tempObject = event.snapshot.value as Map<dynamic, dynamic>?;
        });
      }
    });
    databaseReference
        .child("${widget.username}/controller/humidity")
        .onValue
        .listen((event) {
      if (event.snapshot.value.toString() != 'null') {
        setState(() {
          humidityObject = event.snapshot.value as Map<dynamic, dynamic>?;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            width: screenSize.width * 0.9,
            height: screenSize.height * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromRGBO(255, 191, 0, 0.549),
            ),
            child: Column(
              children: [
                const Text(
                  'ตั้งค่าการใช้งาน',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w900,
                    color: Color.fromARGB(255, 255, 255, 255),
                    shadows: [
                      Shadow(
                        color: Color.fromARGB(
                            255, 0, 68, 255), // Choose the color of the shadow
                        blurRadius:
                            2.0, // Adjust the blur radius for the shadow effect
                        offset: Offset(2.0,
                            2.0), // Set the horizontal and vertical offset for the shadow
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  width: screenSize.width * 0.8,
                  height: screenSize.height * 0.8 * 0.55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      buildSettingRow(Icons.water_drop_rounded,
                          waterObject!['control'], "water"),
                      buildSettingRow(Icons.food_bank_outlined,
                          foodObject!['control'], "food"),
                      buildSettingRow(CupertinoIcons.thermometer,
                          tempObject!['control'], "temperature"),
                      buildSettingRow(CupertinoIcons.snow,
                          humidityObject!['control'], "humidity"),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget buildSettingRow(IconData icon, bool value, String type) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: _getIconColor(type),
                size: 70.0,
              ),
              const SizedBox(width: 10),
              Text(
                type.toUpperCase(),
                style: const TextStyle(
                  color: Color.fromARGB(255, 17, 4, 39),
                  fontSize: 15.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text('ปิด'),
              Switch(
                activeColor: Color.fromARGB(255, 255, 170, 0),
                inactiveTrackColor: Color.fromARGB(255, 165, 139, 88),
                inactiveThumbColor: Color.fromARGB(255, 255, 170, 0),
                value: value,
                onChanged: (value) async {
                  switch (type) {
                    case "water":
                      await databaseReference
                          .child('${widget.username}/controller/water_control')
                          .update({
                        'control':
                            waterObject!['sensor'] < waterObject!['setting']
                                ? !waterObject!['control']
                                : false,
                      });
                      break; //จบ
                    case "food":
                      await databaseReference
                          .child('${widget.username}/controller/food_control')
                          .update({
                        'control':
                            foodObject!['sensor'] < foodObject!['setting']
                                ? !foodObject!['control']
                                : false,
                      });
                      break; //จบ
                    case "temperature":
                      await databaseReference
                          .child('${widget.username}/controller/temperature')
                          .update({
                        'control':
                            tempObject!['sensor'] > tempObject!['setting']
                                ? !tempObject!['control']
                                : false,
                      });
                      break; //จบ
                    case "humidity":
                      await databaseReference
                          .child('${widget.username}/controller/humidity')
                          .update({
                        'control': humidityObject!['sensor'] >
                                humidityObject!['setting']
                            ? !humidityObject!['control']
                            : false,
                      });
                      break; //จบ
                    default:
                  }
                },
              ),
              const Text('เปิด'),
            ],
          ),
        ],
      ),
    );
  }

  Color _getIconColor(String type) {
    switch (type) {
      case 'water':
        return const Color.fromARGB(255, 23, 108, 235);
      case 'temperature':
        return const Color.fromARGB(255, 226, 117, 15);
      case 'food':
        return Color.fromARGB(255, 47, 192, 83);
      case 'humidity':
        return Color.fromARGB(255, 13, 152, 238);
      default:
        return Colors.black;
    }
  }
}

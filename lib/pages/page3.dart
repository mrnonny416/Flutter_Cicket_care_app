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
  bool waterBool = false;
  bool foodBool = false;
  bool temperatureBool = false;
  bool humidityBool = false;
  int waterSensor = 0,
      foodSensor = 0,
      temperatureSensor = 0,
      humiditySensor = 0;
  int waterSetting = 0,
      foodSetting = 0,
      temperatureSetting = 0,
      humiditySetting = 0;

  @override
  void initState() {
    super.initState();
//water-------------------start
    databaseReference
        .child('${widget.username}/controller/water_control/control')
        .onValue
        .listen((event) {
      bool firebaseValue =
          event.snapshot.value.toString().toUpperCase() == "TRUE"
              ? true
              : false;
      setState(() {
        waterBool = firebaseValue;
      });
    });
    databaseReference
        .child('${widget.username}/controller/water_control/sensor')
        .onValue
        .listen((event) {
      int firebaseWaterSensor = int.parse(event.snapshot.value.toString());
      databaseReference
          .child('${widget.username}/controller/water_control/setting')
          .onValue
          .listen((event) {
        int firebaseWaterSetting = int.parse(event.snapshot.value.toString());
        setState(() {
          waterSensor = firebaseWaterSensor;
          waterSetting = firebaseWaterSetting;
        });
        developer.log("Water Sensor : $waterSensor");
        developer.log("Water Setting : $waterSetting");
        if (waterSensor >= waterSetting) {
          databaseReference
              .child('${widget.username}/controller/water_control')
              .update({
            'control': false,
          });
        }
      });
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
            color: const Color.fromARGB(255, 126, 87, 194),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              const Text(
                'ตั้งค่าการใช้งาน',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              buildSettingRow(Icons.water_drop_rounded, waterBool, "water"),
              buildSettingRow(Icons.food_bank_outlined, foodBool, "food"),
              buildSettingRow(Icons.wind_power, temperatureBool, "temperature"),
              buildSettingRow(
                  CupertinoIcons.lightbulb, humidityBool, "humidity"),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSettingRow(IconData icon, bool value, String type) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: _getIconColor(type),
                size: 80.0,
              ),
              const SizedBox(width: 10),
              Text(
                type,
                style: const TextStyle(
                  color: Color.fromARGB(255, 17, 4, 39),
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text('ปิด'),
              Switch(
                value: value,
                onChanged: (value) async {
                  switch (type) {
                    case "water": //เริ่ม แก้ตาม type
                      await databaseReference
                          .child('${widget.username}/controller/water_control')
                          .update({
                        // แก้ตาม db
                        'control': waterSensor < waterSetting
                            ? !waterBool
                            : false, //แก้ตามตัวแปร
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
        return const Color.fromARGB(255, 126, 110, 6);
      case 'humidity':
        return const Color.fromARGB(255, 233, 236, 15);
      default:
        return Colors.black;
    }
  }
}

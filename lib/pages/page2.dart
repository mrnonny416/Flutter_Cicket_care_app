import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final TextEditingController temperatureController = TextEditingController();
final TextEditingController humidityController = TextEditingController();

class Page2 extends StatefulWidget {
  final String username;
  const Page2({required this.username, Key? key}) : super(key: key);
  @override
  State<Page2> createState() => _Page2();
}

DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

class _Page2 extends State<Page2> {
  String settingTemperatureText = 'Loading..';
  String settingHumidityText = 'Loading..';

  @override
  void initState() {
    super.initState();
    databaseReference
        .child('${widget.username}/controller/temperature/setting')
        .onValue
        .listen((event) {
      final String settingWaterValue = event.snapshot.value.toString();
      setState(() {
        settingTemperatureText = settingWaterValue;
      });
    });
    databaseReference
        .child('${widget.username}/controller/humidity/setting')
        .onValue
        .listen((event) {
      final String settingFoodValue = event.snapshot.value.toString();
      setState(() {
        settingHumidityText = settingFoodValue;
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
            color: const Color.fromRGBO(255, 191, 0, 0.549),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: screenSize.width,
                height: screenSize.height * 0.8 * 0.06,
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                color: const Color.fromRGBO(3, 250, 250, 0),
                child: const Text(
                  "อุณหภูมิ & ความชื้น",
                  textAlign: TextAlign.center,
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
              ),
              Container(
                width: screenSize.width,
                height: screenSize.height * 0.8 * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(0, 255, 0, 0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //---------temp-----------
                    Container(
                      width: screenSize.width * 0.8 * 0.8,
                      height: screenSize.height * 0.8 * 0.4,
                      padding: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            CupertinoIcons.thermometer,
                            color: Color.fromARGB(255, 245, 158, 59),
                            size: 50.0,
                          ),
                          const Text(
                            "อุณหภูมิ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromARGB(255, 17, 4, 39),
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            color: const Color.fromARGB(0, 255, 255, 255),
                            child: StreamBuilder(
                              stream: databaseReference
                                  .child(
                                      '${widget.username}/controller/temperature/sensor')
                                  .onValue,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final int fullTextFromDb = int.parse(
                                      snapshot.data!.snapshot.value.toString());
                                  return Text(
                                    "${fullTextFromDb}C",
                                    style: const TextStyle(
                                      fontSize: 30.0,
                                      color: Color.fromARGB(255, 61, 77, 8),
                                    ),
                                  );
                                } else {
                                  return const Text('Loading...');
                                }
                              },
                            ),
                          ),
                          const Text("ตั้งค่า"),
                          Container(
                            color: const Color.fromARGB(0, 255, 255, 255),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: screenSize.width * 0.8 * 0.5 * 0.5,
                                  height: screenSize.height * 0.8 * 0.9 * 0.07,
                                  child: TextField(
                                    controller: temperatureController,
                                    textAlign: TextAlign.center,
                                    textAlignVertical: TextAlignVertical.top,
                                    style: const TextStyle(fontSize: 20),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        border: const OutlineInputBorder(),
                                        floatingLabelAlignment:
                                            FloatingLabelAlignment.center,
                                        labelText: settingTemperatureText,
                                        labelStyle: const TextStyle(
                                          fontSize: 30.0,
                                          fontWeight: FontWeight.w500,
                                        )),
                                  ),
                                ),
                                const Text("C")
                              ],
                            ),
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: () async {
                              temperatureController.text != ""
                                  ? await databaseReference
                                      .child(
                                          '${widget.username}/controller/temperature')
                                      .update({
                                      'setting': int.parse(temperatureController
                                          .text
                                          .toString()),
                                    })
                                  : "";
                              temperatureController.clear();
                            },
                            icon: const Icon(Icons.cloud_upload_outlined,
                                size: 30),
                            label: const Text("SAVE"),
                          )
                        ],
                      ),
                    ),
                    //---------end temp-----------
                    //---------moisture-----------
                    Container(
                      width: screenSize.width * 0.8 * 0.8,
                      height: screenSize.height * 0.8 * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            CupertinoIcons.snow,
                            color: Color.fromARGB(255, 0, 184, 240),
                            size: 50.0,
                          ),
                          const Text(
                            "ความชื้น",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromARGB(255, 17, 4, 39),
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            color: const Color.fromARGB(0, 255, 255, 255),
                            child: StreamBuilder(
                              stream: databaseReference
                                  .child(
                                      '${widget.username}/controller/humidity/sensor')
                                  .onValue,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final int fullTextFromDb = int.parse(
                                      snapshot.data!.snapshot.value.toString());
                                  return Text(
                                    "$fullTextFromDb%",
                                    style: const TextStyle(
                                      fontSize: 30.0,
                                      color: Color.fromARGB(255, 61, 77, 8),
                                    ),
                                  );
                                } else {
                                  return const Text('Loading...');
                                }
                              },
                            ),
                          ),
                          const Text("ตั้งค่า"),
                          Container(
                            color: const Color.fromARGB(0, 255, 255, 255),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: screenSize.width * 0.8 * 0.5 * 0.5,
                                  height: screenSize.height * 0.8 * 0.9 * 0.07,
                                  child: TextField(
                                    controller: humidityController,
                                    textAlign: TextAlign.center,
                                    textAlignVertical: TextAlignVertical.top,
                                    style: const TextStyle(fontSize: 20),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        border: const OutlineInputBorder(),
                                        floatingLabelAlignment:
                                            FloatingLabelAlignment.center,
                                        labelText: settingHumidityText,
                                        labelStyle: const TextStyle(
                                          fontSize: 30.0,
                                          fontWeight: FontWeight.w500,
                                        )),
                                  ),
                                ),
                                const Text("%.")
                              ],
                            ),
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: () async {
                              humidityController.text != ""
                                  ? await databaseReference
                                      .child(
                                          '${widget.username}/controller/humidity')
                                      .update({
                                      'setting': int.parse(
                                          humidityController.text.toString()),
                                    })
                                  : "";
                              humidityController.clear();
                            },
                            icon: const Icon(Icons.cloud_upload_outlined,
                                size: 30),
                            label: const Text("SAVE"),
                          )
                        ],
                      ),
                    ),
                    //---------end moisture-----------
                  ],
                ),
              )
            ],
          ),
        )));
  }
}

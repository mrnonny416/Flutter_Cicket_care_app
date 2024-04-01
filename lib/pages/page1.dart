import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:developer' as developer;

final TextEditingController waterController = TextEditingController();
final TextEditingController foodController = TextEditingController();

class Page1 extends StatefulWidget {
  final String username;
  const Page1({required this.username, Key? key}) : super(key: key);
  @override
  State<Page1> createState() => _Page1();
}

DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

class _Page1 extends State<Page1> {
  String fullText = "เต็ม";
  String halfText = "พอดี";
  String lowText = "ใกล้หมด";
  String settingWaterText = 'Loading..';
  String settingFoodText = 'Loading..';

  @override
  void initState() {
    super.initState();
    databaseReference
        .child("${widget.username}/controller/water_control/setting")
        .onValue
        .listen((event) {
      final String settingWaterValue = event.snapshot.value.toString();
      setState(() {
        settingWaterText = settingWaterValue;
      });
    });
    databaseReference
        .child('${widget.username}/controller/food_control/setting')
        .onValue
        .listen((event) {
      final String settingFoodValue = event.snapshot.value.toString();
      setState(() {
        settingFoodText = settingFoodValue;
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
            children: [
              Container(
                width: screenSize.width,
                height: screenSize.height * 0.8 * 0.05,
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                color: const Color.fromRGBO(3, 250, 250, 0),
                child: const Text(
                  "น้ำ & อาหาร",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
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
                    //---------water-----------
                    Container(
                      width: screenSize.width * 0.8 * 0.8,
                      height: screenSize.height * 0.8 * 0.4,
                      padding: const EdgeInsets.only(top: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.water_drop_rounded,
                            color: Color.fromARGB(255, 59, 145, 245),
                            size: 50.0,
                          ),
                          const Text(
                            "ปริมาณน้ำ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromARGB(255, 17, 4, 39),
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            color: const Color.fromARGB(0, 255, 255, 255),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                StreamBuilder(
                                  stream: databaseReference
                                      .child(
                                          '${widget.username}/controller/water_control/sensor')
                                      .onValue,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      int fullTextFromDb = 0;
                                      if (snapshot.data!.snapshot.value !=
                                          null) {
                                        fullTextFromDb = int.parse(snapshot
                                            .data!.snapshot.value
                                            .toString());
                                      }
                                      return Image.asset(
                                        fullTextFromDb >=
                                                int.parse(settingWaterText) /
                                                    3 *
                                                    2
                                            ? 'assets/images/H.png'
                                            : fullTextFromDb >=
                                                    int.parse(
                                                            settingWaterText) /
                                                        3 *
                                                        1
                                                ? 'assets/images/M.png'
                                                : 'assets/images/L.png',
                                        width: 20.0,
                                      );
                                    } else {
                                      return const Text('Loading...');
                                    }
                                  },
                                ),
                                StreamBuilder(
                                  stream: databaseReference
                                      .child(
                                          '${widget.username}/controller/water_control/sensor')
                                      .onValue,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      final int fullTextFromDb = int.parse(
                                          snapshot.data!.snapshot.value
                                              .toString());
                                      return Text(
                                        fullTextFromDb >=
                                                int.parse(settingWaterText) /
                                                    3 *
                                                    2
                                            ? fullText
                                            : fullTextFromDb >=
                                                    int.parse(
                                                            settingWaterText) /
                                                        3 *
                                                        1
                                                ? halfText
                                                : lowText,
                                        style: const TextStyle(
                                          fontSize: 30.0,
                                          color: Colors.blue,
                                        ),
                                      );
                                    } else {
                                      return const Text('Loading...');
                                    }
                                  },
                                ),
                              ],
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
                                    controller: waterController,
                                    textAlign: TextAlign.center,
                                    textAlignVertical: TextAlignVertical.top,
                                    style: const TextStyle(fontSize: 20),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        border: const OutlineInputBorder(),
                                        floatingLabelAlignment:
                                            FloatingLabelAlignment.center,
                                        labelText: settingWaterText,
                                        labelStyle:
                                            const TextStyle(fontSize: 20)),
                                  ),
                                ),
                                const Text("ML.")
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
                              waterController.text != ""
                                  ? await databaseReference
                                      .child(
                                          '${widget.username}/controller/water_control')
                                      .update({
                                      'setting': int.parse(
                                          waterController.text.toString()),
                                    })
                                  : "";
                              waterController.clear();
                            },
                            icon: const Icon(Icons.cloud_upload_outlined,
                                size: 30),
                            label: const Text("SAVE"),
                          )
                        ],
                      ),
                    ),
                    //---------end water-----------
                    //---------food-----------
                    Container(
                      width: screenSize.width * 0.8 * 0.8,
                      height: screenSize.height * 0.8 * 0.4,
                      padding: const EdgeInsets.only(top: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.food_bank_outlined,
                            color: Color.fromARGB(255, 126, 110, 6),
                            size: 50.0,
                          ),
                          const Text(
                            "ปริมาณอาหาร",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromARGB(255, 17, 4, 39),
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            color: const Color.fromARGB(0, 255, 255, 255),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                StreamBuilder(
                                  stream: databaseReference
                                      .child(
                                          '${widget.username}/controller/food_control/sensor')
                                      .onValue,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      int fullTextFromDb = 0;
                                      if (snapshot.data!.snapshot.value !=
                                          null) {
                                        fullTextFromDb = int.parse(snapshot
                                            .data!.snapshot.value
                                            .toString());
                                      }
                                      return Image.asset(
                                        fullTextFromDb >=
                                                int.parse(settingFoodText) /
                                                    3 *
                                                    2
                                            ? 'assets/images/H.png'
                                            : fullTextFromDb >=
                                                    int.parse(settingFoodText) /
                                                        3 *
                                                        1
                                                ? 'assets/images/M.png'
                                                : 'assets/images/L.png',
                                        width: 20.0,
                                      );
                                    } else {
                                      return const Text('Loading...');
                                    }
                                  },
                                ),
                                StreamBuilder(
                                  stream: databaseReference
                                      .child(
                                          '${widget.username}/controller/food_control/sensor')
                                      .onValue,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      final int fullTextFromDb = int.parse(
                                          snapshot.data!.snapshot.value
                                              .toString());
                                      return Text(
                                        fullTextFromDb >=
                                                int.parse(settingFoodText) /
                                                    3 *
                                                    2
                                            ? fullText
                                            : fullTextFromDb >=
                                                    int.parse(settingFoodText) /
                                                        3 *
                                                        1
                                                ? halfText
                                                : lowText,
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
                              ],
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
                                    controller: foodController,
                                    textAlign: TextAlign.center,
                                    textAlignVertical: TextAlignVertical.top,
                                    style: const TextStyle(fontSize: 20),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        border: const OutlineInputBorder(),
                                        floatingLabelAlignment:
                                            FloatingLabelAlignment.center,
                                        labelText: settingFoodText,
                                        labelStyle:
                                            const TextStyle(fontSize: 20)),
                                  ),
                                ),
                                const Text("G.")
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
                              foodController.text != ""
                                  ? await databaseReference
                                      .child(
                                          '${widget.username}/controller/food_control')
                                      .update({
                                      'setting': int.parse(
                                          foodController.text.toString()),
                                    })
                                  : "";
                              foodController.clear();
                            },
                            icon: const Icon(Icons.cloud_upload_outlined,
                                size: 30),
                            label: const Text("SAVE"),
                          )
                        ],
                      ),
                    ),
                    //---------end food-----------
                  ],
                ),
              )
            ],
          ),
        )));
  }
}

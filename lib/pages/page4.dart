import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart'; // เพิ่มการนำเข้า shared_preferences

class Page4 extends StatefulWidget {
  final String username;
  const Page4({required this.username, Key? key}) : super(key: key);
  @override
  State<Page4> createState() => _Page4();
}

DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

class _Page4 extends State<Page4> {
  DateTime selectedDate = DateTime.now();
  int waterReportCount = 0;
  int foodReportCount = 0;
  int tempReportCount = 0;
  int humidityReportCount = 0;

  @override
  void initState() {
    super.initState();
    _loadSelectedDate(); // โหลดค่า selectedDate เมื่อเริ่มต้น
    _loadReportCounts(); // โหลดค่าของตัวแปร waterReportCount, foodReportCount, tempReportCount, humidityReportCount เมื่อเริ่มต้น
  }

  // ฟังก์ชันสำหรับบันทึก selectedDate
  Future<void> _saveSelectedDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedDate', selectedDate.toIso8601String());
  }

  // ฟังก์ชันสำหรับโหลด selectedDate
  Future<void> _loadSelectedDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? dateString = prefs.getString('selectedDate');
    if (dateString != null) {
      setState(() {
        selectedDate = DateTime.parse(dateString);
      });
    }
  }

  // ฟังก์ชันสำหรับบันทึกค่า report counts
  Future<void> _saveReportCounts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('waterReportCount', waterReportCount);
    prefs.setInt('foodReportCount', foodReportCount);
    prefs.setInt('tempReportCount', tempReportCount);
    prefs.setInt('humidityReportCount', humidityReportCount);
  }

  // ฟังก์ชันสำหรับโหลดค่า report counts
  Future<void> _loadReportCounts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      waterReportCount = prefs.getInt('waterReportCount') ?? 0;
      foodReportCount = prefs.getInt('foodReportCount') ?? 0;
      tempReportCount = prefs.getInt('tempReportCount') ?? 0;
      humidityReportCount = prefs.getInt('humidityReportCount') ?? 0;
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
              const Text(
                'รายงานผลประจำวัน',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w900,
                  color: Color.fromARGB(255, 255, 255, 255),
                  shadows: [
                    Shadow(
                      color: Color.fromARGB(255, 0, 68, 255),
                      blurRadius: 2.0,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
              ),
              Container(
                width: screenSize.width * 0.8,
                height: screenSize.height * 0.3,
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _buildDatePicker(context);
                      },
                      child: Text(
                        'Selected Date: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(50, 10, 50, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "น้ำ : ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 10, 0, 0),
                            ),
                          ),
                          Text(
                            "$waterReportCount Time",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 10, 0, 0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(50, 10, 50, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "อาหาร : ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          Text(
                            "$foodReportCount Time",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(50, 10, 50, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "พัดลมอุณหภูมิ : ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          Text(
                            "$tempReportCount Time",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(50, 10, 50, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "พัดลมความชื้น : ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          Text(
                            "$humidityReportCount Time",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _buildDatePicker(BuildContext context) {
    BottomPicker.date(
      pickerTitle: const Text(
        'Set Date',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      dateOrder: DatePickerDateOrder.dmy,
      initialDateTime:
          DateTime(selectedDate.year, selectedDate.month, selectedDate.day),
      maxDateTime: DateTime(selectedDate.year + 1),
      minDateTime: DateTime(selectedDate.year - 10),
      pickerTextStyle: const TextStyle(
        color: Color.fromARGB(255, 0, 0, 0),
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      onChange: (index) {},
      onSubmit: (index) {
        setState(() {
          waterReportCount = 0;
          foodReportCount = 0;
          tempReportCount = 0;
          humidityReportCount = 0;
        });
        setState(() {
          selectedDate = index;
          _saveSelectedDate(); // บันทึก selectedDate เมื่อเลือกวันที่ใหม่

          String path =
              "${widget.username}/controller/report/${selectedDate.year}/${selectedDate.month}/${selectedDate.day}";
          databaseReference.child(path).onValue.listen((event) {
            Map<dynamic, dynamic>? reportData =
                event.snapshot.value as Map<dynamic, dynamic>?;
            if (reportData != null) {
              int waterCount = 0;
              int foodCount = 0;
              int tempCount = 0;
              int humidityCount = 0;

              if (reportData['water_report'] != null) {
                reportData['water_report'].forEach((key, value) {
                  waterCount += int.parse(value.toString());
                });
              }
              if (reportData['food_report'] != null) {
                reportData['food_report'].forEach((key, value) {
                  foodCount += int.parse(value.toString());
                });
              }
              if (reportData['temp_report'] != null) {
                reportData['temp_report'].forEach((key, value) {
                  tempCount += int.parse(value.toString());
                });
              }
              if (reportData['humidity_report'] != null) {
                reportData['humidity_report'].forEach((key, value) {
                  humidityCount += int.parse(value.toString());
                });
              }

              setState(() {
                waterReportCount = waterCount;
                foodReportCount = foodCount;
                tempReportCount = tempCount;
                humidityReportCount = humidityCount;
              });
              _saveReportCounts(); // บันทึกค่า report counts ใหม่
            } else {
              setState(() {
                waterReportCount = 0;
                foodReportCount = 0;
                tempReportCount = 0;
                humidityReportCount = 0;
              });
              _saveReportCounts(); // บันทึกค่า report counts ใหม่
            }
          });
        });
      },
      bottomPickerTheme: BottomPickerTheme.orange,
    ).show(context);
  }
}

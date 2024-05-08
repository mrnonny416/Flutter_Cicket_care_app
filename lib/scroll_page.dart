// ignore_for_file: camel_case_types
import 'package:cickets_app/pages/page1.dart';
import 'package:cickets_app/pages/page2.dart';
import 'package:cickets_app/pages/page3.dart';
import 'package:cickets_app/pages/page4.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class scrollPage extends StatefulWidget {
  final String username;
  const scrollPage({required this.username, Key? key}) : super(key: key);

  @override
  State<scrollPage> createState() => _scrollPage();
}

class _scrollPage extends State<scrollPage> {
  final _controller = PageController();
  String _fullName = "";
  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final localStorage = await SharedPreferences.getInstance();
    setState(() {
      _fullName = localStorage.getString('fullName') ?? "";
    });
  }

  Future<void> _removeUsername() async {
    final localStorage = await SharedPreferences.getInstance();

    await localStorage.remove('fullName');
    await localStorage.remove('username');
    await localStorage.remove('password');
    Navigator.pop(context);
  }

  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        // backgroundColor: Colors.deepPurple[200],
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  "assets/images/—Pngtree—modern yellow trend abstract background_1658293.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 15),
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  width: screenSize.width,
                  height: screenSize.height * 0.08,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "ระบบเลี้ยงจิ้งหรีด",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w900,
                          color: Color.fromARGB(255, 65, 111, 223),
                        ),
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(0, 33, 149, 243),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () {
                          _removeUsername();
                        },
                        icon: const Icon(CupertinoIcons.person_crop_square,
                            size: 40),
                        label: Text(
                          "$_fullName:logout",
                          style: const TextStyle(fontSize: 15),
                        ),
                      )
                    ],
                  )),
              Container(
                // padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                color: const Color.fromARGB(0, 0, 208, 255),
                child: SizedBox(
                  width: screenSize.width,
                  height: screenSize.height * 0.8,
                  child: PageView(
                    controller: _controller,
                    children: [
                      Page1(username: widget.username),
                      Page2(username: widget.username),
                      Page3(username: widget.username),
                      Page4(username: widget.username)
                    ],
                  ),
                ),
              ),
              Container(
                // padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                color: const Color.fromARGB(0, 11, 255, 92),
                child: SmoothPageIndicator(
                  controller: _controller,
                  count: 4,
                  effect: const ExpandingDotsEffect(
                    activeDotColor: Color.fromARGB(255, 255, 255, 255),
                    dotColor: Color.fromARGB(255, 255, 255, 255),
                    dotHeight: 15,
                    dotWidth: 15,
                    spacing: 16,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

// ignore_for_file: camel_case_types
import 'package:cickets_app/pages/page1.dart';
import 'package:cickets_app/pages/page2.dart';
import 'package:cickets_app/pages/page3.dart';
import 'package:cickets_app/pages/page4.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class scrollPage extends StatefulWidget {
  final String username;
  const scrollPage({required this.username, Key? key}) : super(key: key);

  @override
  State<scrollPage> createState() => _scrollPage();
}

class _scrollPage extends State<scrollPage> {
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.deepPurple[200],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              color: const Color.fromARGB(255, 126, 87, 194),
              width: screenSize.width,
              height: screenSize.height * 0.08,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "ระบบเลี้ยงจิ้งหลีด",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(0, 33, 149, 243),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () {},
                    icon:
                        const Icon(CupertinoIcons.person_crop_square, size: 40),
                    label: const Text(
                      "USER",
                      style: TextStyle(fontSize: 20),
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
              effect: ExpandingDotsEffect(
                activeDotColor: Colors.deepPurple,
                dotColor: Colors.deepPurple.shade100,
                dotHeight: 15,
                dotWidth: 15,
                spacing: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}

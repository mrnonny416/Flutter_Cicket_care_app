import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cickets_app/screens/signin_screen.dart';
import 'package:cickets_app/screens/signup_screen.dart';
import 'package:cickets_app/widgets/custom_scaffold.dart';
import 'package:cickets_app/widgets/welcome_button.dart';
import 'dart:developer' as developer;

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
  @override
  State<WelcomeScreen> createState() => _WelcomeScreen();
}

class _WelcomeScreen extends State<WelcomeScreen> {
  String _username = "";
  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final localStorage = await SharedPreferences.getInstance();
    setState(() {
      _username = localStorage.getString('username') ?? "";
    });
    developer.log("username : $_username");
    if (_username != "") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (e) => const SignInScreen(),
        ),
      );
    }
  }

  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: const Image(
                      image: AssetImage(
                        'assets/images/logo.png',
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  '\nระบบควบคุมสภาพแวดล้อมในกล่องเลี้ยงจิ้งหรีดด้วยอินเตอร์เน็ตของสรรพสิ่ง',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.brown,
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Text(
                  '\nEnvironmental control system in a cricket box using the Internet of Things',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.brown,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Flexible(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Row(
                children: [
                  Expanded(
                    child: WelcomeButton(
                      buttonText: 'Sign in',
                      onTap: SignInScreen(),
                      color: Colors.transparent,
                      textColor: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: WelcomeButton(
                      buttonText: 'Sign up',
                      onTap: SignUpScreen(),
                      color: Colors.white,
                      textColor: Colors.amber.shade800,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

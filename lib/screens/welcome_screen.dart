import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cickets_app/screens/signin_screen.dart';
import 'package:cickets_app/screens/signup_screen.dart';
import 'package:cickets_app/widgets/custom_scaffold.dart';
import 'package:cickets_app/widgets/welcome_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
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
                        'assets/images/ตราสัญลักษณ์_ราชมงคลล้านนา.png',
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

      /*child: Column(
        children: [
          Flexible(
            flex: 8,
            child: Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 25.0),
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'ระบบควบคุมสภาพแวดล้อมในกล่องเลี้ยงจิ้งหรีดด้วยอินเตอร์เน็ตของสรรพสิ่ง\n',
                          style: GoogleFonts.kanit(
                            fontSize: 30,
                            color: Colors.brown,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text:
                              '\nEnvironmental control system in a cricket box using the Internet of Things',
                          style: GoogleFonts.kanit(
                            fontSize: 20,
                            color: Colors.brown,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Row(
                children: [
                  const Expanded(
                    child: WelcomeButton(
                      buttonText: 'Sign in',
                      onTap: SignInScreen(),
                      color: Colors.transparent,
                      textColor: Colors.brown,
                    ),
                  ),
                  Expanded(
                    child: WelcomeButton(
                      buttonText: 'Sign up',
                      onTap: const SignUpScreen(),
                      color: Colors.white,
                      textColor: Colors.brown,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),*/
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care_app/view/login_screen.dart';

class StartScreen3 extends StatefulWidget {
  const StartScreen3({super.key});

  @override
  State<StartScreen3> createState() => _StartScreen3State();
}

class _StartScreen3State extends State<StartScreen3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // fit: StackFit.expand,
        // clipBehavior: Clip.none,
        children: [
          Image.asset(
            'assets/images/start_screen_3.png',
            fit: BoxFit.fitHeight,
          ),
          Column(
            children: [
              const Expanded(child: SizedBox()),
              Expanded(
                child: Container(
                  // height: MediaQuery.sizeOf(context).height / 2,
                  // width: MediaQuery.sizeOf(context).width,
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.9),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(27),
                          topRight: Radius.circular(27))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 8.76),
                            height: 6.57,
                            width: 17.51,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromRGBO(224, 224, 225, 1)),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(3.28))),
                          ),
                          Container(
                            height: 6.57,
                            width: 17.51,
                            margin: const EdgeInsets.only(right: 8.76),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromRGBO(224, 224, 225, 1)),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(3.28))),
                          ),
                          Container(
                            height: 6.57,
                            width: 17.51,
                            decoration: const BoxDecoration(
                                color: Color.fromRGBO(60, 60, 60, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3.28))),
                          ),
                        ],
                      ),
                      Text("We provide",
                          style: GoogleFonts.fredoka(
                            textStyle: const TextStyle(
                                color: Color.fromRGBO(20, 20, 21, 1),
                                fontSize: 32,
                                fontWeight: FontWeight.w600),
                          )),
                      Container(
                        alignment: Alignment.center,
                        height: 55,
                        child: Text(
                            "24hrs health tracking & health \n                   updates",
                            style: GoogleFonts.fredoka(
                              textStyle: const TextStyle(
                                  color: Color.fromRGBO(161, 161, 161, 1),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            )),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 55,
                        child: Text("On time feeding\n       updates",
                            style: GoogleFonts.fredoka(
                              textStyle: const TextStyle(
                                  color: Color.fromRGBO(161, 161, 161, 1),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            )),
                      ),
                      Container(
                        height: 52.54,
                        width: 300,
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(245, 146, 69, 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.76))),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const SizedBox(
                              width: 100,
                            ),
                            Text("Get Started",
                                style: GoogleFonts.fredoka(
                                  textStyle: const TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 0.9),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                )),
                            const SizedBox(
                              width: 50,
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                              color: Color.fromRGBO(255, 255, 255, 0.9),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account? ",
                              style: GoogleFonts.fredoka(
                                textStyle: const TextStyle(
                                    color: Color.fromRGBO(161, 161, 161, 1),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              )),
                          GestureDetector(
                            onTap: () {
                              log("Login tapped");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Loginscreen(),
                                  ));
                            },
                            child: Text("Login ",
                                style: GoogleFonts.fredoka(
                                  textStyle: const TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

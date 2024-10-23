import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care_app/view/get_startscreen_3.dart';

class get_startscreen_2 extends StatefulWidget {
  const get_startscreen_2({super.key});

  @override
  State<get_startscreen_2> createState() => _get_startscreen_2State();
}

class _get_startscreen_2State extends State<get_startscreen_2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Image.asset('assets/images/start_screen_2.png'),
          Positioned(
            top: MediaQuery.sizeOf(context).height / 2,
            child: Container(
              height: MediaQuery.sizeOf(context).height / 2,
              width: MediaQuery.sizeOf(context).width,
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0.9),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(27),
                      topRight: Radius.circular(27))),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: 20.72,
                    left: MediaQuery.sizeOf(context).width / 2.4,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 8.76),
                          height: 6.57,
                          width: 17.51,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromRGBO(224, 224, 225, 1)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3.28))),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 8.76),
                          height: 6.57,
                          width: 17.51,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(60, 60, 60, 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3.28))),
                        ),
                        Container(
                          height: 6.57,
                          width: 17.51,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromRGBO(224, 224, 225, 1)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3.28))),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 35,
                    left: MediaQuery.sizeOf(context).width / 2.35,
                    child: Text("Now !",
                        style: GoogleFonts.fredoka(
                          textStyle: TextStyle(
                              color: Color.fromRGBO(20, 20, 21, 1),
                              fontSize: 32,
                              fontWeight: FontWeight.w600),
                        )),
                  ),
                  Positioned(
                    top: 90,
                    left: MediaQuery.sizeOf(context).width / 15,
                    child: Container(
                      alignment: Alignment.center,
                      height: 55,
                      child: Text(
                          "      One tap for foods, accessories,\nhealth care products & digital gadgets",
                          style: GoogleFonts.fredoka(
                            textStyle: TextStyle(
                                color: Color.fromRGBO(161, 161, 161, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          )),
                    ),
                  ),
                  Positioned(
                    top: 150,
                    left: MediaQuery.sizeOf(context).width / 4,
                    child: Container(
                      alignment: Alignment.center,
                      height: 55,
                      child: Text("Grooming & boarding",
                          style: GoogleFonts.fredoka(
                            textStyle: TextStyle(
                                color: Color.fromRGBO(161, 161, 161, 1),
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          )),
                    ),
                  ),
                  Positioned(
                    top: 200,
                    left: MediaQuery.sizeOf(context).width / 14,
                    child: Container(
                      alignment: Alignment.center,
                      height: 55,
                      child: Text("Easy & best consultation bookings",
                          style: GoogleFonts.fredoka(
                            textStyle: TextStyle(
                                color: Color.fromRGBO(161, 161, 161, 1),
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        height: 52.54,
        width: MediaQuery.sizeOf(context).width,
        margin: EdgeInsets.only(left: 50, right: 15, bottom: 30),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => get_startscreen_3(),
                ));
          },
          backgroundColor: Color.fromRGBO(245, 146, 69, 1),
          child: Row(
            children: [
              SizedBox(
                width: 130,
              ),
              Text("Next",
                  style: GoogleFonts.fredoka(
                    textStyle: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.9),
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  )),
              SizedBox(
                width: 90,
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15,
                color: Color.fromRGBO(255, 255, 255, 0.9),
              )
            ],
          ),
        ),
      ),
    );
  }
}

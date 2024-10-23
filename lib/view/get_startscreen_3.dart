import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care_app/view/login.dart';

class get_startscreen_3 extends StatefulWidget {
  const get_startscreen_3({super.key});

  @override
  State<get_startscreen_3> createState() => _get_startscreen_3State();
}

class _get_startscreen_3State extends State<get_startscreen_3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Image.asset('assets/images/start_screen_3.png'),
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
                // fit: StackFit.expand,
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
                          height: 6.57,
                          width: 17.51,
                          margin: EdgeInsets.only(right: 8.76),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromRGBO(224, 224, 225, 1)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3.28))),
                        ),
                        Container(
                          height: 6.57,
                          width: 17.51,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(60, 60, 60, 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3.28))),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 45,
                    left: MediaQuery.sizeOf(context).width / 3.3,
                    child: Text("We provide",
                        style: GoogleFonts.fredoka(
                          textStyle: TextStyle(
                              color: Color.fromRGBO(20, 20, 21, 1),
                              fontSize: 32,
                              fontWeight: FontWeight.w600),
                        )),
                  ),
                  Positioned(
                    top: 105,
                    left: MediaQuery.sizeOf(context).width / 9,
                    child: Container(
                      alignment: Alignment.center,
                      height: 55,
                      child: Text(
                          "24hrs health tracking & health \n                   updates",
                          style: GoogleFonts.fredoka(
                            textStyle: TextStyle(
                                color: Color.fromRGBO(161, 161, 161, 1),
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          )),
                    ),
                  ),
                  Positioned(
                    top: 190,
                    left: MediaQuery.sizeOf(context).width / 3.5,
                    child: Container(
                      alignment: Alignment.center,
                      height: 55,
                      child: Text("On time feeding\n       updates",
                          style: GoogleFonts.fredoka(
                            textStyle: TextStyle(
                                color: Color.fromRGBO(161, 161, 161, 1),
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          )),
                    ),
                  ),
                  Positioned(
                    top: 330,
                    left: MediaQuery.sizeOf(context).width / 4.8,
                    child: Container(
                      alignment: Alignment.center,
                      height: 55,
                      child: Row(
                        children: [
                          Text("Already have an account? ",
                              style: GoogleFonts.fredoka(
                                textStyle: TextStyle(
                                    color: Color.fromRGBO(161, 161, 161, 1),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              )),
                          GestureDetector(
                            onTap: () {
                              debugPrint("Login tapped");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => login_screen(),
                                  ));
                            },
                            child: Text("Login ",
                                style: GoogleFonts.fredoka(
                                  textStyle: TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                )),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        height: 52.54,
        width: MediaQuery.sizeOf(context).width,
        margin: EdgeInsets.only(left: 50, right: 15, bottom: 50),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Color.fromRGBO(245, 146, 69, 1),
          child: Row(
            children: [
              SizedBox(
                width: 90,
              ),
              Text("Get Started",
                  style: GoogleFonts.fredoka(
                    textStyle: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.9),
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  )),
              SizedBox(
                width: 70,
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

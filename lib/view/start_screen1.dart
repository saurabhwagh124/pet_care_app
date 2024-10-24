import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care_app/view/start_screen2.dart';

class StartScreen1 extends StatefulWidget {
  const StartScreen1({super.key});

  @override
  State<StartScreen1> createState() => _StartScreen1State();
}

class _StartScreen1State extends State<StartScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Image.asset('assets/images/start_screen_1.png'),
          Positioned(
            top: MediaQuery.sizeOf(context).height / 2,
            child: Container(
              height: MediaQuery.sizeOf(context).height / 2,
              width: MediaQuery.sizeOf(context).width,
              decoration: const BoxDecoration(color: Color.fromRGBO(255, 255, 255, 0.9), borderRadius: BorderRadius.only(topLeft: Radius.circular(27), topRight: Radius.circular(27))),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: 20.72,
                    left: MediaQuery.sizeOf(context).width / 2.4,
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 8.76),
                          height: 6.57,
                          width: 17.51,
                          decoration: const BoxDecoration(color: Color.fromRGBO(60, 60, 60, 1), borderRadius: BorderRadius.all(Radius.circular(3.28))),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 8.76),
                          height: 6.57,
                          width: 17.51,
                          decoration: BoxDecoration(border: Border.all(color: const Color.fromRGBO(224, 224, 225, 1)), borderRadius: const BorderRadius.all(Radius.circular(3.28))),
                        ),
                        Container(
                          height: 6.57,
                          width: 17.51,
                          decoration: BoxDecoration(border: Border.all(color: const Color.fromRGBO(224, 224, 225, 1)), borderRadius: const BorderRadius.all(Radius.circular(3.28))),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 40.78,
                    left: MediaQuery.sizeOf(context).width / 3.2,
                    child: SizedBox(height: 126, width: 140, child: Image.asset("assets/images/Logo.png")),
                  ),
                  Positioned(
                    top: 170,
                    left: MediaQuery.sizeOf(context).width / 2.6,
                    child: Text("Hello!!",
                        style: GoogleFonts.fredoka(
                          textStyle: const TextStyle(color: Color.fromRGBO(20, 20, 21, 1), fontSize: 32, fontWeight: FontWeight.w600),
                        )),
                  ),
                  Positioned(
                    top: 220,
                    left: MediaQuery.sizeOf(context).width / 6.5,
                    child: Container(
                      alignment: Alignment.center,
                      height: 55,
                      child: Text("Sit back and relax we’ll take\n    care of your pet needs",
                          style: GoogleFonts.fredoka(
                            textStyle: const TextStyle(color: Color.fromRGBO(161, 161, 161, 1), fontSize: 20, fontWeight: FontWeight.w500),
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
        margin: const EdgeInsets.only(left: 50, right: 15, bottom: 30),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StartScreen2(),
                ));
          },
          backgroundColor: const Color.fromRGBO(245, 146, 69, 1),
          child: Row(
            children: [
              const SizedBox(
                width: 130,
              ),
              Text("Next",
                  style: GoogleFonts.fredoka(
                    textStyle: const TextStyle(color: Color.fromRGBO(255, 255, 255, 0.9), fontSize: 20, fontWeight: FontWeight.w700),
                  )),
              const SizedBox(
                width: 90,
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15,
                opticalSize: 10,
                color: Color.fromRGBO(255, 255, 255, 0.9),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care_app/view/forgot_password.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          SizedBox(width: double.maxFinite, height: double.maxFinite),
          Image.asset(
            "assets/images/login bg.png",
            fit: BoxFit.cover,
          ),
          Positioned(
            top: -300,
            left: 130,
            child: CircleAvatar(
              radius: 185,
              backgroundColor: Color.fromRGBO(248, 174, 31, 0.97),
            ),
          ),
          Positioned(
            top: -220,
            left: 270,
            child: CircleAvatar(
              radius: 185,
              backgroundColor: Color.fromRGBO(245, 146, 69, 1),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.maxFinite,
                ),
                Image.asset(
                  "assets/images/Logo.png",
                  height: 225,
                ),
                Container(
                  height: 45,
                  width: 300,
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "Email Address",
                        labelStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(166, 166, 166, 1),
                        ),
                        prefixIcon: Icon(Icons.email_rounded),
                        prefixIconColor: Color.fromRGBO(166, 166, 166, 1),
                        filled: true,
                        fillColor: Color.fromRGBO(212, 212, 212, 1),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 45,
                  width: 300,
                  child: TextFormField(
                    obscureText: true,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(166, 166, 166, 1),
                        ),
                        prefixIcon: Icon(Icons.lock_outlined),
                        prefixIconColor: Color.fromRGBO(166, 166, 166, 1),
                        filled: true,
                        fillColor: Color.fromRGBO(212, 212, 212, 1),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPassword(),
                            ));
                      },
                      child: Text("Forgot Password?",
                          style: GoogleFonts.fredoka(
                            textStyle: const TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1),
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          )),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(245, 146, 69, 1),
                          minimumSize: Size(double.infinity, 50)),
                      child: Text("Login",
                          style: GoogleFonts.fredoka(
                            textStyle: const TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontSize: 25,
                                fontWeight: FontWeight.w500),
                          ))),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text("Or connect with",
                    style: GoogleFonts.fredoka(
                      textStyle: const TextStyle(
                          color: Color.fromRGBO(116, 112, 112, 1),
                          fontSize: 25,
                          fontWeight: FontWeight.w400),
                    )),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 25, right: 25, bottom: 20),
                  child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.g_mobiledata),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(245, 146, 69, 1),
                          minimumSize: Size(double.infinity, 50)),
                      label: Text("Login With Google",
                          style: GoogleFonts.fredoka(
                            textStyle: const TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          ))),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 25, right: 25, bottom: 20),
                  child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.facebook),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(245, 146, 69, 1),
                          minimumSize: Size(double.infinity, 50)),
                      label: Text("Login With Facebook",
                          style: GoogleFonts.fredoka(
                            textStyle: const TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          ))),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 25, right: 25, bottom: 25),
                  child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.apple,
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(245, 146, 69, 1),
                          minimumSize: Size(double.infinity, 50)),
                      label: Text("Login With Apple",
                          style: GoogleFonts.fredoka(
                            textStyle: const TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          ))),
                ),
                // const SizedBox(
                //   height: 100,
                // ),
                Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(248, 174, 31, 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.copyright,
                        color: Colors.white,
                        size: 12.48,
                      ),
                      Text(" All Rights Reserved to Pixel Posse  - 2024",
                          style: GoogleFonts.fredoka(
                            textStyle: const TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontSize: 9,
                                fontWeight: FontWeight.w400),
                          )),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

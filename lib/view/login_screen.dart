import 'package:flutter/material.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // fit: StackFit.expand,
        children: [
          SizedBox(
            width: double.maxFinite,
          ),
          Image.asset("assets/images/login bg.png"),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.maxFinite,
              ),
              Image.asset(
                "assets/images/Logo.png",
                height: 225,
              ),
              TextFormField(
                decoration: InputDecoration(border: InputBorder.none),
              )
            ],
          )
        ],
      ),
    );
  }
}

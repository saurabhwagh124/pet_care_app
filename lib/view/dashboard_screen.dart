import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Text(
          "Hey Saurabh Wagh, ",
          style: GoogleFonts.fredoka(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            // height: 62,
            // width: 62,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Image.asset('assets/images/Logo.png'),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 45, right: 17, left: 17),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: const [BoxShadow(offset: Offset(0, 1), blurRadius: 3.5, color: Color.fromRGBO(0, 0, 0, 0.20))]),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 26,
                            child: Image.asset('assets/images/pawIcon.png'),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "My Pets",
                            style: GoogleFonts.fredoka(fontWeight: FontWeight.w700, fontSize: 20),
                          ),
                          const Spacer()
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 21, right: 21),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 90,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                clipBehavior: Clip.hardEdge,
                                child: Image.asset('assets/images/puppy1.png'),
                              ),
                              const Text(
                                "Pomy",
                                style: TextStyle(fontSize: 15, color: Colors.grey),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: 90,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                clipBehavior: Clip.hardEdge,
                                child: Image.asset('assets/images/rabbit1.png'),
                              ),
                              const Text(
                                "Fixi",
                                style: TextStyle(fontSize: 15, color: Colors.grey),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: 90,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                clipBehavior: Clip.hardEdge,
                                child: Image.asset(
                                  'assets/images/cat1.png',
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              const Text(
                                "Trix",
                                style: TextStyle(fontSize: 15, color: Colors.grey),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: const [BoxShadow(offset: Offset(0, 1), blurRadius: 3.5, color: Color.fromRGBO(0, 0, 0, 0.20))]),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 25,
                          child: Image.asset('assets/images/petStatusIcon.png'),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Pet Status",
                          style: GoogleFonts.fredoka(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage('assets/images/puppy1.png'),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Health",
                                  style: TextStyle(fontSize: 14, color: Colors.black),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  height: 10,
                                  width: 60,
                                  child: LinearProgressIndicator(
                                    backgroundColor: Colors.grey[300],
                                    value: 0.8,
                                    color: Colors.greenAccent,
                                  ),
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                const Text(
                                  "80%",
                                  style: TextStyle(fontSize: 14, color: Colors.greenAccent),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Food",
                                  style: TextStyle(fontSize: 14, color: Colors.black),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  height: 10,
                                  width: 60,
                                  child: LinearProgressIndicator(
                                    backgroundColor: Colors.grey[300],
                                    value: 0.5,
                                    color: Colors.pinkAccent,
                                  ),
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                const Text(
                                  "50%",
                                  style: TextStyle(fontSize: 14, color: Colors.pinkAccent),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Mood",
                                  style: TextStyle(fontSize: 14, color: Colors.black),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  height: 10,
                                  width: 60,
                                  child: LinearProgressIndicator(
                                    backgroundColor: Colors.grey[300],
                                    value: 0.8,
                                    color: Colors.pinkAccent,
                                  ),
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                const Text(
                                  "80%",
                                  style: TextStyle(fontSize: 14, color: Colors.pinkAccent),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage('assets/images/rabbit1.png'),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Health",
                                  style: TextStyle(fontSize: 14, color: Colors.black),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  height: 10,
                                  width: 60,
                                  child: LinearProgressIndicator(
                                    backgroundColor: Colors.grey[300],
                                    value: 0.8,
                                    color: Colors.greenAccent,
                                  ),
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                const Text(
                                  "80%",
                                  style: TextStyle(fontSize: 14, color: Colors.greenAccent),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Food",
                                  style: TextStyle(fontSize: 14, color: Colors.black),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  height: 10,
                                  width: 60,
                                  child: LinearProgressIndicator(
                                    backgroundColor: Colors.grey[300],
                                    value: 0.5,
                                    color: Colors.pinkAccent,
                                  ),
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                const Text(
                                  "50%",
                                  style: TextStyle(fontSize: 14, color: Colors.pinkAccent),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Mood",
                                  style: TextStyle(fontSize: 14, color: Colors.black),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  height: 10,
                                  width: 60,
                                  child: LinearProgressIndicator(
                                    backgroundColor: Colors.grey[300],
                                    value: 0.8,
                                    color: Colors.pinkAccent,
                                  ),
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                const Text(
                                  "80%",
                                  style: TextStyle(fontSize: 14, color: Colors.pinkAccent),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage('assets/images/cat1.png'),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Health",
                                  style: TextStyle(fontSize: 14, color: Colors.black),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  height: 10,
                                  width: 60,
                                  child: LinearProgressIndicator(
                                    backgroundColor: Colors.grey[300],
                                    value: 0.8,
                                    color: Colors.greenAccent,
                                  ),
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                const Text(
                                  "80%",
                                  style: TextStyle(fontSize: 14, color: Colors.greenAccent),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Food",
                                  style: TextStyle(fontSize: 14, color: Colors.black),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  height: 10,
                                  width: 60,
                                  child: LinearProgressIndicator(
                                    backgroundColor: Colors.grey[300],
                                    value: 0.5,
                                    color: Colors.pinkAccent,
                                  ),
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                const Text(
                                  "50%",
                                  style: TextStyle(fontSize: 14, color: Colors.pinkAccent),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Mood",
                                  style: TextStyle(fontSize: 14, color: Colors.black),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  height: 10,
                                  width: 60,
                                  child: LinearProgressIndicator(
                                    backgroundColor: Colors.grey[300],
                                    value: 0.8,
                                    color: Colors.pinkAccent,
                                  ),
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                const Text(
                                  "80%",
                                  style: TextStyle(fontSize: 14, color: Colors.pinkAccent),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    const Row(
                      children: [
                        Spacer(),
                        Text(
                          "Check Pets >",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: const [BoxShadow(offset: Offset(0, 1), blurRadius: 3.5, color: Color.fromRGBO(0, 0, 0, 0.20))]),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 25,
                          child: Image.asset('assets/images/petFoodIcon.png'),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Pet Food",
                          style: GoogleFonts.fredoka(fontSize: 20, fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: const [BoxShadow(offset: Offset(0, 1), blurRadius: 3.5, color: Color.fromRGBO(0, 0, 0, 0.20))]),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 67,
                            child: Image.asset('assets/images/josiDogFood.png'),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Josi Dog Master Mix\n 900g",
                            style: GoogleFonts.fredoka(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          Container(
                            margin: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                            padding: const EdgeInsets.all(5),
                            child: const Icon(
                              Icons.shopping_bag_outlined,
                              color: Colors.white,
                              size: 30,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: const [BoxShadow(offset: Offset(0, 1), blurRadius: 3.5, color: Color.fromRGBO(0, 0, 0, 0.20))]),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 67,
                            child: Image.asset('assets/images/HappyDogFood.png'),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Happy Dog Profi Mix\n 500g",
                            style: GoogleFonts.fredoka(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          Container(
                            margin: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                            padding: const EdgeInsets.all(5),
                            child: const Icon(
                              Icons.shopping_bag_outlined,
                              color: Colors.white,
                              size: 30,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.black,
        selectedIndex: 0,
        destinations: const [
          Icon(
            Icons.house_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.location_pin,
            color: Colors.white,
          ),
          Icon(
            Icons.devices,
            color: Colors.white,
          ),
          Icon(
            Icons.pets,
            color: Colors.white,
          )
        ],
        indicatorColor: Colors.red,
        indicatorShape: Border.all(color: Colors.red),
      ),
    );
  }
}

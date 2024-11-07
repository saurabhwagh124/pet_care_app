import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care_app/view/bookappointmentscreen.dart';

class VeterinaryDoctor extends StatefulWidget {
  const VeterinaryDoctor({super.key});

  @override
  State<VeterinaryDoctor> createState() => _VeterinaryDoctorState();
}

class _VeterinaryDoctorState extends State<VeterinaryDoctor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Colors.white,
                )),
            title: const Text('Dr. Rafeeqa'),
            centerTitle: true,
            titleTextStyle: GoogleFonts.fredoka(
                fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
            backgroundColor: Color.fromRGBO(248, 174, 31, 1)),
        body: Column(
          children: [
            Image.asset("assets/images/VeterinaryDoctor.png"),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 175,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.15),
                        offset: Offset(0, 6),
                        blurRadius: 44)
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(26))),
              child: Stack(
                children: [
                  Text(
                    'Dr. Rafeeqa',
                    style: GoogleFonts.fredoka(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Positioned(
                    top: 35,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bachelor of Veterinary Science',
                            style: GoogleFonts.fredoka(
                              fontSize: 17,
                              color: Color.fromRGBO(6, 78, 87, 1),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                '5.0',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                              Icon(Icons.star, color: Colors.yellow),
                              Icon(Icons.star, color: Colors.yellow),
                              Icon(Icons.star, color: Colors.yellow),
                              Icon(Icons.star, color: Colors.yellow),
                              Icon(Icons.star, color: Colors.yellow),
                              SizedBox(width: 8),
                              Text(
                                '(100 reviews)',
                                style: GoogleFonts.poppins(
                                    color: Color.fromRGBO(134, 136, 137, 1),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 12,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Monday - Friday at 8:00 am - 5:00 pm',
                                style: GoogleFonts.fredoka(
                                    fontSize: 10,
                                    color: Color.fromRGBO(166, 166, 166, 1)),
                              ),
                              SizedBox(width: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    size: 10,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    '2.5 km',
                                    style: GoogleFonts.fredoka(
                                        textStyle: TextStyle(
                                            fontSize: 11,
                                            color: Color.fromRGBO(
                                                166, 166, 166, 1))),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Text('1000 PKR for an Appointment',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ))
                        ]),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Text(
                'Dr. Shehan, one of the most skilled and experienced veterinarians and the owner of the most convenient animal clinic "Petz & Vetz". Our paradise is situated in the heart of the town with a pleasant environment. We are ready to treat your beloved doggos & puppers with love and involvement. Book the appointment now!',
                style: GoogleFonts.fredoka(fontSize: 12),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  'Recommended For: Bella',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => bookAppoinment(),
                    ));
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(245, 146, 69, 1),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: [
                    SizedBox(
                      width: 75,
                    ),
                    Text(
                      "Book an Appointment",
                      style: GoogleFonts.fredoka(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    SizedBox(
                      width: 35,
                    ),
                    ImageIcon(
                      AssetImage(
                        "assets/images/deadlineIcon.png",
                      ),
                      color: Colors.white,
                      size: 18,
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

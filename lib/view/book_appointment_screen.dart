import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class BookAppoinmentScreen extends StatefulWidget {
  const BookAppoinmentScreen({super.key});

  @override
  State<BookAppoinmentScreen> createState() => _BookAppoinmentScreenState();
}

class _BookAppoinmentScreenState extends State<BookAppoinmentScreen> {
  DateTime selectedDate = DateTime(2024, 7, 27);
  String selectedTime = '11:30';

  Widget _buildTimeButton(String time) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTime = time;
        });
      },
      child: Container(
        width: 130,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: selectedTime == time ? Colors.orange : Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.25), offset: Offset(0, 4), blurRadius: 4)]),
        child: Text(
          time,
          style: GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.w600, color: selectedTime == time ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.white,
              )),
          title: const Text('Dr. Rafeeqa'),
          centerTitle: true,
          titleTextStyle: GoogleFonts.fredoka(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
          backgroundColor: const Color.fromRGBO(248, 174, 31, 1)),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose a Date',
              style: GoogleFonts.fredoka(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Container(
              height: 300,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(color: Color.fromRGBO(19, 10, 46, 0.03), offset: Offset(0, 3), blurRadius: 14),
                    BoxShadow(color: Color.fromRGBO(19, 10, 46, 0.13), offset: Offset(0, 1), blurRadius: 3),
                  ],
                  borderRadius: BorderRadius.circular(12)),
              child: CalendarDatePicker(
                initialDate: selectedDate,
                firstDate: DateTime(2024, 1),
                lastDate: DateTime(2024, 12),
                onDateChanged: (date) {
                  setState(() {
                    selectedDate = date;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Pick a Time',
              style: GoogleFonts.fredoka(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 50,
              runSpacing: 15,
              children: [
                _buildTimeButton('9:30'),
                _buildTimeButton('10:30'),
                _buildTimeButton('11:30'),
                _buildTimeButton('3:30'),
                _buildTimeButton('4:30'),
                _buildTimeButton('5:30'),
              ],
            ),
            GestureDetector(
              // onTap: () {
              //   Get.to(() => BookAppoinmentScreen());
              // },
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: const Color.fromRGBO(245, 146, 69, 1), borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 75,
                    ),
                    Text(
                      "Book an Appointment",
                      style: GoogleFonts.fredoka(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                    const SizedBox(
                      width: 35,
                    ),
                    const ImageIcon(
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
        ),
      ),
    );
  }
}

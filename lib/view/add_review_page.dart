import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddReviewPage extends StatefulWidget {
  const AddReviewPage({super.key});

  @override
  State<AddReviewPage> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  double _rating = 0.0;
  final TextEditingController _reviewController = TextEditingController();

  void _submitReview() {
    if (_rating > 0 && _reviewController.text.isNotEmpty) {
      Navigator.pop(context, {
        'name': 'New User', // Replace with actual user data if available
        'timeAgo': 'Just now',
        'rating': _rating,
        'review': _reviewController.text,
        'avatarUrl': 'https://via.placeholder.com/150',
      });
    } else {
      // Show an error or validation if needed
      print("Please provide a rating and review.");
    }
  }

  Widget _buildStar(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _rating = index + 1.0;
        });
      },
      child: Icon(
        Icons.star,
        color: index < _rating ? Colors.orange : Colors.grey,
        size: 40,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8AE1F),
        title: Text(
          'Add Review',
          style: GoogleFonts.fredoka(
            textStyle: const TextStyle(fontSize: 23, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context); // Custom back button behavior
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(
                    'assets/images/haylie.png',
                  ),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Haylie Aminoff',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Posting Publicly*',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text('Rate your experience',
                style: GoogleFonts.fredoka(
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                )),
            Row(
              children: List.generate(5, (index) => _buildStar(index)),
            ),
            const SizedBox(height: 24),
            Text(
              'Share more about your experience',
              style: GoogleFonts.fredoka(
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _reviewController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Share details of your own experience at this place',
                border: OutlineInputBorder(),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitReview,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text('Post Review',
                    style: GoogleFonts.fredoka(
                      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care_app/view/add_review_page.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  List<Map<String, dynamic>> reviews = [
    {
      'name': 'Saurabh Wagh',
      'timeAgo': 'Just now',
      'rating': 4.5,
      'review':
          'The thing I like best about COCO is the amount of time it has saved while trying to manage my three pets.',
      'avatarUrl': 'assets/images/rehan_shah.png',
    },
    {
      'name': 'Om Kalokhe',
      'timeAgo': '1 day ago',
      'rating': 4.5,
      'review': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'avatarUrl': 'assets/images/irfan_akram.png',
    },
    {
      'name': 'Shruti',
      'timeAgo': '2 days ago',
      'rating': 4.5,
      'review': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'avatarUrl': 'assets/images/arfa.png',
    },
  ];

  void _navigateToAddReviewPage() async {
    final newReview = await Get.to(() => const AddReviewPage());

    if (newReview != null) {
      setState(() {
        reviews.add(newReview);
      });
    }
  }

  double _calculateAverageRating() {
    if (reviews.isEmpty) return 0.0;
    double totalRating =
        reviews.fold(0.0, (sum, review) => sum + review['rating']);
    return totalRating / reviews.length;
  }

  @override
  Widget build(BuildContext context) {
    double averageRating = _calculateAverageRating();
    int reviewCount = reviews.length;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8AE1F),
        leading: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.white,
        ),
        title: Text(
          'Reviews',
          style: GoogleFonts.fredoka(
            textStyle: const TextStyle(
                fontSize: 23, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overall Rating Section
            Center(
              child: Column(
                children: [
                  Text(
                    averageRating.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(5, (index) {
                      return Icon(
                        index < averageRating.floor()
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.orange,
                        size: 24,
                      );
                    }),
                  ),
                  Text(
                    'Based on $reviewCount reviews',
                    style: GoogleFonts.fredoka(
                      textStyle:
                          const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Rating Breakdown
            Column(
              children: [
                ratingBar('Excellent', Colors.green, 0.9),
                ratingBar('Good', Colors.lightGreen, 0.7),
                ratingBar('Average', Colors.yellow, 0.5),
                ratingBar('Below Average', Colors.orange, 0.3),
                ratingBar('Poor', Colors.red, 0.1),
              ],
            ),
            const SizedBox(height: 16),
            // Individual Reviews
            ...reviews.map((review) {
              return ReviewCard(
                name: review['name'],
                timeAgo: review['timeAgo'],
                rating: review['rating'],
                review: review['review'],
                avatarUrl: review['avatarUrl'],
              );
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddReviewPage,
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget ratingBar(String label, Color color, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.fredoka(
                textStyle: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: LinearProgressIndicator(
              value: value,
              color: color,
              backgroundColor: Colors.grey.shade300,
            ),
          ),
        ],
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final String name;
  final String timeAgo;
  final double rating;
  final String review;
  final String avatarUrl;

  const ReviewCard({
    super.key,
    required this.name,
    required this.timeAgo,
    required this.rating,
    required this.review,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 2,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: avatarUrl.isNotEmpty
                  ? AssetImage(avatarUrl)
                  : const NetworkImage('https://via.placeholder.com/150'),
              radius: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.fredoka(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Text(
                    timeAgo,
                    style: GoogleFonts.fredoka(
                      textStyle:
                          const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < rating.floor() ? Icons.star : Icons.star_border,
                        color: Colors.orange,
                        size: 16,
                      );
                    }),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    review,
                    style: GoogleFonts.fredoka(
                      textStyle:
                          const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_care_app/model/gromming.dart';
import 'package:pet_care_app/utils/app_colors.dart';
import 'package:pet_care_app/utils/app_images.dart';

class GrommingCard extends StatefulWidget {
  GrommingCard({
    super.key,
  });

  @override
  State<GrommingCard> createState() => _GrommingCardState();
}

class _GrommingCardState extends State<GrommingCard> {
  List<Gromming> gromming = [
    Gromming(
      name: 'Comb and Collar',
      imageUrl: AppImages.combAndCollarImg,
      rating: 5.0,
      reviewCount: 100,
      isOpen: true,
      distance: 2.5,
      price: 100,
      hours: 'Monday - Friday at 8.00 am - 5.00 pm',
    ),
    Gromming(
      name: 'Comb and Collar',
      imageUrl: AppImages.combAndCollarImg,
      rating: 5.0,
      reviewCount: 100,
      isOpen: true,
      distance: 2.5,
      price: 100,
      hours: 'Monday - Friday at 8.00 am - 5.00 pm',
    ),
    Gromming(
      name: 'Comb and Collar',
      imageUrl: AppImages.combAndCollarImg,
      rating: 5.0,
      reviewCount: 100,
      isOpen: true,
      distance: 2.5,
      price: 100,
      hours: 'Monday - Friday at 8.00 am - 5.00 pm',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      height: 161.h,
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 1),
                blurRadius: 4,
                offset: Offset(0, 4))
          ],
          border: Border.all(),
          color: Colors.white,
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    gromming[0].imageUrl,
                    width: 60,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        gromming[0].name,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 10),
                          const SizedBox(width: 4),
                          Text(
                            '${gromming[0].rating} (${gromming[0].reviewCount} reviews)',
                            style: const TextStyle(
                                fontSize: 10, color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  gromming[0].isOpen ? 'OPEN' : 'CLOSED',
                  style: TextStyle(
                    color: gromming[0].isOpen ? Colors.green : Colors.red,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  '${gromming[0].distance} km',
                  style: const TextStyle(
                      fontSize: 10, color: AppColors.lightGreyText),
                ),
                const Spacer(),
                const Icon(Icons.attach_money, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text('${gromming[0].price.toStringAsFixed(0)}\$',
                    style: const TextStyle(
                        fontSize: 10, color: AppColors.lightGreyText)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.access_time, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  gromming[0].hours,
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

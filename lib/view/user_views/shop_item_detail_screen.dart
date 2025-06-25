import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // If you use screenutil
import 'package:pet_care_app/model/product.dart'; // Ensure this path is correct

class ShopItemDetailScreen extends StatelessWidget {
  final Product product;

  const ShopItemDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final discountedPrice = product.discountedPrice;
    final originalPrice = product.price;
    final hasDiscount = product.discount != null &&
        product.discount! > 0 &&
        discountedPrice != null &&
        originalPrice != null &&
        discountedPrice < originalPrice;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.itemName ?? 'Product Details'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 25.sp),
          onPressed: () =>
              Navigator.of(context).pop(), // Or Get.back() if using GetX
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w), // Use .w for width-based padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // --- Product Image ---
            if (product.photoUrl != null && product.photoUrl!.isNotEmpty)
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.network(
                    product.photoUrl!,
                    height: 250.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return SizedBox(
                        height: 250.h,
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 250.h,
                      color: Colors.grey[300],
                      child: Icon(Icons.broken_image,
                          size: 60.sp, color: Colors.grey[700]),
                    ),
                  ),
                ),
              )
            else
              Container(
                height: 250.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(Icons.image_not_supported,
                    size: 60.sp, color: Colors.grey[700]),
              ),
            SizedBox(height: 20.h),

            // --- Product Name ---
            Text(
              product.itemName ?? 'N/A',
              style: textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold, fontSize: 24.sp),
            ),
            SizedBox(height: 8.h),

            // --- Price ---
            Row(
              children: [
                Text(
                  hasDiscount
                      ? '₹${discountedPrice?.toStringAsFixed(0) ?? 'N/A'}' // Assuming price is integer
                      : '₹${originalPrice?.toStringAsFixed(0) ?? 'N/A'}',
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                    fontSize: 22.sp,
                  ),
                ),
                if (hasDiscount)
                  Padding(
                    padding: EdgeInsets.only(left: 8.w),
                    child: Text(
                      '₹${originalPrice?.toStringAsFixed(0) ?? ''}',
                      style: textTheme.titleMedium?.copyWith(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey[600],
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                if (hasDiscount && product.discount != null)
                  Padding(
                    padding: EdgeInsets.only(left: 8.w),
                    child: Text(
                      '(${product.discount}% off)',
                      style: textTheme.titleMedium?.copyWith(
                        color: Colors.red[600],
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16.h),

            // --- Description ---
            _buildSectionTitle(context, 'Description', fontSize: 18.sp),
            SizedBox(height: 6.h),
            Text(
              product.description ?? 'No description available.',
              style:
                  textTheme.bodyMedium?.copyWith(fontSize: 15.sp, height: 1.5),
            ),
            SizedBox(height: 16.h),

            // --- Other Details in a Card for better separation ---
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r)),
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow(context, 'Brand:', product.brand ?? 'N/A',
                        fontSize: 15.sp),
                    _buildDetailRow(
                        context, 'Category:', product.category ?? 'N/A',
                        fontSize: 15.sp),
                    if (product.recommendedFor != null &&
                        product.recommendedFor!.isNotEmpty)
                      _buildDetailRow(
                          context, 'Recommended For:', product.recommendedFor!,
                          fontSize: 15.sp),
                    if (product.reviewScore != null && product.reviewScore! > 0)
                      _buildReviewRow(context, product.reviewScore!,
                          product.noOfReviews ?? 0,
                          fontSize: 15.sp),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title,
      {double? fontSize}) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: fontSize ?? 18.sp, // Default if not provided
          ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value,
      {double? fontSize}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label ',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: fontSize ?? 16.sp,
                ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: fontSize ?? 16.sp,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewRow(
      BuildContext context, double reviewScore, int noOfReviews,
      {double? fontSize}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Text(
            'Rating: ',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: fontSize ?? 16.sp,
                ),
          ),
          Icon(Icons.star,
              color: Colors.amber, size: (fontSize ?? 16.sp) + 2.sp),
          Text(
            ' ${reviewScore.toStringAsFixed(1)}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: fontSize ?? 16.sp,
                ),
          ),
          if (noOfReviews > 0)
            Text(
              ' ($noOfReviews reviews)',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[700],
                    fontSize: (fontSize ?? 16.sp) - 2.sp,
                  ),
            ),
        ],
      ),
    );
  }
}

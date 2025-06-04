import 'package:flutter/material.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';

class StarRating extends StatelessWidget {
  final num rating; // Can be int, double, etc.
  final int maxRating;
  final Color filledColor;
  final Color unfilledColor;
  final double size;

  const StarRating({
    super.key,
    required this.rating,
    this.maxRating = 5,
    this.filledColor = AppColors.ratingColor,
    this.unfilledColor = AppColors.grey100,
    this.size = 17,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        children: List.generate(maxRating, (index) {
          IconData icon;
          Color color;

          if (rating >= index + 1) {
            // Full star
            icon = Icons.star;
            color = filledColor;
          } else if (rating > index) {
            // Partial star
            icon = Icons.star_half;
            color = filledColor;
          } else {
            // Empty star
            icon = Icons.star;
            color = unfilledColor;
          }

          return Icon(icon, color: color, size: size);
        }),
      ),
    );
  }
}



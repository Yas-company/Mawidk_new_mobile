import 'package:flutter/material.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';

class StarRating extends StatelessWidget {
  final int rating; // from 0 to 5
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
    return Directionality(textDirection:TextDirection.ltr,
      child: Row(
        children: List.generate(maxRating, (index) {
          return Icon(Icons.star,
            color: index < rating ? filledColor : unfilledColor,
            size: size,
          );
        }),
      ),
    );
  }
}

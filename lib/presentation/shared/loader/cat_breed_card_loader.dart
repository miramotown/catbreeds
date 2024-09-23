import 'package:catbreeds/app/configuration/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CatBreedCardLoader extends StatelessWidget {
  const CatBreedCardLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
          height: 450.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: AppColors.kBackgroundSecondaryWhite1),
        ).animate(
            onPlay: (controller) => controller.repeat())
            .shimmer(duration: 1200.ms, color: AppColors.kSecondaryGreen1)
    );
  }
}

import 'dart:developer';

import 'package:catbreeds/app/configuration/theme/app_colors.dart';
import 'package:catbreeds/app/configuration/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class CatBreedErrorCard extends StatelessWidget {

  final String error;

  const CatBreedErrorCard({
    super.key,
    required this.error
  });

  @override
  Widget build(BuildContext context) {

    log('ERROR: $error');

    String finalError = (error.contains('NOT_INTERNET_EXCEPTION'))
        ? 'Verifique su conexión e intentelo nuevamente' : 'Ha ocurrido un error en la solicitud';

    return Card(
        child: Container(
          height: 450.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: AppColors.kBackgroundSecondaryRed1),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Opps!!!', style: AppTextStyles.poppins28semiBoldTextPrimaryGreen1, textAlign: TextAlign.center,),
                const SizedBox(height: 20.0,),
                Text(finalError, style: AppTextStyles.poppins18semiBoldTextSecondaryGreen1, textAlign: TextAlign.center,),
              ],
            ),
          ),
        )
    );
  }
}

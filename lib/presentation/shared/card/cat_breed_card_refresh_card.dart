import 'dart:developer';

import 'package:catbreeds/app/configuration/theme/app_colors.dart';
import 'package:catbreeds/app/configuration/theme/app_text.dart';
import 'package:catbreeds/app/configuration/theme/app_text_styles.dart';
import 'package:catbreeds/presentation/providers/cat_breeds_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CatBreedCardRefreshCard extends ConsumerWidget {

  final int page;
  final int indexInPage;
  final bool isLoading;
  final String error;

  const CatBreedCardRefreshCard({
    super.key,
    required this.page,
    required this.indexInPage,
    required this.isLoading,
    required this.error
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    log('ERROR: $error');

    String finalError = (error.contains('NOT_INTERNET_EXCEPTION'))
        ? 'Su conexión es inestable, verifique' : 'Ha ocurrido un error al obtener la lista';

    return indexInPage == 0 ? Card(
        child: Container(
          height: 150.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: AppColors.kBackgroundSecondaryRed1),
          child: Center(
            child: Row(
              children: [
                const SizedBox(height: 20.0,),
                Text(finalError, style: AppTextStyles.poppins18semiBoldTextSecondaryGreen1, textAlign: TextAlign.center,),
                const SizedBox(height: 20.0,),
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                        ref.invalidate(listCatBreedsProvider(page));
                        return ref.read(listCatBreedsProvider(page).future);
                  },
                  child: const Text(AppText.kTextRetry),
                ),
                const SizedBox(height: 20.0,),
              ],
            ),
          ),
        )
    ) : const SizedBox.shrink();
  }
}

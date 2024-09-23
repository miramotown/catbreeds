import 'package:catbreeds/app/configuration/theme/app_colors.dart';
import 'package:catbreeds/app/configuration/theme/app_text.dart';
import 'package:catbreeds/app/configuration/theme/app_text_styles.dart';
import 'package:catbreeds/app/utils/image_util.dart';
import 'package:catbreeds/domain/entities/cat_breed_entity.dart';
import 'package:flutter/material.dart';

class CatBreedCard extends StatelessWidget {

  final CatBreedEntity catBreed;
  final void Function() onPressed;

  const CatBreedCard({
    super.key,
    required this.catBreed,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onPressed,
        child: SizedBox(
          height: 450.0,
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Hero(
                  tag: catBreed,
                  child: FadeInImage.assetNetwork(
                      image: catBreed.imagePath,
                      fit: BoxFit.cover,
                      placeholder: ImageUtil.getGifPath('cat_image_loader'),
                      placeholderFit: BoxFit.cover,
                      imageErrorBuilder: (context, obj, stacktrace){
                        return Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.not_interested_rounded,
                                  color: AppColors.kIconSecondaryRed1,
                                  size: 50.0,
                                ),
                                const SizedBox(height: 10.0,),
                                Text(AppText.kMessageImageNotFound,
                                  style: AppTextStyles.poppins18semiBoldTextSecondaryRed1,
                                ),
                              ],
                            )
                        );
                      },
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.kBackgroundSecondaryGreen1,
                            AppColors.kBackgroundSecondaryGreen1.withOpacity(0.0)
                          ],
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.flag, color: AppColors.kIconPrimaryGreen1,),
                              const SizedBox(width: 10.0,),
                              Text(catBreed.origin, style: AppTextStyles.poppins18semiBoldTextPrimaryGreen1,),
                              Expanded(child: Container()),
                              const Icon(Icons.more_horiz_rounded, color: AppColors.kIconPrimaryGreen1,),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(catBreed.name, style: AppTextStyles.poppins22semiBoldTextPrimaryYellow1,),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(12.0),
                          bottomRight: Radius.circular(12.0),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.kBackgroundPrimaryGreen1.withOpacity(0.0),
                            AppColors.kBackgroundPrimaryGreen1,
                          ],
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${AppText.kTextIntelligence}: ${catBreed.intelligence}', style: AppTextStyles.poppins22semiBoldTextPrimaryYellow1,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

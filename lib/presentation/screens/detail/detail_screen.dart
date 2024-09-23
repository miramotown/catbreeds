import 'package:catbreeds/app/configuration/theme/app_colors.dart';
import 'package:catbreeds/app/configuration/theme/app_text.dart';
import 'package:catbreeds/app/configuration/theme/app_text_styles.dart';
import 'package:catbreeds/app/utils/image_util.dart';
import 'package:catbreeds/domain/entities/cat_breed_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final CatBreedEntity catBreed = GoRouterState.of(context).extra as CatBreedEntity;

    return Scaffold(
      backgroundColor: AppColors.kBackgroundPrimaryGreen1,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2 + MediaQuery.of(context).viewPadding.top,
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
            Container(
              height: 100.0 + MediaQuery.of(context).viewPadding.top,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.kBackgroundPrimaryYellow1,
                      AppColors.kBackgroundPrimaryYellow1.withOpacity(0.0)
                    ],
                      stops: const [0.19, 1.0]
                  )
              ),
              child: Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
                child: Stack(
                  fit: StackFit.passthrough,
                  children: [
                    Center(child: Text(catBreed.name, style: AppTextStyles.poppins22semiBoldTextPrimaryGreen1,)),
                    Row(
                      children: [
                        BackButton(
                          onPressed: context.pop,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height / 2
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10.0,),
            Text(catBreed.description, style: AppTextStyles.poppins22semiBoldTextPrimaryYellow1,),
            const SizedBox(height: 12.0,),
            Text('Pais: ${catBreed.origin}', style: AppTextStyles.poppins18semiBoldTextSecondaryGreen1,),
            Text('Inteligencia: ${catBreed.intelligence}', style: AppTextStyles.poppins18semiBoldTextSecondaryGreen1,),
            Text('Adaptabilidad: ${catBreed.adaptability}', style: AppTextStyles.poppins18semiBoldTextSecondaryGreen1,),
            Text('Esperanza de vida: ${catBreed.lifeSpan}', style: AppTextStyles.poppins18semiBoldTextSecondaryGreen1,),
            const SizedBox(height: 20.0,),
            SizedBox(height: MediaQuery.of(context).viewPadding.bottom,),
          ],
        ),
      ),
    );
  }
}

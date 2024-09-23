import 'dart:developer';

import 'package:catbreeds/app/configuration/theme/app_colors.dart';
import 'package:catbreeds/app/configuration/theme/app_text.dart';
import 'package:catbreeds/app/configuration/theme/app_text_styles.dart';
import 'package:catbreeds/domain/entities/cat_breed_entity.dart';
import 'package:catbreeds/presentation/providers/cat_breeds_provider.dart';
import 'package:catbreeds/presentation/screens/home/cat_breeds_search_delegate.dart';
import 'package:catbreeds/presentation/shared/images/splash_image.dart';
import 'package:catbreeds/presentation/shared/loader/cat_breed_card_loader.dart';
import 'package:catbreeds/presentation/shared/card/cat_breed_card.dart';
import 'package:catbreeds/presentation/shared/card/cat_breed_error_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {

  @override
  Widget build(BuildContext context) {

    int pageSize = 10;

    return Scaffold(
        backgroundColor: AppColors.kBackgroundPrimaryGreen1,
        appBar: AppBar(
          backgroundColor: AppColors.kSecondaryWhite1,
          leading: const Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: SplashImage(
              height: 35.0,
              width: 35.0,
            ),
          ),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(AppText.kTitleHome1, style: AppTextStyles.poppins22semiBoldTextPrimaryGreen1,),
              Text(AppText.kTitleHome2, style: AppTextStyles.poppins22semiBoldTextPrimaryYellow1,),
            ],
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () async{
                  CatBreedEntity? catBreedResult = await showSearch(
                      context: context,
                      delegate: CatBreedsSearchDelegate()
                  );
                  if(catBreedResult != null){
                    if(context.mounted){
                      context.push('/detail', extra: catBreedResult);
                    }
                  }
                },
                icon: const Icon(
                  Icons.search_rounded,
                  size: 30.0,
                )
            )
          ],
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(20.0),
            itemBuilder: (context, index) {
              final page = index ~/ pageSize + 1;
              final indexInPage = index % pageSize;
              log('index: $index, page: $page, indexInPage: $indexInPage');
              final AsyncValue<List<CatBreedEntity>> responseAsync = ref.watch(listCatBreedsProvider(page));
              return responseAsync.when(
                  data: (catBreed){
                    if (indexInPage >= catBreed.length) {
                      return null;
                    }
                    final catBreedCard = catBreed[indexInPage];
                    return CatBreedCard(
                      catBreed: catBreedCard,
                      onPressed: () => context.push('/detail', extra: catBreedCard),
                    );
                  },
                  error: (error, stackTrace) {
                    if(index == 0 && page == 1 && indexInPage == 0){
                      return CatBreedErrorCard(error: '$error',);
                    }else{
                      if(indexInPage == 0){

                      }
                    }

                  },
                  loading: () => const CatBreedCardLoader()
              );
            }
        ),
    );
  }

}





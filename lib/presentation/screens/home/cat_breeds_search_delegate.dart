import 'dart:async';

import 'package:catbreeds/app/configuration/theme/app_colors.dart';
import 'package:catbreeds/app/configuration/theme/app_text.dart';
import 'package:catbreeds/app/configuration/theme/app_text_styles.dart';
import 'package:catbreeds/app/extensions/string_extension.dart';
import 'package:catbreeds/data/repositories/cat_breeds_repository.dart';
import 'package:catbreeds/data/rest/list_cat_breeds_response.dart';
import 'package:catbreeds/domain/entities/cat_breed_entity.dart';
import 'package:catbreeds/presentation/shared/card/cat_breed_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CatBreedsSearchDelegate extends SearchDelegate<CatBreedEntity>{

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.brightness == Brightness.dark ? Colors.grey[900] : Colors.white,
        iconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
      ),
      inputDecorationTheme: searchFieldDecorationTheme ??
          InputDecorationTheme(
            hintStyle: searchFieldStyle ?? theme.inputDecorationTheme.hintStyle,
            border: InputBorder.none,
          ),
      scaffoldBackgroundColor: AppColors.kBackgroundPrimaryGreen1
    );
  }

  @override
  String? get searchFieldLabel => AppText.kHintSearch;

  Timer? typeTimer;
  List<CatBreedEntity> listCatBreed = [];
  bool isLoading = false;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: (){
          query = '';
        },
        icon: const Icon(Icons.clear)
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return BackButton(
      onPressed: context.pop,
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    return (listCatBreed.isEmpty)
        ? Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(AppText.kMessageNotResults,
                style: AppTextStyles.poppins14semiBoldTextPrimaryYellow1,),
        )
        : ListView.builder(
        padding: const EdgeInsets.all(20.0),
        itemCount: listCatBreed.length,
        itemBuilder: (context, index) {
          return CatBreedCard(
              catBreed: listCatBreed[index],
              onPressed: () => close(context, listCatBreed[index])
          );
        }
    );
  }

  @override
  Widget buildSuggestions(BuildContext context){
    if(query.length > 2){
      typeTimer?.cancel();
      processSearchCatBreed(context);
    }

    return (query.length > 2)
        ? const LinearProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.kPrimaryYellow1),
        )
        : Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(AppText.kMessageRequirementToSearch, style: AppTextStyles.poppins14semiBoldTextPrimaryYellow1,),
        );
  }

  void processSearchCatBreed(BuildContext context) async{
    typeTimer = Timer(const Duration(milliseconds: 1500), () async {
      isLoading = true;
      ListCatBreedsResponse response = await CatBreedsRepository().search(input: query);
      listCatBreed = response.results?.map(
            (x) => CatBreedEntity(
            name: x.name.safeEmpty(),
            origin: x.origin.safeEmpty(),
            intelligence: x.intelligence ?? 0,
            description: x.description.safeEmpty(),
            adaptability: x.adaptability ?? 0,
            lifeSpan: x.lifeSpan.safeEmpty(),
            imagePath: x.image?.url ?? ''
        ),
      ).toList() ?? [];
      isLoading = false;
      if(context.mounted){
        showResults(context);
      }
    });
  }

}
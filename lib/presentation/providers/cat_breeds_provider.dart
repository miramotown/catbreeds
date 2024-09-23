import 'package:catbreeds/app/extensions/string_extension.dart';
import 'package:catbreeds/data/repositories/cat_breeds_repository.dart';
import 'package:catbreeds/data/rest/list_cat_breeds_response.dart';
import 'package:catbreeds/domain/entities/cat_breed_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cat_breeds_provider.g.dart';

@riverpod
Future<List<CatBreedEntity>> listCatBreeds(ListCatBreedsRef ref, int page) async {
  ListCatBreedsResponse response = await CatBreedsRepository().list(page: page);
  List<CatBreedEntity> list = response.results?.map(
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

  return list;
}


@Riverpod(keepAlive: true)
class ListBreed extends _$ListBreed {
  @override
  List<CatBreedEntity> build() => [];

  void addList(List<CatBreedEntity> newList) {
    state = [...state, ...newList];
  }
}

@Riverpod(keepAlive: true)
class CatBreedPage extends _$CatBreedPage {
  @override
  int build() => 1;

  void nextPage(){
    state++;
  }
}


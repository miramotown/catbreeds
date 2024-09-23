
import 'package:catbreeds/app/services/network_service.dart';
import 'package:catbreeds/data/rest/list_cat_breeds_response.dart';

class CatBreedsNetworkProvider{

  Future<ListCatBreedsResponse> getListCarBreeds({int limit = 10, int? page}) async => NetworkService().fetch(
      bearerToken: true,
      url: 'v1/breeds',
      queryParameters: {
        'limit' : limit,
        'page' : page ?? 1
      }
  ).then((dynamic response) => ListCatBreedsResponse.fromListJson(response));

  Future<ListCatBreedsResponse> getListSearchCarBreeds({String? input}) async => NetworkService().fetch(
      bearerToken: true,
      url: 'v1/breeds/search',
      queryParameters: {
        'q' : input ?? '',
        'attach_image' : 1
      }
  ).then((response) => ListCatBreedsResponse.fromListJson(response));



}
import 'package:catbreeds/data/providers/network/cat_breeds_network_provider.dart';
import 'package:catbreeds/data/rest/list_cat_breeds_response.dart';

class CatBreedsRepository{

  CatBreedsNetworkProvider networkProvider = CatBreedsNetworkProvider();

  Future<ListCatBreedsResponse> list({int page = 1}) => networkProvider.getListCarBreeds(page: page);

  Future<ListCatBreedsResponse> search({String? input}) => networkProvider.getListSearchCarBreeds(input: input);

}
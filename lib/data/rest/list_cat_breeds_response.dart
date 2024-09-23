import 'dart:convert';

import 'package:catbreeds/data/models/cat_breeds_model.dart';

ListCatBreedsResponse responseMessagesModelFromJson(String str) => ListCatBreedsResponse.fromJson(json.decode(str));

String responseMessagesModelToJson(ListCatBreedsResponse data) => json.encode(data.toJson());


class ListCatBreedsResponse{

  ListCatBreedsResponse({
    this.results,
  });

  List<CatBreedsModel>? results;

  factory ListCatBreedsResponse.fromJson(Map<String, dynamic> json) => ListCatBreedsResponse(
    results: List<CatBreedsModel>.from(json["results"].map((x) => CatBreedsModel.fromJson(x))),
  );

  factory ListCatBreedsResponse.fromListJson(dynamic responseData) => ListCatBreedsResponse(
    results: (responseData as List).map((x) => CatBreedsModel.fromJson(x)).toList(),
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(results!.map((x) => x.toJson())),
  };

}

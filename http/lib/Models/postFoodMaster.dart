import 'dart:convert';

PostFoodMaster postFoodMasterFromJson(String str) => PostFoodMaster.fromJson(json.decode(str));

String postFoodMasterToJson(PostFoodMaster data) => json.encode(data.toJson());

class PostFoodMaster {
  String? name;
  int? fats;
  int? carbs;
  int? proteins;
  String? tTtFoodType;

  PostFoodMaster({
    this.name,
    this.fats,
    this.carbs,
    this.proteins,
    this.tTtFoodType,
  });

  factory PostFoodMaster.fromJson(Map<String, dynamic> json) => PostFoodMaster(
    name: json["name"],
    fats: json["fats"],
    carbs: json["carbs"],
    proteins: json["proteins"],
    tTtFoodType: json["tTTFoodType"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "fats": fats,
    "carbs": carbs,
    "proteins": proteins,
    "tTTFoodType": tTtFoodType,
  };
}

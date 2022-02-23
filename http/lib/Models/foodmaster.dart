import 'dart:convert';
class FoodMaster {
  String? foodName;
  final int? fats;
  final int? carbs;
  final int? proteins;
  final String? foodType;
  FoodMaster({
    this.foodName,
    this.fats,
    this.carbs,
    this.proteins,
    this.foodType,
  });
  factory FoodMaster.fromJson(Map<String, dynamic> json) {
     return FoodMaster(
        foodName: json['name'] as String,
        fats: json['fats'],
        carbs: json['carbs'],
        proteins: json['proteins'],
        foodType: json['tTTFoodType'],
     );
  }
  @override
  String toString(){
    return foodName.toString();
  }
}



// To parse this JSON data, do
//
//     final getFeedResponseModel = getFeedResponseModelFromJson(jsonString);

import 'dart:convert';

GetProductResponseListModel getProductResponseListResponseModelFromJson(
        String str) =>
    GetProductResponseListModel.fromJson(json.decode(str));

class GetProductResponseListModel {
  final String menuCategory;
  final String menuCategoryId;
  final List<CategoryDishes> dish;

  GetProductResponseListModel(
      {this.menuCategory, this.menuCategoryId, this.dish});

  factory GetProductResponseListModel.fromJson(Map<String, dynamic> json) =>
      GetProductResponseListModel(
        menuCategory:
            json["menu_category"] == null ? null : json["menu_category"],
        menuCategoryId:
            json["menu_category_id"] == null ? null : json["menu_category_id"],
        dish: List<CategoryDishes>.from(
            json["category_dishes"].map((x) => CategoryDishes.fromMap(x))),
      );
}

class CategoryDishes {
   String dishId;
   String dishName;
   double singleDishPrice;
   double dishPrice;
   String dishImage;
   String dishCurrency;
   double dishCalories;
   String dishDescription;
   bool dishAvailability;
   List addonCat;
  int count;

  CategoryDishes(
      {
      this.dishId,
      this.dishName,
      this.dishPrice,
      this.singleDishPrice,
      this.dishImage,
      this.dishCurrency,
      this.dishCalories,
      this.dishDescription,
      this.dishAvailability,
      this.count,
      this.addonCat});

  factory CategoryDishes.fromMap(Map<String, dynamic> json) => CategoryDishes(
      dishId: json["dish_id"] == null ? null : json["dish_id"],
      dishName: json["dish_name"] == null ? null : json["dish_name"],
      dishPrice: json["dish_price"] == null ? null : json["dish_price"],
      singleDishPrice: json["dish_price"] == null ? null : json["dish_price"],
      dishImage: json["dish_image"] == null ? null : json["dish_image"],
      count: 0,
      dishCurrency:
          json["dish_currency"] == null ? null : json["dish_currency"],
      dishCalories:
          json["dish_calories"] == null ? null : json["dish_calories"],
      dishDescription:
          json["dish_description"] == null ? null : json["dish_description"],
      dishAvailability:
          json["dish_Availability"] == null ? false : json["dish_Availability"],
      addonCat: json["addonCat"]);

}

class MainYourCarsModel {
  List<YourCarsModel> cars;

  MainYourCarsModel({
    required this.cars,
  });

  factory MainYourCarsModel.fromJson(List<dynamic> json) => MainYourCarsModel(
        cars: List<YourCarsModel>.from(
            json.map((e) => YourCarsModel.fromJson(e))),
      );
}

class YourCarsModel {
  String userId;
  String brand;
  String model;
  String varient;
  String price;
  String imgUrl;
  String kms;
  String year;
  YourCarsModel({
    required this.brand,
    required this.userId,
    required this.model,
    required this.varient,
    required this.imgUrl,
    required this.kms,
    required this.price,
    required this.year,
  });
  factory YourCarsModel.fromJson(Map<String, dynamic> json) => YourCarsModel(
        userId: json["userAd_Id"],
        year: json["user_reg_year"],
        brand: json["user_brand"] ?? "",
        model: json["user_model"] ?? "",
        varient: json["user_variant"] ?? "",
        imgUrl: json["user_Images"] ?? "",
        kms: json["user_kms"] ?? "",
        price: json["user_price"] ?? "",
      );
}

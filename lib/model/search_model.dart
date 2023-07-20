class MainSearchModel {
  List<SearchModel> cars;

  MainSearchModel({
    required this.cars,
  });

  factory MainSearchModel.fromJson(List<dynamic> json) => MainSearchModel(
        cars: List<SearchModel>.from(json.map((e) => SearchModel.fromJson(e))),
      );
}

class SearchModel {
  String id;
  String brand;
  String model;
  String price;
  String color;
  String kms;
  String year;
  String imgUrl;
  String varient;
  SearchModel(
      {required this.brand,
      required this.id,
      required this.model,
      required this.varient,
      required this.price,
      required this.color,
      required this.kms,
      required this.year,
      required this.imgUrl});

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        id: json["CarPurchase_Id"],
        brand: json["Brand_Name"],
        color: json["pCarColor"],
        imgUrl: json["pImage"],
        kms: json["pKm"],
        varient: json["Car_Varient"] ?? "",
        model: json["Car_Model"],
        price: json["pSellingPrice"],
        year: json["pRegYear"],
      );
}

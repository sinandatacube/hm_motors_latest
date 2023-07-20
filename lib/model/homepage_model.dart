class MainHomePageModel {
  List<BrandModel> brands;
  List<OfferwallModel> offerwall;
  List<CarModel> budget1;
  List<CarModel> budget2;
  List<CarModel> budget3;
  List<CarModel> budget4;
  List<CarModel> budget5;

  MainHomePageModel({
    required this.brands,
    required this.offerwall,
    required this.budget1,
    required this.budget2,
    required this.budget3,
    required this.budget4,
    required this.budget5,
  });

  factory MainHomePageModel.fromJson(Map<String, dynamic> json) =>
      MainHomePageModel(
        offerwall: List<OfferwallModel>.from(
            json["banners"].map((e) => OfferwallModel.fromJson(e))),
        brands: List<BrandModel>.from(
            json["brands"].map((e) => BrandModel.fromJson(e))),
        budget1: List<CarModel>.from(
            json["0-5 lakh"].map((e) => CarModel.fromJson(e))),
        budget2: List<CarModel>.from(
            json["5-10 lakh"].map((e) => CarModel.fromJson(e))),
        budget3: List<CarModel>.from(
            json["10-20 lakh"].map((e) => CarModel.fromJson(e))),
        budget4: List<CarModel>.from(
            json["20-30 lakh"].map((e) => CarModel.fromJson(e))),
        budget5: List<CarModel>.from(
            json["above30"].map((e) => CarModel.fromJson(e))),
      );
}

class BrandModel {
  String brandId;
  String brandName;
  String imgUrl;

  BrandModel(
      {required this.brandId, required this.brandName, required this.imgUrl});
  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
        brandId: json["CarBrand_Id"],
        brandName: json["Brand_Name"],
        imgUrl: json["Brand_logo"]);
  }
}

class OfferwallModel {
  String wallId;
  String wallName;
  String wallImg;
  OfferwallModel(
      {required this.wallId, required this.wallImg, required this.wallName});

  factory OfferwallModel.fromJson(Map<String, dynamic> json) => OfferwallModel(
      wallId: json["wall_id"],
      wallImg: json["wall_img"],
      wallName: json["wall_name"]);
}

class CarModel {
  String carPurchaseId;
  String carBrand;
  String carName;
  String imgUrl;
  String carprice;
  String carYear;
  String color;
  String kms;
  CarModel(
      {required this.carBrand,
      required this.carName,
      required this.color,
      required this.kms,
      required this.imgUrl,
      required this.carPurchaseId,
      required this.carYear,
      required this.carprice});

  factory CarModel.fromJson(Map<String, dynamic> json) => CarModel(
      imgUrl: json["pImage"],
      carBrand: json["Brand_Name"],
      carName: json["Car_Model"] ?? "",
      carPurchaseId: json["CarPurchase_Id"],
      carYear: json["pRegYear"],
      color: json["pCarColor"],
      kms: json["pKm"],
      carprice: json["pSellingPrice"]);
}

class VehicleDetailsModel {
  String id;
  String brand;
  String model;
  String price;
  String description;
  String regNumber;
  String color;
  String year;
  String accident;
  String fuel;
  String imgUrl;
  String varient;
  String kms;
  String owners;
  String transmission;
  String insuranceValid;
  String tyreCondition;
  String isInStock;
  // List<ImagesListModel> images;

  VehicleDetailsModel({
    // required this.images,
    required this.isInStock,
    required this.accident,
    required this.insuranceValid,
    required this.brand,
    required this.color,
    required this.description,
    required this.fuel,
    required this.id,
    required this.imgUrl,
    required this.kms,
    required this.model,
    required this.owners,
    required this.price,
    required this.regNumber,
    required this.varient,
    required this.year,
    required this.transmission,
    required this.tyreCondition,
  });

  factory VehicleDetailsModel.fromJson(Map<String, dynamic> json) =>
      VehicleDetailsModel(
          // images: List<ImagesListModel>.from((json["fullImages"] as dynamic)
          //     .map((e) => ImagesListModel.fromJson(e))),
          isInStock: json["car_stock"],
          tyreCondition: json["pTyreCond"] ?? "",
          insuranceValid: json["pInsurance"] ?? "",
          transmission: json["pTtransmission"] ?? "",
          accident: json["pAccident"] ?? "",
          brand: json["Brand_Name"] ?? "",
          color: json["pCarColor"] ?? "",
          description: json["pDescription"] ?? "",
          fuel: json["pFuel"] ?? "",
          id: json["CarPurchase_Id"] ?? "",
          imgUrl: json["pImage"] ?? "",
          kms: json["pKm"] ?? "",
          model: json["Car_Model"] ?? "",
          owners: json["pOwnerNum"] ?? "",
          price: json["pSellingPrice"] ?? "",
          regNumber: json["pRegNumber"] ?? "",
          varient: json["Car_Varient"] ?? "",
          year: json["pRegYear"] ?? "");
}

class ImagesListModel {
  String id;
  String image;
  ImagesListModel({required this.image, required this.id});

  factory ImagesListModel.fromJson(Map<String, dynamic> json) => ImagesListModel(
      id: json["Image_Id"], image: json["Car_Image"]
      // cars: List<SearchModel>.from(json.map((e) => SearchModel.fromJson(e))),
      );
}

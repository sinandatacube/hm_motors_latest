import 'package:hm_motors/model/vehicle_details_model.dart';

class MainWishListModel {
  List<WishlistModel> cars;

  MainWishListModel({
    required this.cars,
  });

  factory MainWishListModel.fromJson(List<dynamic> json) => MainWishListModel(
        cars: List<WishlistModel>.from(
            json.map((e) => WishlistModel.fromJson(e))),
      );
}

class WishlistModel {
  final String id;
  final String owners;
  final String kms;
  final String brand;
  final String model;
  final String varient;

  final String fuel;
  final String color;
  final String year;
  final String accident;
  final String wishId;
  final String status;

  final String transmission;
  final String image;
  final String description;

  final String price;

  WishlistModel({
    required this.accident,
    required this.status,
    required this.wishId,
    required this.color,
    required this.fuel,
    required this.brand,
    required this.id,
    required this.description,
    required this.image,
    required this.kms,
    required this.model,
    required this.owners,
    required this.price,
    required this.transmission,
    required this.varient,
    required this.year,
  });

  factory WishlistModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      WishlistModel(
        brand: json["Brand_Name"] ?? "",
        status: json["status"] ?? "",
        wishId: json["wishlist_id"] ?? "",
        model: json["Car_Model"] ?? "",
        varient: json["Car_Varient"] ?? "",
        accident: json['pAccident'] ?? "",
        color: json['pCarColor'] ?? "",
        fuel: json['pFuel'] ?? "",
        id: json["CarPurchase_Id"] ?? "",
        image: json["pImage"] ?? "",
        price: json["pSellingPrice"] ?? "",
        kms: json["pKm"] ?? "",
        description: json["pDescription"] ?? "",
        owners: json["pOwnerNum"] ?? "",
        transmission: json["pTtransmission"] ?? "",
        year: json["pRegYear"] ?? "",
      );
}

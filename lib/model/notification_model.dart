import 'dart:convert';

List<NotificationModel> notificationModelFromJson(String str) =>
    List<NotificationModel>.from(
        json.decode(str).map((x) => NotificationModel.fromJson(x)));

String notificationModelToJson(List<NotificationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationModel {
  String notifId;
  DateTime notifDate;
  String adId;
  String image;
  String title;
  String body;
  String sellingPrice;

  NotificationModel({
    required this.notifId,
    required this.notifDate,
    required this.adId,
    required this.image,
    required this.title,
    required this.body,
    required this.sellingPrice,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        notifId: json["notif_id"],
        notifDate: DateTime.parse(json["notif_date"]),
        adId: json["ad_id"],
        image: json["image"],
        title: json["title"],
        body: json["body"],
        sellingPrice: json["SellingPrice"],
      );

  Map<String, dynamic> toJson() => {
        "notif_id": notifId,
        "notif_date":
            "${notifDate.year.toString().padLeft(4, '0')}-${notifDate.month.toString().padLeft(2, '0')}-${notifDate.day.toString().padLeft(2, '0')}",
        "ad_id": adId,
        "image": image,
        "title": title,
        "body": body,
        "SellingPrice": sellingPrice,
      };
}

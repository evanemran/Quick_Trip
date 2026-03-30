import 'package:quick_trip/models/trip_detail_model.dart';

class TripModel {
  String id;
  String name;
  String date;
  double budget;
  String image;
  TripDetailModel tripDetailModel;

  TripModel({
    required this.id,
    required this.name,
    required this.date,
    required this.budget,
    required this.image,
    required this.tripDetailModel,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      id: json['id'],
      name: json['name'],
      date: json['date'],
      budget: json['budget'],
      image: json['image'],
      tripDetailModel: TripDetailModel.fromJson(json['tripDetailModel']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'date': date,
      'budget': budget,
      'image': image,
      'tripDetailModel': tripDetailModel.toJson(),
    };
  }
}
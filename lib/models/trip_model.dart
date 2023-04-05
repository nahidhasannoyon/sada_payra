// To parse this JSON data, do
//
//     final tripModel = tripModelFromJson(jsonString);

import 'dart:convert';

List<TripModel> tripModelFromJson(String str) =>
    List<TripModel>.from(json.decode(str).map((x) => TripModel.fromJson(x)));

String tripModelToJson(List<TripModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TripModel {
  TripModel({
    required this.id,
    required this.tripType,
    required this.startTime,
    required this.startPoint,
    required this.remarks,
    required this.route,
    required this.mode,
  });

  final String id;
  final String tripType;
  final String startTime;
  final String startPoint;
  final String remarks;
  final String route;
  final String mode;

  factory TripModel.fromJson(Map<String, dynamic> json) => TripModel(
        id: json["id"],
        tripType: json["trip_type"],
        startTime: json["start_time"],
        startPoint: json["start_point"],
        remarks: json["remarks"],
        route: json["route"],
        mode: json["mode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "trip_type": tripType,
        "start_time": startTime,
        "start_point": startPoint,
        "remarks": remarks,
        "route": route,
        "mode": mode,
      };
}

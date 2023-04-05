import 'dart:async';
import 'dart:convert';

import 'package:sada_payra/secrets.dart';

import '../models/trip_model.dart';
import 'package:http/http.dart' as http;

// todo add provider with change Notifier

// * Up Trips
final List<TripModel> upTripList = [];

Future<List<TripModel>> fetchUpTripList() async {
  try {
    final response = await http.get(
      Uri.parse('$baseApiLink/bus_schedules/get_up_trips.php'),
    );
    if (response.statusCode == 200) {
      final extractedData = jsonDecode(response.body);
      if (extractedData.isEmpty) {
        throw Exception('No Data Found');
      }
      upTripList.clear();
      for (var tripData in extractedData) {
        upTripList.add(
          TripModel(
            id: tripData['id'],
            tripType: tripData['trip_type'],
            startTime: tripData['start_time'],
            startPoint: tripData['start_point'],
            route: tripData['route'],
            mode: tripData['mode'],
            remarks: tripData['remarks'],
          ),
        );
      }
    } else {
      throw Exception('Failed to connect');
    }
  } catch (e) {
    print('Failed to fetch up trips');
  }
  upTripList.sort((a, b) => a.startTime.compareTo(b.startTime));
  return upTripList;
}

Future<List<TripModel>> addUpTrip(TripModel newTrip) async {
  try {
    var newId = DateTime.now().toString();
    final response = await http.post(
      Uri.parse('$baseApiLink/bus_schedules/post_trip.php'),
      body: jsonEncode(
        <String, String>{
          "id": newId,
          "trip_type": "up",
          "start_time": newTrip.startTime.toString(),
          "start_point": newTrip.startPoint.toString(),
          "route": newTrip.route.toString(),
          "mode": newTrip.mode.toString(),
          "remarks": newTrip.remarks.toString(),
        },
      ),
    );
    if (response.statusCode == 200) {
      final newUpTrip = TripModel(
        id: newId,
        startTime: newTrip.startTime.toString(),
        startPoint: newTrip.startPoint.toString(),
        route: newTrip.route.toString(),
        mode: newTrip.mode.toString(),
        remarks: newTrip.remarks.toString(),
        tripType: 'up',
      );
      upTripList.add(newUpTrip);
      upTripList.sort((a, b) => a.startTime.compareTo(b.startTime));
      return upTripList;
    } else {
      throw Exception('Failed to connect');
    }
  } catch (e) {
    print('Failed to upload');
  }
  return upTripList;
}

Future<bool> updateUpTrip(String id, TripModel updatedTrip) async {
  try {
    final response = await http.patch(
      Uri.parse('$baseApiLink/bus_schedules/update_trip.php'),
      body: jsonEncode(
        <String, String>{
          "id": id,
          "trip_type": "up",
          "start_time": updatedTrip.startTime.toString(),
          "start_point": updatedTrip.startPoint.toString(),
          "route": updatedTrip.route.toString(),
          "mode": updatedTrip.mode.toString(),
          "remarks": updatedTrip.remarks.toString(),
        },
      ),
    );
    if (response.statusCode < 400) {
      final upTripIndex = upTripList.indexWhere((trip) => trip.id == id);
      upTripList[upTripIndex] = updatedTrip;
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print('Failed to update');
  }
  return false;
}

Future<bool> deleteUpTrip(String id) async {
  final response = await http.delete(
    Uri.parse('$baseApiLink/bus_schedules/delete_trip.php'),
    body: jsonEncode(
      <String, String>{
        "id": id,
      },
    ),
  );

  if (response.statusCode < 400) {
    upTripList.removeWhere((trip) => trip.id == id);
    return true;
  } else {
    return false;
  }
}

// * Down Trips
final List<TripModel> downTripList = [];

Future<List<TripModel>> fetchDownTripList() async {
  try {
    final response = await http.get(
      Uri.parse('$baseApiLink/bus_schedules/get_down_trips.php'),
    );
    if (response.statusCode == 200) {
      final extractedData = jsonDecode(response.body);
      if (extractedData.isEmpty) {
        throw Exception('No Data Found');
      }
      downTripList.clear();
      for (var tripData in extractedData) {
        downTripList.add(
          TripModel(
            id: tripData['id'],
            tripType: tripData['trip_type'],
            startTime: tripData['start_time'],
            startPoint: tripData['start_point'],
            route: tripData['route'],
            mode: tripData['mode'],
            remarks: tripData['remarks'],
          ),
        );
      }
    } else {
      throw Exception('Failed to connect');
    }
  } catch (e) {
    print('Failed to fetch up trips');
  }
  downTripList.sort((a, b) => a.startTime.compareTo(b.startTime));
  return downTripList;
}

Future<List<TripModel>> addDownTrip(TripModel newTrip) async {
  try {
    var newId = DateTime.now().toString();
    final response = await http.post(
      Uri.parse('$baseApiLink/bus_schedules/post_trip.php'),
      body: jsonEncode(
        <String, String>{
          "id": newId,
          "trip_type": "down",
          "start_time": newTrip.startTime.toString(),
          "start_point": newTrip.startPoint.toString(),
          "route": newTrip.route.toString(),
          "mode": newTrip.mode.toString(),
          "remarks": newTrip.remarks.toString(),
        },
      ),
    );
    if (response.statusCode == 200) {
      final newDownTrip = TripModel(
        id: newId,
        startTime: newTrip.startTime.toString(),
        startPoint: newTrip.startPoint.toString(),
        route: newTrip.route.toString(),
        mode: newTrip.mode.toString(),
        remarks: newTrip.remarks.toString(),
        tripType: 'down',
      );
      downTripList.add(newDownTrip);
      downTripList.sort((a, b) => a.startTime.compareTo(b.startTime));
      return downTripList;
    } else {
      throw Exception('Failed to connect');
    }
  } catch (e) {
    print('Failed to upload');
  }
  return downTripList;
}

Future<bool> updateDownTrip(String id, TripModel updatedTrip) async {
  try {
    final response = await http.patch(
      Uri.parse('$baseApiLink/bus_schedules/update_trip.php'),
      body: jsonEncode(
        <String, String>{
          "id": id,
          "trip_type": "down",
          "start_time": updatedTrip.startTime.toString(),
          "start_point": updatedTrip.startPoint.toString(),
          "route": updatedTrip.route.toString(),
          "mode": updatedTrip.mode.toString(),
          "remarks": updatedTrip.remarks.toString(),
        },
      ),
    );
    if (response.statusCode < 400) {
      final downTripIndex = downTripList.indexWhere((trip) => trip.id == id);
      downTripList[downTripIndex] = updatedTrip;
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print('Failed to update');
  }
  return false;
}

Future<bool> deleteDownTrip(String id) async {
  final response = await http.delete(
    Uri.parse('$baseApiLink/bus_schedules/delete_trip.php'),
    body: jsonEncode(
      <String, String>{
        "id": id,
      },
    ),
  );

  if (response.statusCode < 400) {
    downTripList.removeWhere((trip) => trip.id == id);
    return true;
  } else {
    return false;
  }
}

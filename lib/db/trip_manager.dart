import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/trip_model.dart';
import 'encryption_helper.dart';

class TripManager {
  static const _tripKey = 'trips';

  /// Save or update trip
  static Future<void> saveTrip(TripModel trip) async {
    final prefs = await SharedPreferences.getInstance();

    final trips = await getTrips();
    trips.removeWhere((t) => t.id == trip.id);
    trips.add(trip);

    final encryptedJson = EncryptionHelper.encrypt(
      jsonEncode(trips.map((e) => e.toJson()).toList()),
    );

    await prefs.setString(_tripKey, encryptedJson);
  }

  /// Get all trips
  static Future<List<TripModel>> getTrips() async {
    final prefs = await SharedPreferences.getInstance();
    final encrypted = prefs.getString(_tripKey);

    if (encrypted == null || encrypted.isEmpty) return [];

    try {
      final decrypted = EncryptionHelper.decrypt(encrypted);
      final List data = jsonDecode(decrypted);

      return data.map((e) => TripModel.fromJson(e)).toList();
    } catch (e) {
      // Prevent corrupted data loop
      await prefs.remove(_tripKey);
      return [];
    }
  }

  /// Delete trip
  static Future<void> deleteTrip(String tripId) async {
    final prefs = await SharedPreferences.getInstance();
    final trips = await getTrips();

    trips.removeWhere((t) => t.id == tripId);

    final encryptedJson = EncryptionHelper.encrypt(
      jsonEncode(trips.map((e) => e.toJson()).toList()),
    );

    await prefs.setString(_tripKey, encryptedJson);
  }
}
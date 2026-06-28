import 'package:attendance_tracker/core/error/exceptions.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

class LocationData {
  const LocationData({
    required this.latitude,
    required this.longitude,
    this.address,
  });

  final double latitude;
  final double longitude;
  final String? address;
}

@lazySingleton
class LocationService {
  Future<LocationData> getCurrentLocation() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationServicesDisabledException(stackTrace: StackTrace.current);
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied) {
      throw LocationPermissionDeniedException(
        stackTrace: StackTrace.current,
        isPermanent: false,
      );
    }
    if (permission == LocationPermission.deniedForever) {
      throw LocationPermissionDeniedException(
        stackTrace: StackTrace.current,
        isPermanent: true,
      );
    }

    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );

    return LocationData(
      latitude: position.latitude,
      longitude: position.longitude,
      address:
          '${position.latitude.toStringAsFixed(5)}, ${position.longitude.toStringAsFixed(5)}',
    );
  }
}

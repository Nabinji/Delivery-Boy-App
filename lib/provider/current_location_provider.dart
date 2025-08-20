import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocationProvider extends ChangeNotifier {
  LatLng _currentLocation = LatLng(
    37.7749,
    -122.4194,
  ); // Default: San Francisco
  bool _isLoading = true;
  String _errorMessage = '';

  LatLng get currentLocation => _currentLocation;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  CurrentLocationProvider() {
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _errorMessage = 'Location permission denied. Using default location.';
          _isLoading = false;
          notifyListeners();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _errorMessage =
            'Location permissions are permanently denied. Using default location.';
        _isLoading = false;
        notifyListeners();
        return;
      }

      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _errorMessage =
            'Location services are disabled. Using default location.';
        _isLoading = false;
        notifyListeners();
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      _currentLocation = LatLng(position.latitude, position.longitude);
      _isLoading = false;
      _errorMessage = '';
      notifyListeners();
    } catch (e) {
      _errorMessage =
          'Error getting location: ${e.toString()}. Using default location.';
      _isLoading = false;
      notifyListeners();
    }
  }

  void refreshLocation() {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();
    _getCurrentLocation();
  }
}

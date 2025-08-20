import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocationProvider extends ChangeNotifier {
  // Default: San Francisco
  LatLng _currentLocation = LatLng(37.7749, -122.4194);
  bool _isLoading = true;
  String _errorMessage = '';
// Public getters to access private variables
  LatLng get currentLocation => _currentLocation;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  CurrentLocationProvider() {
    _getCurrentLocation();
  }
// Main function to get device's current location

  Future<void> _getCurrentLocation() async {
    try {
         //  Check if location permission is granted
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
          // Request permission if denied
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _errorMessage = 'Location permission denied. Using default location.';
          _isLoading = false;
          notifyListeners();
          return;
        }
      }
      // Check if permission is permanently denied
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
// Success - update location and clear loading/error states
      _currentLocation = LatLng(position.latitude, position.longitude);
      _isLoading = false;
      _errorMessage = '';
      notifyListeners();
    } catch (e) {
       // Handle any errors during location retrieval
      _errorMessage =
          'Error getting location: ${e.toString()}. Using default location.';
      _isLoading = false;
      notifyListeners();
    }
  }
  // Public method to manually refresh location (can be called by UI)
  void refreshLocation() {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();
    _getCurrentLocation();
  }
}

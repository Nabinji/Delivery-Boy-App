// import 'package:delivery_boy_app/models/order_model.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// enum DeliveryStatus {
//   waitingForAcceptance,
//   orderAccepted,
//   pickingUp,
//   destinationReached,
//   enRoute,
//   markingAsDelivered, // New status
//   delivered,
//   rejected,
// }

// class DeliveryProvider extends ChangeNotifier {
//   DeliveryStatus _status = DeliveryStatus.waitingForAcceptance;
//   OrderModel? _currentOrder;
//   List<LatLng> _routePoints = [];
//   int _currentRouteIndex = 0;
//   LatLng? _currentDeliveryBoyPosition;
//   bool _isAnimating = false;

//   // Getters
//   DeliveryStatus get status => _status;
//   OrderModel? get currentOrder => _currentOrder;
//   List<LatLng> get routePoints => _routePoints;
//   LatLng? get currentDeliveryBoyPosition => _currentDeliveryBoyPosition;
//   bool get isAnimating => _isAnimating;
//   int get currentRouteIndex => _currentRouteIndex;

//   void initializeOrder() {
//     _currentOrder = OrderModel(
//       id: "ORD123",
//       customerName: "John Doe",
//       customerPhone: "014542765",
//       item: "Tender Coconut (Normal)",
//       quantity: 4,
//       price: 320,
//       pickupLocation:  LatLng(27.7033, 85.3066), // Kathmandu Durbar Square
//       deliveryLocation:  LatLng(27.6710, 85.3250), // Patan Durbar Square
//       pickupAddress: "Kathmandu Durbar Square",
//       deliveryAddress: "Patan Durbar Square",
//     );
//     _status = DeliveryStatus.waitingForAcceptance;
//     notifyListeners();
//   }

//   void acceptOrder() {
//     _status = DeliveryStatus.orderAccepted;
//     _generateRoutePoints();
//     notifyListeners();
//   }

//   void rejectOrder() {
//     _status = DeliveryStatus.rejected;
//     _routePoints.clear();
//     _currentDeliveryBoyPosition = null;
//     notifyListeners();
//   }

//   // NEW: Call this when navigating to DeliveryMapScreen
//   void startPickup() {
//     _status = DeliveryStatus.pickingUp;
//     _currentDeliveryBoyPosition = _currentOrder!.pickupLocation;
//     notifyListeners();
//   }

//   // Call this when "Mark as Picked Up" button is clicked
//   void markAsPickedUp() {
//     _status = DeliveryStatus.enRoute;
//     _isAnimating = true;
//     _animateDeliveryBoy();
//     notifyListeners();
//   }

//   // This is called automatically when marker reaches destination
//   void _onDestinationReached() {
//     _status = DeliveryStatus.destinationReached;
//     _isAnimating = false;
//     notifyListeners();
//   }

//   // Call this when user clicks "Mark as Destination Reached" button
//   void markDestinationReached() {
//     // This just acknowledges that destination was reached
//     // Icons and status remain the same until markAsDelivered is called
//     notifyListeners();
//   }

//   // Call this when "Mark as Delivered" button is clicked (first time)
//   void markAsDelivered() {
//     _status = DeliveryStatus.markingAsDelivered;
//     _isAnimating = false;
//     notifyListeners();
//   }

//   // Call this when "Marking as Delivered..." button is clicked (second time)
//   void completeDelivery() {
//     _status = DeliveryStatus.delivered;
//     _isAnimating = false;
//     notifyListeners();
//   }

//   void _generateRoutePoints() {
//     if (_currentOrder == null) return;

//     final pickup = _currentOrder!.pickupLocation;
//     final delivery = _currentOrder!.deliveryLocation;

//     _routePoints = [
//       pickup,
//       LatLng(pickup.latitude + 0.01, pickup.longitude + 0.01),
//       LatLng(pickup.latitude + 0.02, pickup.longitude + 0.015),
//       LatLng(delivery.latitude - 0.01, delivery.longitude - 0.01),
//       delivery,
//     ];

//     _currentDeliveryBoyPosition = pickup;
//     _currentRouteIndex = 0;
//   }

//   void _animateDeliveryBoy() async {
//     if (!_isAnimating || _routePoints.isEmpty) return;

//     while (_currentRouteIndex < _routePoints.length - 1 && _isAnimating) {
//       await Future.delayed( Duration(seconds: 2));

//       if (_isAnimating) {
//         _currentRouteIndex++;
//         _currentDeliveryBoyPosition = _routePoints[_currentRouteIndex];

//         if (_currentRouteIndex == _routePoints.length - 1) {
//           // Reached destination - just stop animation, don't change icons yet
//           await Future.delayed( Duration(seconds: 1));
//           _onDestinationReached(); // Use the private method
//         }

//         notifyListeners();
//       }
//     }
//   }

//   void resetDelivery() {
//     _status = DeliveryStatus.waitingForAcceptance;
//     _routePoints.clear();
//     _currentRouteIndex = 0;
//     _currentDeliveryBoyPosition = null;
//     _isAnimating = false;
//     initializeOrder();
//     notifyListeners();
//   }
// }

// import 'package:delivery_boy_app/models/order_model.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'dart:async';

// enum DeliveryStatus {
//   waitingForAcceptance,
//   orderAccepted,
//   pickingUp,
//   destinationReached,
//   enRoute,
//   markingAsDelivered,
//   delivered,
//   rejected,
// }

// class DeliveryProvider extends ChangeNotifier {
//   DeliveryStatus _status = DeliveryStatus.waitingForAcceptance;
//   OrderModel? _currentOrder;
//   List<LatLng> _routePoints = [];
//   int _currentRouteIndex = 0;
//   LatLng? _currentDeliveryBoyPosition;
//   bool _isAnimating = false;
//   Timer? _animationTimer;

//   // Getters
//   DeliveryStatus get status => _status;
//   OrderModel? get currentOrder => _currentOrder;
//   List<LatLng> get routePoints => _routePoints;
//   LatLng? get currentDeliveryBoyPosition => _currentDeliveryBoyPosition;
//   bool get isAnimating => _isAnimating;
//   int get currentRouteIndex => _currentRouteIndex;

//   void initializeOrder() {
//     _currentOrder = OrderModel(
//       id: "ORD123",
//       customerName: "John Doe",
//       customerPhone: "014542765",
//       item: "Tender Coconut (Normal)",
//       quantity: 4,
//       price: 320,
//       pickupLocation:  LatLng(27.7033, 85.3066), // Kathmandu Durbar Square
//       deliveryLocation:  LatLng(27.6710, 85.3250), // Patan Durbar Square
//       pickupAddress: "Kathmandu Durbar Square",
//       deliveryAddress: "Patan Durbar Square",
//     );
//     _status = DeliveryStatus.waitingForAcceptance;
//     notifyListeners();
//   }

//   void acceptOrder() {
//     _status = DeliveryStatus.orderAccepted;
//     _generateRoutePoints();
//     notifyListeners();
//   }

//   void rejectOrder() {
//     _status = DeliveryStatus.rejected;
//     _routePoints.clear();
//     _currentDeliveryBoyPosition = null;
//     _stopAnimation();
//     notifyListeners();
//   }

//   void startPickup() {
//     _status = DeliveryStatus.pickingUp;
//     _currentDeliveryBoyPosition = _currentOrder!.pickupLocation;
//     notifyListeners();
//   }

//   void markAsPickedUp() {
//     _status = DeliveryStatus.enRoute;
//     _isAnimating = true;
//     _animateDeliveryBoySmooth();
//     notifyListeners();
//   }

//   void _onDestinationReached() {
//     _status = DeliveryStatus.destinationReached;
//     _isAnimating = false;
//     _stopAnimation();
//     notifyListeners();
//   }

//   void markDestinationReached() {
//     notifyListeners();
//   }

//   void markAsDelivered() {
//     _status = DeliveryStatus.markingAsDelivered;
//     _isAnimating = false;
//     notifyListeners();
//   }

//   void completeDelivery() {
//     _status = DeliveryStatus.delivered;
//     _isAnimating = false;
//     notifyListeners();
//   }

//   void _generateRoutePoints() {
//     if (_currentOrder == null) return;

//     // Realistic route points from Kathmandu Durbar Square to Patan Durbar Square
//     _routePoints = [
//        LatLng(27.7033, 85.3066), // Start: Kathmandu Durbar Square
//        LatLng(27.7025, 85.3070), // Move towards New Road
//        LatLng(27.7015, 85.3075), // New Road area
//        LatLng(27.7000, 85.3085), // Towards Ratna Park
//        LatLng(27.6980, 85.3100), // Ratna Park area
//        LatLng(27.6960, 85.3120), // Towards Babar Mahal
//        LatLng(27.6940, 85.3140), // Babar Mahal
//        LatLng(27.6920, 85.3160), // Towards Kupondole
//        LatLng(27.6900, 85.3180), // Kupondole area
//        LatLng(27.6880, 85.3200), // Towards Jawalakhel
//        LatLng(27.6860, 85.3220), // Jawalakhel
//        LatLng(27.6840, 85.3235), // Towards Patan
//        LatLng(27.6820, 85.3245), // Near Patan
//        LatLng(27.6800, 85.3248), // Approaching Patan Durbar Square
//        LatLng(27.6780, 85.3250), // Almost there
//        LatLng(27.6710, 85.3250), // End: Patan Durbar Square
//     ];

//     _currentDeliveryBoyPosition = _routePoints[0];
//     _currentRouteIndex = 0;
//   }

//   void _animateDeliveryBoySmooth() {
//     if (!_isAnimating || _routePoints.isEmpty) return;

//     _stopAnimation(); // Stop any existing animation

//     _currentRouteIndex = 0;
//     _animateToNextPoint();
//   }

//   void _animateToNextPoint() {
//     if (!_isAnimating || _currentRouteIndex >= _routePoints.length - 1) {
//       if (_currentRouteIndex >= _routePoints.length - 1) {
//         _currentDeliveryBoyPosition = _routePoints.last;
//         _onDestinationReached();
//       }
//       return;
//     }

//     final startPoint = _routePoints[_currentRouteIndex];
//     final endPoint = _routePoints[_currentRouteIndex + 1];

//     // Animation duration between two points (adjust this for speed)
//      animationDuration = Duration(milliseconds: 300);
//      frameRate = Duration(milliseconds: 60);

//     int totalFrames =
//         animationDuration.inMilliseconds ~/ frameRate.inMilliseconds;
//     int currentFrame = 0;

//     _animationTimer = Timer.periodic(frameRate, (timer) {
//       if (!_isAnimating) {
//         timer.cancel();
//         return;
//       }

//       if (currentFrame >= totalFrames) {
//         // Reached current target point, move to next
//         _currentRouteIndex++;
//         timer.cancel();
//         _animateToNextPoint(); // Recursively animate to next point
//         return;
//       }

//       // Calculate interpolated position
//       double progress = currentFrame / totalFrames;

//       // Use easing for more natural movement (optional)
//       progress = _easeInOut(progress);

//       double lat =
//           startPoint.latitude +
//           (endPoint.latitude - startPoint.latitude) * progress;
//       double lng =
//           startPoint.longitude +
//           (endPoint.longitude - startPoint.longitude) * progress;

//       _currentDeliveryBoyPosition = LatLng(lat, lng);
//       currentFrame++;
//       notifyListeners();
//     });
//   }

//   // Optional: Easing function for more natural movement
//   double _easeInOut(double t) {
//     return t < 0.5 ? 2 * t * t : -1 + (4 - 2 * t) * t;
//   }

//   void _stopAnimation() {
//     _animationTimer?.cancel();
//     _animationTimer = null;
//   }

//   void resetDelivery() {
//     _stopAnimation();
//     _status = DeliveryStatus.waitingForAcceptance;
//     _routePoints.clear();
//     _currentRouteIndex = 0;
//     _currentDeliveryBoyPosition = null;
//     _isAnimating = false;
//     initializeOrder();
//     notifyListeners();
//   }

//   @override
//   void dispose() {
//     _stopAnimation();
//     super.dispose();
//   }
// }
import 'package:delivery_boy_app/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'dart:math';

enum DeliveryStatus {
  waitingForAcceptance,
  orderAccepted,
  pickingUp,
  destinationReached,
  enRoute,
  markingAsDelivered,
  delivered,
  rejected,
}

class DeliveryProvider extends ChangeNotifier {
  DeliveryStatus _status = DeliveryStatus.waitingForAcceptance;
  OrderModel? _currentOrder;
  List<LatLng> _routePoints = [];
  int _currentStep = 0;
  LatLng? _currentDeliveryBoyPosition;
  Timer? _animationTimer;
  final Set<Polyline> _polylines = {};
  final Set<Marker> _markers = {};

  // Getters
  DeliveryStatus get status => _status;
  OrderModel? get currentOrder => _currentOrder;
  List<LatLng> get routePoints => _routePoints;
  LatLng? get currentDeliveryBoyPosition => _currentDeliveryBoyPosition;
  Set<Polyline> get polylines => _polylines;
  Set<Marker> get markers => _markers;

  // Hardcoded route points (pre-calculated)
  static const  List<LatLng> _preCalculatedRoute = [
    LatLng(27.7033, 85.3066),
    LatLng(27.7020, 85.3078),
    LatLng(27.7005, 85.3101),
    LatLng(27.6980, 85.3135),
    LatLng(27.6950, 85.3160),
    LatLng(27.6915, 85.3190),
    LatLng(27.6880, 85.3220),
    LatLng(27.6845, 85.3235),
    LatLng(27.6810, 85.3245),
    LatLng(27.6780, 85.3250),
    LatLng(27.6750, 85.3252),
    LatLng(27.6710, 85.3250),
  ];

  void initializeOrder() {
    _currentOrder = OrderModel(
      id: "ORD123",
      customerName: "John Doe",
      customerPhone: "014542765",
      item: "Tender Coconut (Normal)",
      quantity: 4,
      price: 320,
      pickupLocation:  LatLng(27.7033, 85.3066),
      deliveryLocation:  LatLng(27.6710, 85.3250),
      pickupAddress: "Kathmandu Durbar Square",
      deliveryAddress: "Patan Durbar Square",
    );
    _status = DeliveryStatus.waitingForAcceptance;
    notifyListeners();
  }

  void acceptOrder() {
    _status = DeliveryStatus.orderAccepted;
    _generateRoutePoints();
    _setupMapOverlays();
    notifyListeners();
  }

  void rejectOrder() {
    _status = DeliveryStatus.rejected;
    _routePoints.clear();
    _polylines.clear();
    _markers.clear();
    _currentDeliveryBoyPosition = null;
    _stopAnimation();
    notifyListeners();
  }

  void startPickup() {
    _status = DeliveryStatus.pickingUp;
    _currentDeliveryBoyPosition = _currentOrder!.pickupLocation;
    _updateDeliveryBoyMarker();
    notifyListeners();
  }

  void markAsPickedUp() {
    _status = DeliveryStatus.enRoute;
    _startDeliverySimulation();
    notifyListeners();
  }

  void markDestinationReached() {
    _status = DeliveryStatus.destinationReached;
    _stopAnimation();
    notifyListeners();
  }

  void markAsDelivered() {
    _status = DeliveryStatus.markingAsDelivered;
    notifyListeners();
  }

  void completeDelivery() {
    _status = DeliveryStatus.delivered;
    notifyListeners();
  }

  void _generateRoutePoints() {
    _routePoints = _preCalculatedRoute;
    _currentDeliveryBoyPosition = _routePoints[0];
    _currentStep = 0;
  }

  void _setupMapOverlays() {
    // Add route polyline
    _polylines.add(
      Polyline(
        polylineId:  PolylineId('deliveryRoute'),
        points: _routePoints,
        color: Colors.blue,
        width: 5,
      ),
    );

    // Add static markers
    _markers.add(
      Marker(
        markerId:  MarkerId('pickup'),
        position: _currentOrder!.pickupLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow:  InfoWindow(title: 'Pickup Location'),
      ),
    );

    _markers.add(
      Marker(
        markerId:  MarkerId('delivery'),
        position: _currentOrder!.deliveryLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow:  InfoWindow(title: 'Delivery Location'),
      ),
    );

    // Add initial delivery boy marker
    _updateDeliveryBoyMarker();
  }

  void _updateDeliveryBoyMarker() {
    _markers.removeWhere((m) => m.markerId.value == 'deliveryBoy');
    if (_currentDeliveryBoyPosition != null) {
      _markers.add(
        Marker(
          markerId:  MarkerId('deliveryBoy'),
          position: _currentDeliveryBoyPosition!,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          rotation: _calculateBearing(),
          infoWindow:  InfoWindow(title: 'Delivery Partner'),
        ),
      );
    }
  }

  double _calculateBearing() {
    if (_currentStep == 0 || _routePoints.isEmpty) return 0;

    LatLng previousPoint = _routePoints[_currentStep - 1];
    LatLng currentPoint = _routePoints[_currentStep];

    double lat1 = previousPoint.latitude * pi / 180;
    double lon1 = previousPoint.longitude * pi / 180;
    double lat2 = currentPoint.latitude * pi / 180;
    double lon2 = currentPoint.longitude * pi / 180;

    double y = sin(lon2 - lon1) * cos(lat2);
    double x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(lon2 - lon1);
    return (atan2(y, x) * 180 / pi + 360) % 360;
  }

  void _startDeliverySimulation() {
   const  duration = Duration(milliseconds: 300);
    _animationTimer = Timer.periodic(duration, (timer) {
      if (_currentStep < _routePoints.length - 1) {
        _currentStep++;
        _currentDeliveryBoyPosition = _routePoints[_currentStep];
        _updateDeliveryBoyMarker();
        notifyListeners();
      } else {
        _stopAnimation();
        _onDestinationReached();
      }
    });
  }

  void _onDestinationReached() {
    _status = DeliveryStatus.destinationReached;
    notifyListeners();
  }

  void _stopAnimation() {
    _animationTimer?.cancel();
    _animationTimer = null;
  }

  void resetDelivery() {
    _stopAnimation();
    _status = DeliveryStatus.waitingForAcceptance;
    // _routePoints.clear();
    _routePoints = [];
    _polylines.clear();
    _markers.clear();
    _currentStep = 0;
    _currentDeliveryBoyPosition = null;
    initializeOrder();
    notifyListeners();
  }

  @override
  void dispose() {
    _stopAnimation();
    super.dispose();
  }
}

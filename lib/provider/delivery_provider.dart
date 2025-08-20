// import 'package:delivery_boy_app/models/order_model.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// enum DeliveryStatus {
//   waitingForAcceptance,
//   orderAccepted,
//   pickingUp,
//   destinationReached,
//   enRoute,
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
//       pickupLocation: const LatLng(27.7033, 85.3066), // Kathmandu Durbar Square
//       deliveryLocation: const LatLng(27.6710, 85.3250), // Patan Durbar Square
//       pickupAddress: "Kathmandu Durbar Square",
//       deliveryAddress: "Patan Durbar Square",
//     );
//     _status = DeliveryStatus.waitingForAcceptance;
//     notifyListeners(); // Make sure to notify listeners after setting the order
//   }
//   void acceptOrder() {
//     _status = DeliveryStatus.orderAccepted;
//     _generateRoutePoints(); // Make sure this is called
//     notifyListeners();
//   }

//   void rejectOrder() {
//     _status = DeliveryStatus.rejected;
//     _routePoints.clear();
//     _currentDeliveryBoyPosition = null;
//     notifyListeners();
//   }
//   void startPickup() {
//     _status = DeliveryStatus.pickingUp; // Change to pickingUp status
//     _currentDeliveryBoyPosition = _currentOrder!.pickupLocation;
//     notifyListeners();

//     // Don't automatically start delivery here
//     // Wait for user to click "Mark as Picked Up"
//   }

//   // Add this new method to handle when user clicks "Mark as Picked Up"
//   void markAsPickedUp() {
//     _status = DeliveryStatus.enRoute;
//     _isAnimating = true;
//     _animateDeliveryBoy();
//     notifyListeners();
//   }

//   void startDelivery() {
//     _status = DeliveryStatus.enRoute;
//     _isAnimating = true;
//     _animateDeliveryBoy();
//     notifyListeners();
//   }
//   void markDestinationReached() {
//     _status = DeliveryStatus.destinationReached;
//     _isAnimating = false;
//     notifyListeners();
//   }

//   void markAsDelivered() {
//     _status = DeliveryStatus.delivered;
//     _isAnimating = false;
//     notifyListeners();
//   }

//   void _generateRoutePoints() {
//     // Simulate route points between pickup and delivery
//     // In real app, you would use Google Directions API
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
//       await Future.delayed(const Duration(seconds: 2));

//       if (_isAnimating) {
//         _currentRouteIndex++;
//         _currentDeliveryBoyPosition = _routePoints[_currentRouteIndex];

//         if (_currentRouteIndex == _routePoints.length - 1) {
//           // Reached destination
//           await Future.delayed(const Duration(seconds: 1));
//           markDestinationReached(); // Changed from markAsDelivered()
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

// enum DeliveryStatus {
//   waitingForAcceptance,
//   orderAccepted,
//   pickingUp,
//   destinationReached,
//   enRoute,
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
//       pickupLocation: const LatLng(27.7033, 85.3066), // Kathmandu Durbar Square
//       deliveryLocation: const LatLng(27.6710, 85.3250), // Patan Durbar Square
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

//   // Call this when delivery boy reaches destination
//   void markDestinationReached() {
//     _status = DeliveryStatus.destinationReached;
//     _isAnimating = false;
//     notifyListeners();
//   }

//   // Call this when "Mark as Delivered" button is clicked
//   void markAsDelivered() {
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
//       await Future.delayed(const Duration(seconds: 2));

//       if (_isAnimating) {
//         _currentRouteIndex++;
//         _currentDeliveryBoyPosition = _routePoints[_currentRouteIndex];

//         if (_currentRouteIndex == _routePoints.length - 1) {
//           // Reached destination
//           await Future.delayed(const Duration(seconds: 1));
//           markDestinationReached();
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
import 'package:delivery_boy_app/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum DeliveryStatus {
  waitingForAcceptance,
  orderAccepted,
  pickingUp,
  destinationReached,
  enRoute,
  markingAsDelivered, // New status
  delivered,
  rejected,
}

class DeliveryProvider extends ChangeNotifier {
  DeliveryStatus _status = DeliveryStatus.waitingForAcceptance;
  OrderModel? _currentOrder;
  List<LatLng> _routePoints = [];
  int _currentRouteIndex = 0;
  LatLng? _currentDeliveryBoyPosition;
  bool _isAnimating = false;

  // Getters
  DeliveryStatus get status => _status;
  OrderModel? get currentOrder => _currentOrder;
  List<LatLng> get routePoints => _routePoints;
  LatLng? get currentDeliveryBoyPosition => _currentDeliveryBoyPosition;
  bool get isAnimating => _isAnimating;
  int get currentRouteIndex => _currentRouteIndex;

  void initializeOrder() {
    _currentOrder = OrderModel(
      id: "ORD123",
      customerName: "John Doe",
      customerPhone: "014542765",
      item: "Tender Coconut (Normal)",
      quantity: 4,
      price: 320,
      pickupLocation: const LatLng(27.7033, 85.3066), // Kathmandu Durbar Square
      deliveryLocation: const LatLng(27.6710, 85.3250), // Patan Durbar Square
      pickupAddress: "Kathmandu Durbar Square",
      deliveryAddress: "Patan Durbar Square",
    );
    _status = DeliveryStatus.waitingForAcceptance;
    notifyListeners();
  }

  void acceptOrder() {
    _status = DeliveryStatus.orderAccepted;
    _generateRoutePoints();
    notifyListeners();
  }

  void rejectOrder() {
    _status = DeliveryStatus.rejected;
    _routePoints.clear();
    _currentDeliveryBoyPosition = null;
    notifyListeners();
  }

  // NEW: Call this when navigating to DeliveryMapScreen
  void startPickup() {
    _status = DeliveryStatus.pickingUp;
    _currentDeliveryBoyPosition = _currentOrder!.pickupLocation;
    notifyListeners();
  }

  // Call this when "Mark as Picked Up" button is clicked
  void markAsPickedUp() {
    _status = DeliveryStatus.enRoute;
    _isAnimating = true;
    _animateDeliveryBoy();
    notifyListeners();
  }

  // This is called automatically when marker reaches destination
  void _onDestinationReached() {
    _status = DeliveryStatus.destinationReached;
    _isAnimating = false;
    notifyListeners();
  }

  // Call this when user clicks "Mark as Destination Reached" button
  void markDestinationReached() {
    // This just acknowledges that destination was reached
    // Icons and status remain the same until markAsDelivered is called
    notifyListeners();
  }

  // Call this when "Mark as Delivered" button is clicked (first time)
  void markAsDelivered() {
    _status = DeliveryStatus.markingAsDelivered;
    _isAnimating = false;
    notifyListeners();
  }

  // Call this when "Marking as Delivered..." button is clicked (second time)
  void completeDelivery() {
    _status = DeliveryStatus.delivered;
    _isAnimating = false;
    notifyListeners();
  }

  void _generateRoutePoints() {
    if (_currentOrder == null) return;

    final pickup = _currentOrder!.pickupLocation;
    final delivery = _currentOrder!.deliveryLocation;

    _routePoints = [
      pickup,
      LatLng(pickup.latitude + 0.01, pickup.longitude + 0.01),
      LatLng(pickup.latitude + 0.02, pickup.longitude + 0.015),
      LatLng(delivery.latitude - 0.01, delivery.longitude - 0.01),
      delivery,
    ];

    _currentDeliveryBoyPosition = pickup;
    _currentRouteIndex = 0;
  }

  void _animateDeliveryBoy() async {
    if (!_isAnimating || _routePoints.isEmpty) return;

    while (_currentRouteIndex < _routePoints.length - 1 && _isAnimating) {
      await Future.delayed(const Duration(seconds: 2));

      if (_isAnimating) {
        _currentRouteIndex++;
        _currentDeliveryBoyPosition = _routePoints[_currentRouteIndex];

        if (_currentRouteIndex == _routePoints.length - 1) {
          // Reached destination - just stop animation, don't change icons yet
          await Future.delayed(const Duration(seconds: 1));
          _onDestinationReached(); // Use the private method
        }

        notifyListeners();
      }
    }
  }

  void resetDelivery() {
    _status = DeliveryStatus.waitingForAcceptance;
    _routePoints.clear();
    _currentRouteIndex = 0;
    _currentDeliveryBoyPosition = null;
    _isAnimating = false;
    initializeOrder();
    notifyListeners();
  }
}

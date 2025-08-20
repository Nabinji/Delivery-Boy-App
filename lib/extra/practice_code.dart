import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => MapProvider(),
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Delivery Tracker',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         scaffoldBackgroundColor: Colors.grey[100],
//       ),
//       home: const DeliveryMapScreen(),
//     );
//   }
// }

class MapProvider with ChangeNotifier {
  // Kathmandu Durbar Square
  LatLng pickupLocation = const LatLng(27.7033, 85.3066);
  // Patan Durbar Square
  LatLng deliveryLocation = const LatLng(27.6710, 85.3250);
  LatLng? deliveryBoyPosition;
  Set<Polyline> polylines = {};
  Set<Marker> markers = {};
  bool orderAccepted = false;
  bool inProgress = false;
  int currentStep = 0;
  List<LatLng> routePoints = [];

  // Hardcoded route points (pre-calculated using Directions API)
  // static const List<LatLng> _preCalculatedRoute = [
  //   LatLng(27.7033, 85.3066),
  //   LatLng(27.7020, 85.3078),
  //   LatLng(27.7005, 85.3101),
  //   LatLng(27.6980, 85.3135),
  //   LatLng(27.6950, 85.3160),
  //   LatLng(27.6915, 85.3190),
  //   LatLng(27.6880, 85.3220),
  //   LatLng(27.6845, 85.3235),
  //   LatLng(27.6810, 85.3245),
  //   LatLng(27.6780, 85.3250),
  //   LatLng(27.6750, 85.3252),
  //   LatLng(27.6710, 85.3250),
  // ];

  Future<void> acceptOrder() async {
    orderAccepted = true;
    inProgress = true;
    deliveryBoyPosition = pickupLocation;
    // routePoints = _preCalculatedRoute;

    // Add route polyline
    polylines.add(
      Polyline(
        polylineId: const PolylineId('deliveryRoute'),
        points: routePoints,
        color: Colors.blue,
        width: 5,
      ),
    );

    // Add markers
    markers.add(
      Marker(
        markerId: const MarkerId('pickup'),
        position: pickupLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: const InfoWindow(title: 'Pickup Location'),
      ),
    );

    markers.add(
      Marker(
        markerId: const MarkerId('delivery'),
        position: deliveryLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: const InfoWindow(title: 'Delivery Location'),
      ),
    );

    notifyListeners();
    startDeliverySimulation();
  }

  void rejectOrder() {
    orderAccepted = false;
    inProgress = false;
    polylines.clear();
    markers.clear();
    deliveryBoyPosition = null;
    currentStep = 0;
    notifyListeners();
  }

  void startDeliverySimulation() {
    const duration = Duration(milliseconds: 300);
    Timer.periodic(duration, (timer) {
      if (currentStep < routePoints.length - 1) {
        currentStep++;
        deliveryBoyPosition = routePoints[currentStep];

        // Update delivery boy marker
        markers.removeWhere((m) => m.markerId.value == 'deliveryBoy');
        markers.add(
          Marker(
            markerId: const MarkerId('deliveryBoy'),
            position: deliveryBoyPosition!,
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueBlue,
            ),
            rotation: _calculateBearing(
              routePoints[currentStep - 1],
              routePoints[currentStep],
            ),
            infoWindow: const InfoWindow(title: 'Delivery Partner'),
          ),
        );

        notifyListeners();
      } else {
        timer.cancel();
        inProgress = false;
        notifyListeners();
      }
    });
  }

  double _calculateBearing(LatLng begin, LatLng end) {
    double lat1 = begin.latitude * (3.1415926535 / 180);
    double lon1 = begin.longitude * (3.1415926535 / 180);
    double lat2 = end.latitude * (3.1415926535 / 180);
    double lon2 = end.longitude * (3.1415926535 / 180);

    double y = sin(lon2 - lon1) * cos(lat2);
    double x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(lon2 - lon1);
    return (atan2(y, x) * (180 / 3.1415926535) + 360) % 360;
  }
}

class DeliveryMapScreen extends StatefulWidget {
  const DeliveryMapScreen({super.key});

  @override
  State<DeliveryMapScreen> createState() => _DeliveryMapScreenState();
}

class _DeliveryMapScreenState extends State<DeliveryMapScreen> {
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Driver Home'), centerTitle: true),
      body: Consumer<MapProvider>(
        builder: (context, provider, child) {
          return Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: provider.pickupLocation,
                  zoom: 14,
                ),
                onMapCreated: (controller) => mapController = controller,
                polylines: provider.polylines,
                markers: provider.markers,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                onCameraMove: (position) {
                  if (provider.deliveryBoyPosition != null &&
                      provider.inProgress) {
                    mapController.animateCamera(
                      CameraUpdate.newLatLng(provider.deliveryBoyPosition!),
                    );
                  }
                },
              ),
              if (!provider.orderAccepted)
                Positioned(
                  bottom: 100,
                  left: 20,
                  right: 20,
                  child: _orderInfoCard(provider),
                ),
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Row(
                  children: [
                    if (!provider.orderAccepted) ...[
                      Expanded(
                        child: _actionButton(
                          'Reject Order',
                          Colors.red,
                          () => provider.rejectOrder(),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _actionButton(
                          'Accept Order',
                          Colors.green,
                          () => provider.acceptOrder(),
                        ),
                      ),
                    ] else if (provider.inProgress) ...[
                      Expanded(
                        child: _actionButton(
                          'In Progress...',
                          Colors.blue,
                          () {},
                        ),
                      ),
                    ] else ...[
                      Expanded(
                        child: _actionButton(
                          'Delivery Complete',
                          Colors.green,
                          () {},
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _orderInfoCard(MapProvider provider) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'New Order Available',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '¥320',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Tender Coconut (Normal) × 4',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Row(
              children: const [
                Icon(Icons.upload, size: 16, color: Colors.green),
                SizedBox(width: 8),
                Text('Pickup - Thamai, Kathmandu - 1.2 km...'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: const [
                Icon(Icons.download, size: 16, color: Colors.red),
                SizedBox(width: 8),
                Text('Delivery - Lazimpat, Kathmandu - 3.5 km...'),
              ],
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text('View order details'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionButton(String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}

import 'package:delivery_boy_app/provider/delivery_provider.dart';
import 'package:delivery_boy_app/screen/app_main_screen.dart';
import 'package:delivery_boy_app/utils/colors.dart';
import 'package:delivery_boy_app/widgets/custom_button.dart';
import 'package:delivery_boy_app/widgets/order_on_the_way.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class DeliveryMapScreen extends StatefulWidget {
  const DeliveryMapScreen({super.key});

  @override
  State<DeliveryMapScreen> createState() => _DeliveryMapScreenState();
}

class _DeliveryMapScreenState extends State<DeliveryMapScreen> {
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Consumer<DeliveryProvider>(
        builder: (context, provider, child) {
          // print(
          //   "DeliveryMapScreen - Status: ${provider.status}, Order: ${provider.currentOrder != null}",
          // );
          // print("Route points: ${provider.routePoints.length}");
          return Stack(
            children: [
              // Google Map
              _buildGoogleMap(provider),

              // if ((provider.status == DeliveryStatus.orderAccepted ||
              //         provider.status == DeliveryStatus.pickingUp ||
              //         provider.status == DeliveryStatus.enRoute ||
              //         provider.status == DeliveryStatus.destinationReached ||
              //         provider.status == DeliveryStatus.delivered) &&
              //     provider.currentOrder != null)
              //   _buildOrderCard(provider),
              // In your DeliveryMapScreen, update the condition that shows OrderOnTheWay widget
              // Replace your current condition with this:
              Consumer<DeliveryProvider>(
                builder: (context, provider, child) {
                  if (provider.currentOrder == null) return SizedBox();

                  // Show OrderOnTheWay for all delivery statuses except rejected
                  if (provider.status == DeliveryStatus.rejected) {
                    return SizedBox();
                  }

                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: OrderOnTheWay(
                        order: provider.currentOrder!,
                        status: provider.status,
                        onButtonPressed: () {
                          switch (provider.status) {
                            case DeliveryStatus.pickingUp:
                              provider.markAsPickedUp();
                              break;
                            case DeliveryStatus.destinationReached:
                              // When user clicks "Mark as Destination Reached"
                              provider.markAsDelivered();
                              break;
                            case DeliveryStatus.markingAsDelivered:
                              // When user clicks "Mark as Delivered"
                              provider.completeDelivery();

                              break;
                            default:
                              break;
                          }
                        },
                      ),
                    ),
                  );
                },
              ),

              // Delivery Complete Card
              if (provider.status == DeliveryStatus.delivered)
                _buildDeliveryCompleteCard(provider),
            ],
          );
        },
      ),
    );
  }

  Widget _buildGoogleMap(DeliveryProvider provider) {
    return GoogleMap(
      onMapCreated: (GoogleMapController controller) {
        _mapController = controller;
        if (provider.currentOrder != null) {
          _moveToLocation(provider.currentOrder!.pickupLocation);
        }
      },
      initialCameraPosition: const CameraPosition(
        target: LatLng(27.7033, 85.3066),
        zoom: 14.0,
      ),
      markers: _buildMarkers(provider),
      polylines: _buildPolylines(provider),
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
    );
  }

  Set<Marker> _buildMarkers(DeliveryProvider provider) {
    Set<Marker> markers = {};

    if (provider.currentOrder != null) {
      // Pickup marker
      markers.add(
        Marker(
          markerId: const MarkerId('pickup'),
          position: provider.currentOrder!.pickupLocation,
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
          infoWindow: const InfoWindow(title: 'Pickup Location'),
        ),
      );

      // Delivery marker
      markers.add(
        Marker(
          markerId: const MarkerId('delivery'),
          position: provider.currentOrder!.deliveryLocation,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: const InfoWindow(title: 'Delivery Location'),
        ),
      );

      // Delivery boy marker (when moving)
      if (provider.currentDeliveryBoyPosition != null) {
        markers.add(
          Marker(
            markerId: const MarkerId('delivery_boy'),
            position: provider.currentDeliveryBoyPosition!,
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueBlue,
            ),
            infoWindow: const InfoWindow(title: 'Delivery Boy'),
          ),
        );
        // Move camera to follow delivery boy
        _moveToLocation(provider.currentDeliveryBoyPosition!);
      }
    }

    return markers;
  }

  Set<Polyline> _buildPolylines(DeliveryProvider provider) {
    Set<Polyline> polylines = {};

    // Show polyline when order is accepted or later
    if (provider.routePoints.isNotEmpty &&
        provider.status != DeliveryStatus.waitingForAcceptance &&
        provider.status != DeliveryStatus.rejected) {
      polylines.add(
        Polyline(
          polylineId: const PolylineId('route'),
          points: provider.routePoints,
          color: buttonMainColor,
          width: 6,
          // patterns: [PatternItem.dash(10), PatternItem.gap(10)],
        ),
      );
    }

    return polylines;
  }

  // Widget _buildOrderCard(DeliveryProvider provider) {
  //   if (provider.currentOrder == null) {
  //     return const SizedBox.shrink();
  //   }

  //   return Positioned(
  //     bottom: 0,
  //     left: 0,
  //     right: 0,
  //     child: Consumer<DeliveryProvider>(
  //       builder: (context, provider, child) {
  //         if (provider.currentOrder == null) return SizedBox();

  //         return OrderOnTheWay(
  //           order: provider.currentOrder!,
  //           status: provider.status,
  //           onButtonPressed: () {
  //             switch (provider.status) {
  //               case DeliveryStatus.pickingUp:
  //                 provider.markAsPickedUp();
  //                 break;
  //               case DeliveryStatus.destinationReached:
  //                 // When user clicks "Mark as Destination Reached"
  //                 provider
  //                     .markAsDelivered(); // This changes to "Mark as Delivered" button
  //                 break;
  //               case DeliveryStatus.markingAsDelivered:
  //                 // When user clicks "Mark as Delivered"
  //                 provider
  //                     .completeDelivery(); // This shows success and disables button
  //                 // Show success message
  //                 ScaffoldMessenger.of(context).showSnackBar(
  //                   SnackBar(
  //                     content: Text('Order delivered successfully!'),
  //                     backgroundColor: Colors.green,
  //                     duration: Duration(seconds: 3),
  //                   ),
  //                 );
  //                 break;
  //               default:
  //                 break;
  //             }
  //           },
  //         );
  //       },
  //     ),
  //   );
  // }

  // void _handleButtonPress(DeliveryProvider provider) {
  //   switch (provider.status) {
  //     case DeliveryStatus.orderAccepted:
  //       provider.startPickup(); // Changes status to pickingUp
  //       break;
  //     case DeliveryStatus.pickingUp:
  //       provider.markAsPickedUp(); // Start delivery animation
  //       break;
  //     case DeliveryStatus.destinationReached:
  //       provider.markAsDelivered(); // Change to delivered state
  //       break;
  //     case DeliveryStatus.delivered:
  //       _buildDeliveryCompleteCard(provider); // Show success dialog
  //       break;
  //     default:
  //       break;
  //   }
  // }

  Widget _buildDeliveryCompleteCard(DeliveryProvider provider) {
    return Positioned.fill(
      child: Container(
        color: Colors.black54,
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        "https://media.tenor.com/bm8Q6yAlsPsAAAAj/verified.gif",
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Delivery Complete',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Great job! Your delivery has been successfully completed.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    title: 'Go Home',
                    onPressed: () {
                      Navigator.of(context).pop(); // Close dialog
                      provider.resetDelivery();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AppMainScreen(),
                        ),
                        (route) => false,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _moveToLocation(LatLng location) {
    _mapController?.animateCamera(CameraUpdate.newLatLngZoom(location, 14));
  }
}

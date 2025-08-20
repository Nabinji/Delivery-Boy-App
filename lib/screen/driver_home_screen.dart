import 'package:delivery_boy_app/provider/current_location_provider.dart';
import 'package:delivery_boy_app/provider/delivery_provider.dart';
import 'package:delivery_boy_app/utils/utils.dart';
import 'package:delivery_boy_app/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  _DriverHomeScreenState createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  GoogleMapController? mapController;
  bool isOnline = true;
  // Initialize screen - create a new order when screen loads
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DeliveryProvider>().initializeOrder();
    });
  }
  // Callback when Google Map is ready
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // Create markers for current location on map
  Set<Marker> _buildMarkers(LatLng currentLocation) {
    return {
      Marker(
        markerId: MarkerId('current_location'),
        position: currentLocation,
        infoWindow: InfoWindow(
          title: 'Current Location',
          snippet: 'You are here!',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CurrentLocationProvider>(
        builder: (context, locationProvider, child) {
            // Show loading spinner while getting location
          if (locationProvider.isLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Getting your location...'),
                ],
              ),
            );
          }
          //show error message after permission denied
          if (locationProvider.errorMessage.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showAppSnackbar(
                context: context,
                type: SnackbarType.error,
                description: locationProvider.errorMessage,
              );
            });
          }
          Size size = MediaQuery.of(context).size;
          return Stack(
            children: [
              // display the google map
              GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: locationProvider.currentLocation,
                  zoom: 15.0,
                ),
                markers: _buildMarkers(locationProvider.currentLocation),
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: true,
                zoomGesturesEnabled: true,
                scrollGesturesEnabled: true,
                tiltGesturesEnabled: true,
                rotateGesturesEnabled: true,
                mapType: MapType.normal,
              ),
              
              if(locationProvider.errorMessage.isEmpty)
               // Show order card at bottom (only if no location error/ show only if location permission is garented)
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: OrderCard(), // Widget showing order details and buttons
                ),
              ),
              // show static online button at the top 
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: size.height * 0.12,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Center(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: 200,
                          height: 38,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.red, width: 2),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Row(
                              children: [
                                // Online Button
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Online",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(child: SizedBox()),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
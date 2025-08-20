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
  final Set<Marker> _markers = {};
  bool isOnline = true;
// In DriverHomeScreen initState:
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DeliveryProvider>().initializeOrder();
    });
  }
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _addMarker(LatLng position) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('current_location'),
          position: position,
          infoWindow: InfoWindow(
            title: 'Current Location',
            snippet: 'You are here!',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CurrentLocationProvider>(
        builder: (context, locationProvider, child) {
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

          // Add marker for current location
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _addMarker(locationProvider.currentLocation);
          });
          Size size = MediaQuery.of(context).size;
          return Stack(
            children: [
              GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: locationProvider.currentLocation,
                  zoom: 15.0,
                ),
                markers: _markers,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: true,
                zoomGesturesEnabled: true,
                scrollGesturesEnabled: true,
                tiltGesturesEnabled: true,
                rotateGesturesEnabled: true,
                mapType: MapType.normal,
              ),
              if (locationProvider.errorMessage.isNotEmpty)
                showAppSnackbar(
                  context: context,
                  type: SnackbarType.error,
                  description: "Location Permission Denied",
                ),
                Align(alignment: Alignment.bottomCenter, 
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: OrderCard(),
                ),
                ),
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
                                        color: Colors.white,fontSize: 16,fontWeight: FontWeight.w500
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

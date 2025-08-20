// import 'package:delivery_boy_app/models/order_model.dart';
// import 'package:delivery_boy_app/provider/delivery_provider.dart';
// import 'package:delivery_boy_app/utils/colors.dart';
// import 'package:delivery_boy_app/widgets/custom_button.dart';
// import 'package:flutter/material.dart';

// class OrderOnTheWay extends StatelessWidget {
//   final OrderModel order;
//   final DeliveryStatus status;
//   final VoidCallback? onButtonPressed;

//   const OrderOnTheWay({
//     super.key,
//     required this.order,
//     required this.status,
//     this.onButtonPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(25),
//       ),
//       child: Column(
//         children: [
//           ListTile(
//             leading: Icon(_getPickupIcon(), color: _getPickupIconColor()),
//             title: Text(
//               "Pickup Location",
//               style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
//             ),
//             subtitle: Text(order.pickupAddress),
//             trailing: CircleAvatar(
//               radius: 18,
//               backgroundColor: iconColor,
//               child: Icon(Icons.phone, color: Colors.white),
//             ),
//           ),
//           ListTile(
//             leading: Icon(_getDeliveryIcon(), color: _getDeliveryIconColor()),
//             title: Text(
//               "Delivery - ${order.customerName}",
//               style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
//             ),
//             subtitle: Text(order.deliveryAddress),
//             trailing: CircleAvatar(
//               radius: 18,
//               backgroundColor: iconColor,
//               child: Icon(Icons.phone, color: Colors.white),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: SizedBox(
//               width: double.maxFinite,
//               child: CustomButton(
//                 title: _getButtonTitle(),
//                 onPressed: _isButtonEnabled()
//                     ? (onButtonPressed ?? () {})
//                     : () {},
//                 color: _getButtonColor(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Color _getButtonColor() {
//     switch (status) {
//       case DeliveryStatus.orderAccepted:
//         return Colors.red; // Red for "Start Pickup"
//       case DeliveryStatus.pickingUp:
//       case DeliveryStatus.enRoute:
//         return Colors
//             .orange; // Orange for "Mark as Picked Up" and "Delivering..."
//       case DeliveryStatus.destinationReached:
//         return Colors.orange; // Orange for "Mark as Destination Reached"
//       case DeliveryStatus.delivered:
//         return Colors.red; // Red for "Mark as Delivered"
//       default:
//         return Colors.red;
//     }
//   }

//   String _getButtonTitle() {
//     switch (status) {
//       case DeliveryStatus.pickingUp:
//         return "Mark as Picked Up";
//       case DeliveryStatus.enRoute:
//         return "Delivering...";
//       case DeliveryStatus.destinationReached:
//         return "Mark as Destination Reached";
//       case DeliveryStatus.delivered:
//         return "Mark as Delivered";
//       default:
//         return "Start Pickup";
//     }
//   }

//   bool _isButtonEnabled() {
//     switch (status) {
//       case DeliveryStatus.enRoute:
//         return false; // Disabled only during delivery animation
//       default:
//         return true;
//     }
//   }

//   IconData _getPickupIcon() {
//     switch (status) {
//       case DeliveryStatus.pickingUp:
//       case DeliveryStatus.enRoute:
//       case DeliveryStatus.destinationReached:
//       case DeliveryStatus.delivered:
//         return Icons.check_circle; // Green check when picked up
//       default:
//         return Icons.radio_button_checked;
//     }
//   }

//   Color _getPickupIconColor() {
//     switch (status) {
//       case DeliveryStatus.pickingUp:
//       case DeliveryStatus.enRoute:
//       case DeliveryStatus.destinationReached:
//       case DeliveryStatus.delivered:
//         return Colors.green; // Green when picked up
//       default:
//         return Colors.grey;
//     }
//   }

//   IconData _getDeliveryIcon() {
//     switch (status) {
//       case DeliveryStatus.delivered:
//         return Icons.check_circle; // Check when delivered
//       case DeliveryStatus.destinationReached:
//         return Icons.check_circle; // Check when destination reached
//       default:
//         return Icons.location_on; // Location pin before delivery
//     }
//   }

//   Color _getDeliveryIconColor() {
//     switch (status) {
//       case DeliveryStatus.delivered:
//         return Colors.green; // Green when delivered
//       case DeliveryStatus.destinationReached:
//         return Colors.green; // Green when destination reached
//       default:
//         return Colors.red; // Red location pin
//     }
//   }
// }

// import 'package:delivery_boy_app/models/order_model.dart';
// import 'package:delivery_boy_app/provider/delivery_provider.dart';
// import 'package:delivery_boy_app/utils/colors.dart';
// import 'package:delivery_boy_app/widgets/custom_button.dart';
// import 'package:flutter/material.dart';

// class OrderOnTheWay extends StatelessWidget {
//   final OrderModel order;
//   final DeliveryStatus status;
//   final VoidCallback? onButtonPressed;

//   const OrderOnTheWay({
//     super.key,
//     required this.order,
//     required this.status,
//     this.onButtonPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(25),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           ListTile(
//             leading: Icon(_getPickupIcon(), color: _getPickupIconColor()),
//             title: Text(
//               "Pickup Location",
//               style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
//             ),
//             subtitle: Text(order.pickupAddress),
//             trailing: CircleAvatar(
//               radius: 18,
//               backgroundColor: iconColor,
//               child: Icon(Icons.phone, color: Colors.white),
//             ),
//           ),
//           ListTile(
//             leading: Icon(_getDeliveryIcon(), color: _getDeliveryIconColor()),
//             title: Text(
//               "Delivery - ${order.customerName}",
//               style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
//             ),
//             subtitle: Text(order.deliveryAddress),
//             trailing: CircleAvatar(
//               radius: 18,
//               backgroundColor: iconColor,
//               child: Icon(Icons.phone, color: Colors.white),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: SizedBox(
//               width: double.maxFinite,
//               child: CustomButton(
//                 title: _getButtonTitle(),
//                 //  onPressed: _isButtonEnabled()
//                 //     ? (onButtonPressed ?? () {})
//                 //     : () {},
//                 onPressed: _isButtonEnabled()
//                     ? (onButtonPressed ?? () {})
//                     : null, // Set to null to disable button
//                 color: _getButtonColor(),
//               ),
//             ), // the arugument type void Function()? can't be assigen to the parameter type VoidCallback.
//           ),
//         ],
//       ),
//     );
//   }

//   Color _getButtonColor() {
//     switch (status) {
//       case DeliveryStatus.pickingUp:
//         return Colors.orange; // Orange for "Mark as Picked Up"
//       case DeliveryStatus.enRoute:
//         return Colors.orange; // Orange for "Delivering..." (disabled)
//       case DeliveryStatus.destinationReached:
//         return Colors.orange; // Orange for "Mark as Destination Reached"
//       case DeliveryStatus.delivered:
//         return Colors.red.withOpacity(
//           0.5,
//         ); // Red with opacity for disabled look
//       default:
//         return Colors.red;
//     }
//   }

//   String _getButtonTitle() {
//     switch (status) {
//       case DeliveryStatus.pickingUp:
//         return "Mark as Picked Up";
//       case DeliveryStatus.enRoute:
//         return "Delivering...";
//       case DeliveryStatus.destinationReached:
//         return "Mark as Destination Reached";
//       case DeliveryStatus.delivered:
//         return "Marking as Delivered...";
//       default:
//         return "Start Pickup";
//     }
//   }

//   bool _isButtonEnabled() {
//     switch (status) {
//       case DeliveryStatus.enRoute:
//       case DeliveryStatus.delivered:
//         return false; // Disabled during delivery animation and after delivered
//       default:
//         return true;
//     }
//   }

//   IconData _getPickupIcon() {
//     switch (status) {
//       case DeliveryStatus.enRoute:
//       case DeliveryStatus.destinationReached:
//       case DeliveryStatus.delivered:
//         return Icons.check_circle; // Green check when picked up
//       default:
//         return Icons.radio_button_checked;
//     }
//   }

//   Color _getPickupIconColor() {
//     switch (status) {
//       case DeliveryStatus.enRoute:
//       case DeliveryStatus.destinationReached:
//       case DeliveryStatus.delivered:
//         return Colors.green; // Green when picked up
//       default:
//         return Colors.grey;
//     }
//   }

//   IconData _getDeliveryIcon() {
//     switch (status) {
//       case DeliveryStatus.delivered:
//         return Icons.check_circle; // Check when delivered
//       case DeliveryStatus.destinationReached:
//         return Icons.check_circle; // Check when destination reached
//       default:
//         return Icons.location_on; // Location pin before delivery
//     }
//   }

//   Color _getDeliveryIconColor() {
//     switch (status) {
//       case DeliveryStatus.delivered:
//         return Colors.green; // Green when delivered
//       case DeliveryStatus.destinationReached:
//         return Colors.green; // Green when destination reached
//       default:
//         return Colors.red; // Red location pin
//     }
//   }
// }

import 'package:delivery_boy_app/models/order_model.dart';
import 'package:delivery_boy_app/provider/delivery_provider.dart';
import 'package:delivery_boy_app/utils/colors.dart';
import 'package:delivery_boy_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class OrderOnTheWay extends StatelessWidget {
  final OrderModel order;
  final DeliveryStatus status;
  final VoidCallback? onButtonPressed;

  const OrderOnTheWay({
    super.key,
    required this.order,
    required this.status,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: ,
        children: [
          SizedBox(height: 10),
          Container(
            height: 5,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.black26,
            ),
          ),
          ListTile(
            leading: Icon(_getPickupIcon(), color: _getPickupIconColor()),
            title: Text(
              "Pickup Location",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            subtitle: Text(order.pickupAddress),
            trailing: CircleAvatar(
              radius: 18,
              backgroundColor: iconColor,
              child: Icon(Icons.phone, color: Colors.white),
            ),
          ),
          ListTile(
            leading: Icon(_getDeliveryIcon(), color: _getDeliveryIconColor()),
            title: Text(
              "Delivery - ${order.customerName}",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            subtitle: Text(order.deliveryAddress),
            trailing: CircleAvatar(
              radius: 18,
              backgroundColor: iconColor,
              child: Icon(Icons.phone, color: Colors.white),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(width: double.maxFinite, child: _buttonStyle()),
          ),
        ],
      ),
    );
  }

  Widget _buttonStyle() {
    switch (status) {
      case DeliveryStatus.destinationReached:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: GestureDetector(
            onTap: _isButtonEnabled()
                ? (onButtonPressed ?? () {})
                : () {},
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 11),
                    decoration: BoxDecoration(
                      color: pickedUpColor.withAlpha(170),
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(30),
                      ),
                    ),
                    child: Icon(Icons.arrow_forward, color: Colors.white),
                  ),
                ),
                Expanded(
                  flex: 17,
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 11),
                    decoration: BoxDecoration(
                      color: _getButtonColor(),
                      borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(30),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _getButtonTitle(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      default:
        return CustomButton(
          title: _getButtonTitle(),
          onPressed: _isButtonEnabled()
              ? (onButtonPressed ?? () {})
              : () {}, // Use empty function instead of null
          color: _getButtonColor(),
        );
    }
  }

  Color _getButtonColor() {
    switch (status) {
      case DeliveryStatus.pickingUp:
        return pickedUpColor; // Orange for "Mark as Picked Up"
      case DeliveryStatus.enRoute:
        // Orange with opacity for "Delivering..." (disabled)
        return Colors.orange.withAlpha(150);
      case DeliveryStatus.destinationReached:
        return pickedUpColor; // Orange for "Mark as Destination Reached"
      case DeliveryStatus.markingAsDelivered:
        return buttonMainColor; // Red for "Mark as Delivered"
      case DeliveryStatus.delivered:
        return Colors.red.withAlpha(150); // Red with opacity for disabled look
      default:
        return buttonMainColor;
    }
  }

  String _getButtonTitle() {
    switch (status) {
      case DeliveryStatus.pickingUp:
        return "Mark as Picked Up";
      case DeliveryStatus.enRoute:
        return "Delivering...";
      case DeliveryStatus.destinationReached:
        return "Mark as Destination Reached";
      case DeliveryStatus.markingAsDelivered:
        return "Mark as Delivered";
      case DeliveryStatus.delivered:
        return "Marking as Delivered...";
      default:
        return "Start Pickup";
    }
  }

  bool _isButtonEnabled() {
    switch (status) {
      case DeliveryStatus.enRoute:
      case DeliveryStatus.delivered:
        return false; // Disabled during delivery animation and after final delivered
      default:
        return true;
    }
  }

  IconData _getPickupIcon() {
    switch (status) {
      case DeliveryStatus.enRoute:
      case DeliveryStatus.destinationReached:
      case DeliveryStatus.markingAsDelivered:
      case DeliveryStatus.delivered:
        return Icons.check_circle; // Green check when picked up
      default:
        return Icons.radio_button_checked;
    }
  }

  Color _getPickupIconColor() {
    switch (status) {
      case DeliveryStatus.enRoute:
      case DeliveryStatus.destinationReached:
      case DeliveryStatus.markingAsDelivered:
      case DeliveryStatus.delivered:
        return buttonMainColor; // Green when picked up
      default:
        return Colors.grey;
    }
  }

  IconData _getDeliveryIcon() {
    switch (status) {
      case DeliveryStatus.markingAsDelivered:
      case DeliveryStatus.delivered:
        return Icons
            .check_circle; // Check only after "Mark as Destination Reached" is clicked
      default:
        return Icons
            .location_on_outlined; // Location pin until user clicks "Mark as Destination Reached"
    }
  }

  Color _getDeliveryIconColor() {
    switch (status) {
      case DeliveryStatus.markingAsDelivered:
      case DeliveryStatus.delivered:
        return buttonMainColor; // Green only after "Mark as Destination Reached" is clicked
      default:
        return Colors
            .red; // Red location pin until user clicks "Mark as Destination Reached"
    }
  }
}

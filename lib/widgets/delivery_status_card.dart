// import 'package:delivery_boy_app/models/order_model.dart';
// import 'package:delivery_boy_app/provider/delivery_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class DeliveryStatusCard extends StatelessWidget {
//   final DeliveryStatus status;
//   final OrderModel order;
//   final VoidCallback? onStartPickup;
//   final VoidCallback? onStartDelivery;
//   final BuildContext context;

//   const DeliveryStatusCard({
//     super.key,
//     required this.status,
//     required this.order,
//     this.onStartPickup,
//     this.onStartDelivery,
//     required this.context
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             offset: const Offset(0, -5),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // Pickup Location
//           Row(
//             children: [
//               const Icon(
//                 Icons.radio_button_checked,
//                 color: Colors.red,
//                 size: 20,
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Pickup Location',
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     Text(
//                       order.pickupAddress,
//                       style: TextStyle(fontSize: 12, color: Colors.grey[600]),
//                     ),
//                   ],
//                 ),
//               ),
//               IconButton(
//                 onPressed: () {},
//                 icon: const Icon(Icons.phone, color: Colors.green),
//               ),
//             ],
//           ),

//           const SizedBox(height: 12),

//           // Delivery Location
//           Row(
//             children: [
//               const Icon(Icons.location_on, color: Colors.red, size: 20),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Delivery - ${order.customerName}',
//                       style: const TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     Text(
//                       order.deliveryAddress,
//                       style: TextStyle(fontSize: 12, color: Colors.grey[600]),
//                     ),
//                   ],
//                 ),
//               ),
//               IconButton(
//                 onPressed: () {},
//                 icon: const Icon(Icons.phone, color: Colors.green),
//               ),
//             ],
//           ),

//           const SizedBox(height: 16),

//           // Action Button
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: _getButtonAction(),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: _getButtonColor(),
//                 padding: const EdgeInsets.symmetric(vertical: 15),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               child: Text(
//                 _getButtonText(),
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // String _getButtonText() {
//   //   switch (status) {
//   //     case DeliveryStatus.orderAccepted:
//   //       return 'Start Pickup';
//   //     case DeliveryStatus.pickingUp:
//   //       return 'Mark as Picked Up';
//   //     case DeliveryStatus.enRoute:
//   //       return 'Delivering...';
//   //     default:
//   //       return 'Start Pickup';
//   //   }
//   // }
//   String _getButtonText() {
//     switch (status) {
//       case DeliveryStatus.orderAccepted:
//         return 'Start Pickup';
//       case DeliveryStatus.pickingUp:
//         return 'Mark as Picked Up';
//       case DeliveryStatus.enRoute:
//         return 'Delivering...';
//       case DeliveryStatus.destinationReached:
//         return 'Mark as Destination Reached';
//       case DeliveryStatus.delivered:
//         return 'Mark as Delivered';
//       default:
//         return 'Start Pickup';
//     }
//   }

//   Color _getButtonColor() {
//     switch (status) {
//       case DeliveryStatus.enRoute:
//         return Colors.orange;
//       default:
//         return Colors.red;
//     }
//   }
//   VoidCallback? _getButtonAction() {
//     switch (status) {
//       case DeliveryStatus.orderAccepted:
//         return onStartPickup;
//       case DeliveryStatus.pickingUp:
//         return onStartDelivery;
//       case DeliveryStatus.enRoute:
//         return null; // Button disabled during animation
//       case DeliveryStatus.destinationReached:
//         return () => context.read<DeliveryProvider>().markAsDelivered();
//       case DeliveryStatus.delivered:
//         return () => context.read<DeliveryProvider>().markAsDelivered();
//       default:
//         return null;
//     }
//   }
// }

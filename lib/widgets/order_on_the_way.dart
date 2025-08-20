import 'package:delivery_boy_app/models/order_model.dart';
import 'package:delivery_boy_app/provider/delivery_provider.dart';
import 'package:delivery_boy_app/utils/colors.dart';
import 'package:delivery_boy_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class OrderOnTheWay extends StatelessWidget {
  final OrderModel order; // Order details to display
  final DeliveryStatus status; // Current delivery status
  final VoidCallback? onButtonPressed; // Callback when button is pressed

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
           // Pickup location row with icon, text, and phone button
          ListTile(
             // Dynamic pickup icon and color according to the button stage/state
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
          // Delivery location row with icon, text, and phone button
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
  // Returns appropriate button widget based on current delivery status
  // Difference button type for  Mark as Destination Reached button and same button stype for remaining all,only change the icon and color 
  Widget _buttonStyle() {
    switch (status) {
      case DeliveryStatus.destinationReached:
      // Special button style with arrow icon when destination is reached
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: GestureDetector(
            onTap: _isButtonEnabled() ? (onButtonPressed ?? () {}) : () {},
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
      // Standard button for all other states
        return CustomButton(
          title: _getButtonTitle(),
          onPressed: _isButtonEnabled() ? (onButtonPressed ?? () {}) : () {},
          color: _getButtonColor(),
        );
    }
  }

// Returns button color based on delivery status
  Color _getButtonColor() {
    switch (status) {
      case DeliveryStatus.pickingUp:
        return pickedUpColor;
      case DeliveryStatus.enRoute:
        // Orange with opacity for "Delivering..." (disabled)
        return Colors.orange.withAlpha(150);
      case DeliveryStatus.destinationReached:
        return pickedUpColor; // Orange for "Mark as Destination Reached"
      case DeliveryStatus.markingAsDelivered:
        return buttonMainColor; // Red for "Mark as Delivered"
      case DeliveryStatus.delivered:
        return Colors.red.withAlpha(150);
      default:
        return buttonMainColor;
    }
  }
  // Returns button text based on delivery status
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
// Returns whether button should be enabled/clickable
  bool _isButtonEnabled() {
    switch (status) {
      case DeliveryStatus.enRoute:
      case DeliveryStatus.delivered:
        return false; // Disabled during delivery animation and after final delivered
      default:
        return true;
    }
  }
  // Returns appropriate icon for pickup location based on status
  IconData _getPickupIcon() {
    switch (status) {
      case DeliveryStatus.enRoute:
      case DeliveryStatus.destinationReached:
      case DeliveryStatus.markingAsDelivered:
      case DeliveryStatus.delivered:
        return Icons.check_circle; // red check icon when picked up
      default:
        return Icons.radio_button_checked;
    }
  }
// Returns color for pickup icon based on status
  Color _getPickupIconColor() {
    switch (status) {
      case DeliveryStatus.enRoute:
      case DeliveryStatus.destinationReached:
      case DeliveryStatus.markingAsDelivered:
      case DeliveryStatus.delivered:
        return buttonMainColor; // red color when picked up
      default:
        return Colors.grey;
    }
  }
  // Returns appropriate icon for pickup/delivery location based on status
  IconData _getDeliveryIcon() {
    switch (status) {
      case DeliveryStatus.markingAsDelivered:
      case DeliveryStatus.delivered:
        // Check only after "Mark as Destination Reached" is clicked
        return Icons.check_circle;
      default:
        // Location pin until user clicks "Mark as Destination Reached"
        return Icons.location_on_outlined;
    }
  }
// Returns color for pickup/delivery icon based on status
  Color _getDeliveryIconColor() {
    switch (status) {
      case DeliveryStatus.markingAsDelivered:
      case DeliveryStatus.delivered:
        return buttonMainColor; // check(completed icon) only after "Mark as Destination Reached" is clicked
      default:
        // Red location pin until user clicks "Mark as Destination Reached"
        return Colors.red;
    }
  }
}

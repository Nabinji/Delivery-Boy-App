import 'package:delivery_boy_app/screen/order_detail_screen.dart';
import 'package:delivery_boy_app/utils/colors.dart';
import 'package:delivery_boy_app/utils/utils.dart';
import 'package:delivery_boy_app/widgets/custom_button.dart';
import 'package:delivery_boy_app/widgets/dash_vertical_line.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // New Order Available Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Row(
              children: [
                const Text(
                  'New Order Available',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 15),

                Text(
                  '₹320',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: buttonMainColor,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.close),
                ),
              ],
            ),
          ),

          // Order Details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Item Info
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.brown[100],
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(tenderCoconut),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                        children: [
                          TextSpan(text: "Tender Coconut (Normal) "),
                          TextSpan(
                            text: " × 4",
                            style: TextStyle(color: Colors.black38),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // pickup and delivery
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        const Icon(
                          Icons.radio_button_checked,
                          color: Colors.black54,
                          size: 20,
                        ),
                        SizedBox(
                          height: 35, // height of the dashed line
                          child: const DashedLineVertical(
                            dashHeight: 5,
                            dashGap: 5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 4),
                    pickupAndDeliveryInfo(
                      "Pickup - ",
                      "Kathmandu Durbar Square - 1.2 km far from you",
                      "Green Valley Coconut Store",
                    ),
                  ],
                ),
                // Step 2: Delivery
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_on_outlined, color: buttonMainColor, size: 22),
                    const SizedBox(width: 5),
                    pickupAndDeliveryInfo(
                      "Delivery - ",
                      " Patan Durbar Square - 3.5 km from the pickup location",
                      "John Doe",
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                // Action Buttons
                SizedBox(
                  width: double.maxFinite,
                  child: CustomButton(
                    title: "View order details",
                   onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OrderDetailsScreen(),
                        ),
                      );
                    }
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded pickupAndDeliveryInfo(title, address, subtitle) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              Expanded(
                flex: 9,
                child: Text(
                  address,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          Text(subtitle, style: TextStyle(color: Colors.black38)),
        ],
      ),
    );
  }
}

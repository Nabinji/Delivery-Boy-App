import 'dart:math';

import 'package:delivery_boy_app/provider/delivery_provider.dart';
import 'package:delivery_boy_app/screen/delivery_map_screen.dart';
import 'package:delivery_boy_app/utils/colors.dart';
import 'package:delivery_boy_app/utils/utils.dart';
import 'package:delivery_boy_app/widgets/custom_button.dart';
import 'package:delivery_boy_app/widgets/dash_vertical_line.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Order Details"),
        centerTitle: false,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Customer Information
            Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 12),
                    child: Text(
                      "Customer Information",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                        "https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg",
                      ), // replace with customer image
                    ),
                    title: const Text(
                      "John Doe",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text("Delivery • 0145425765"),
                    trailing: CircleAvatar(
                      backgroundColor: iconColor,
                      child: Icon(Icons.phone, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            /// Order Summary
            Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order Summary",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 7),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            tenderCoconut,
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 5),
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
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.credit_card_outlined),
                        SizedBox(width: 10),
                        Text(
                          "₹ 320",
                          style: TextStyle(
                            fontSize: 16,

                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.check_circle_sharp, color: iconColor),
                        SizedBox(width: 10),
                        Text(
                          "Paid",
                          style: TextStyle(
                            fontSize: 16,
                            color: iconColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            /// Pickup & Delivery Locations
            Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Step 1: Pickup
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
                              height: 80,
                              child: const DashedLineVertical(
                                dashHeight: 5,
                                dashGap: 5,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Pickup Location",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                " Kathmandu Durbar Square",
                                style: TextStyle(fontSize: 13),
                              ),
                              SizedBox(height: 2),
                              Text(
                                "Green Valley Coconut • 0145425765",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: iconColor,
                          child: const Icon(
                            Icons.phone,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                        SizedBox(width: 20),
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.red.shade50,
                          child: Transform.rotate(
                            angle: -pi / 4,
                            child: Icon(
                              Icons.send,
                              size: 16,
                              color: buttonMainColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Step 2: Delivery
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: buttonMainColor,
                          size: 22,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Delivery Location",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                " Patan Durbar Square,\n 110008, Nepal",
                                style: TextStyle(fontSize: 13),
                              ),
                              SizedBox(height: 2),
                              Text(
                                "John Doe",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.red.shade50,
                          child: Transform.rotate(
                            angle: -pi / 4,
                            child: Icon(
                              Icons.send,
                              size: 16,
                              color: buttonMainColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // bottomNavigationBar: Consumer<DeliveryProvider>(
      //   builder: (context, provider, child) {
      //     return Container(
      //       color: Colors.white,
      //       child: Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      //         child: provider.status == DeliveryStatus.orderAccepted
      //             ? CustomButton(
      //                 title: "Start Pickup",
      //                 onPressed: () {
      //                   Navigator.pushReplacement(
      //                     context,
      //                     MaterialPageRoute(
      //                       builder: (context) => const DeliveryMapScreen(),
      //                     ),
      //                   );
      //                 },
      //               )
      //             : Row(
      //                 children: [
      //                   Expanded(
      //                     child: CustomButton(
      //                       color: declineOrder,
      //                       title: "Decline Order",
      //                       textColor: Colors.black54,
      //                       onPressed: () {
      //                         context.read<DeliveryProvider>().rejectOrder();
      //                         Navigator.pop(
      //                           context,
      //                         ); // Go back to DriverHomeScreen
      //                       },
      //                     ),
      //                   ),
      //                   SizedBox(width: 10),
      //                   Expanded(
      //                     child: CustomButton(
      //                       title: "Accept Order",
      //                       onPressed: () {
      //                         context.read<DeliveryProvider>().acceptOrder();
      //                       },
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //       ),
      //     );
      //   },
      // ),
      bottomNavigationBar: Consumer<DeliveryProvider>(
        builder: (context, provider, child) {
          return Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: provider.status == DeliveryStatus.orderAccepted
                  ? CustomButton(
                      title: "Start Pickup",
                      onPressed: () {
                        // Call startPickup() before navigation
                        context.read<DeliveryProvider>().startPickup();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DeliveryMapScreen(),
                          ),
                        );
                      },
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            color: declineOrder,
                            title: "Decline Order",
                            textColor: Colors.black54,
                            onPressed: () {
                              context.read<DeliveryProvider>().rejectOrder();
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: CustomButton(
                            title: "Accept Order",
                            onPressed: () {
                              context.read<DeliveryProvider>().acceptOrder();
                            },
                          ),
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }
}

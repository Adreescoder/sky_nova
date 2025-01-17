import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'logic.dart';

class WalletPage extends StatelessWidget {
  WalletPage({Key? key}) : super(key: key);

  final WalletLogic logic = Get.put(WalletLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/1122.jpg"), // Add your background image here
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          Column(
            children: [
              // Coins Section
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Your Coins",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Obx(() => Text(
                        "${logic.coins.value}",
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow,
                        ),
                      )),
                    ],
                  ),
                ),
              ),
              // Spacer to position Binance button slightly above the bottom
              SizedBox(height: 30),

              // Binance Link Container
              InkWell(
                onTap: () async {
                  final Uri url = Uri.parse('https://www.binance.com/activity/referral-entry/CPA?ref=CPA_00LR5THHCV');
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  } else {
                    Get.snackbar('Error', 'Could not launch the link.', snackPosition: SnackPosition.BOTTOM);
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/1.png', // Add your Binance logo here
                        height: 40,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Visit Binance",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom Padding
              SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}

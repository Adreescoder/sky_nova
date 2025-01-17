import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../wallet/logic.dart';

class GameScreen extends StatefulWidget {
  GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  final WalletLogic walletLogic = Get.put(WalletLogic());
  int battery = 1000;
  final int maxBattery = 1000;

  late AnimationController _bounceController;

  @override
  void initState() {
    super.initState();
    setupAnimations();
  }

  void setupAnimations() {
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  void onTap() {
    if (battery > 0) {
      walletLogic.incrementCoins(1);
      setState(() {
        battery--;
      });
    }
  }

  void navigateTogiftscreen() {
    /*  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GiftscreenPage(), // Navigate to GiftscreenPage
      ),
    );*/
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage("assets/1122.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/coin.png",
                            width: 50,
                            height: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Text(
                              '${walletLogic.coins.value}',
                              style: const TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
                Expanded(
                  child: Center(
                    child: GestureDetector(
                      onTapDown: (_) {
                        _bounceController.forward(from: 0.0);
                        onTap();
                      },
                      child: AnimatedBuilder(
                        animation: _bounceController,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: 1.0 - (_bounceController.value * 0.1),
                            child: Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 15,
                                  ),
                                ],
                              ),
                              child: Center(
                                  child: Image.asset("assets/hamster.png")),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Add the Positioned widget for the GIF button
            Positioned(
              top: 16,
              right: 16,
              child: GestureDetector(
                onTap: navigateTogiftscreen,
                child: Image.asset(
                  "assets/11.gif", // Replace with your GIF asset
                  width: 60,
                  height: 60,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }
}

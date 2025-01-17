import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'logic.dart';

class DailyRewardScreen extends StatefulWidget {
  DailyRewardScreen({super.key});

  final Daily_ClaimLogic logic = Get.put(Daily_ClaimLogic());

  @override
  State<DailyRewardScreen> createState() => _DailyRewardScreenState();
}

class _DailyRewardScreenState extends State<DailyRewardScreen> {
  int coins = 0;
  int lastDailyRewardDay = 0;
  int dailyRewardCycle = 0;
  final List<int> dailyRewards = [50, 100, 200, 300, 4000, 500, 600, 700];

  @override
  void initState() {
    super.initState();
    loadGameState();
  }

  Future<void> loadGameState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      coins = prefs.getInt('coins') ?? 0;
      lastDailyRewardDay = prefs.getInt('lastDailyRewardDay') ?? 0;
      dailyRewardCycle = prefs.getInt('dailyRewardCycle') ?? 0;
    });
  }

  Future<void> saveGameState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('coins', coins);
    await prefs.setInt('lastDailyRewardDay', lastDailyRewardDay);
    await prefs.setInt('dailyRewardCycle', dailyRewardCycle);
  }

  Future<void> claimDailyReward() async {
    final today = DateTime.now().day;
    if (today != lastDailyRewardDay) {
      setState(() {
        coins += dailyRewards[dailyRewardCycle];
        lastDailyRewardDay = today;
        dailyRewardCycle = (dailyRewardCycle + 1) % dailyRewards.length;
      });
      saveGameState();

      // Update the wallet coins
      widget.logic.walletLogic.incrementCoins(dailyRewards[dailyRewardCycle]);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width and height for responsive design
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple[900]!, Colors.black],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.05,
                bottom: screenHeight * 0.02,
              ),
              child: Text(
                'Daily Rewards',
                style: TextStyle(
                  fontSize: screenWidth * 0.07,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(screenWidth * 0.04),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: screenWidth > 600 ? 5 : 4,
                  crossAxisSpacing: screenWidth * 0.02,
                  mainAxisSpacing: screenHeight * 0.02,
                  childAspectRatio: screenWidth > 600 ? 1.0 : 0.9,
                ),
                itemCount: dailyRewards.length,
                itemBuilder: (context, index) {
                  final bool isToday = index == dailyRewardCycle;
                  final bool isPast = index < dailyRewardCycle;

                  return Card(
                    color: isToday
                        ? Colors.green
                        : (isPast ? Colors.grey[800] : Colors.blue[900]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Day ${index + 1}',
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                            color: isToday ? Colors.white : Colors.grey[400],
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          '${dailyRewards[index]}',
                          style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.bold,
                            color: isToday ? Colors.white : Colors.grey[400],
                          ),
                        ),
                        if (isPast)
                          Icon(Icons.check_circle,
                              color: Colors.green, size: screenWidth * 0.06),
                      ],
                    ),
                  )
                      .animate()
                      .fadeIn(delay: (index * 100).ms)
                      .scale(delay: (index * 100).ms);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: screenHeight * 0.04,
                top: screenHeight * 0.02,
              ),
              child: ElevatedButton(
                onPressed: claimDailyReward,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.2,
                    vertical: screenHeight * 0.02,
                  ),
                ),
                child: Text(
                  'CLAIM',
                  style: TextStyle(fontSize: screenWidth * 0.05),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Clipboard functionality ke liye
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/task.dart';
import '../wallet/logic.dart';
import 'logic.dart'; // WalletLogic import

class TasksScreen extends StatefulWidget {
  TasksScreen({super.key});
  final TaskScreenLogic logic = Get.put(TaskScreenLogic());

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final WalletLogic walletLogic =
      Get.find<WalletLogic>(); // WalletLogic instance
  final List<Task> tasks = [
    Task(
      title: 'Join Youtube Channel',
      description: 'Join our Youtube channel',
      reward: 100,
      url: 'https://www.youtube.com/channel/UCv4GSeaHpUA7OTuBoGTGGRQ',
      icon: Icons.telegram,
    ),
    Task(
      title: 'Join Whatsapp Group',
      description: 'Join our Whatsapp group',
      reward: 200,
      url: 'https://whatsapp.com/channel/0029Vb2oQAX0VycAnfZGno00',
      icon: Icons.group,
    ),
    Task(
      title: 'Join Telegram',
      description: 'Join us on Telegram',
      reward: 300,
      url: 'https://t.me/ra0745',
      icon: Icons.article,
    ),
  ];

  TextEditingController linkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadGameState();
    linkController.text = 'http://localhost:65448/';
  }

  @override
  void dispose() {
    linkController.dispose();
    super.dispose();
  }

  Future<void> loadGameState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      for (int i = 0; i < tasks.length; i++) {
        tasks[i].isCompleted = prefs.getBool('task_$i') ?? false;
      }
    });
  }

  Future<void> saveGameState() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < tasks.length; i++) {
      await prefs.setBool('task_$i', tasks[i].isCompleted);
    }
  }

  Future<void> completeTask(int index) async {
    if (!tasks[index].isCompleted) {
      final url = Uri.parse(tasks[index].url);

      // Open URL
      await launchUrl(url);

      // Reward increment logic
      setState(() {
        tasks[index].isCompleted = true;
        walletLogic.incrementCoins(tasks[index].reward); // Add task reward
      });

      // Save state
      saveGameState();
    }
  }

  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: linkController.text));
    Get.snackbar('Copied', 'Link copied to clipboard',
        snackPosition: SnackPosition.BOTTOM);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.indigo[900]!, Colors.black],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return Card(
                    color: Colors.blue[900]!.withOpacity(0.3),
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      leading: Icon(task.icon, color: Colors.white),
                      title: Text(
                        task.title,
                        style: const TextStyle(color: Colors.white),
                      ),
                      trailing: task.isCompleted
                          ? const Icon(Icons.check_circle, color: Colors.green)
                          : Text(
                              '+${task.reward}',
                              style: const TextStyle(
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      onTap: () => completeTask(index),
                    ),
                  )
                      .animate()
                      .fadeIn(delay: (index * 100).ms)
                      .slideX(delay: (index * 100).ms);
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextField(
                    controller: linkController,
                    decoration: InputDecoration(
                      labelText: 'http://localhost:65448/',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.content_copy),
                        onPressed: copyToClipboard,
                      ),
                    ),
                    readOnly: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
